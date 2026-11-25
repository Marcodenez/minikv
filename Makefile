
CC      := gcc
STD     := -std=gnu11
WARN    := -Wall -Wextra -Wpedantic -Wshadow
SAN     := -fsanitize=address,undefined -fno-omit-frame-pointer

MODE    ?= dev

ifeq ($(MODE),dev)
    OPT := -g -O0 $(SAN)
else ifeq ($(MODE),plain)
    OPT := -g -O0
else ifeq ($(MODE),release)
    OPT := -O2 -DNDEBUG
else
    $(error Unknown MODE '$(MODE)'. Use dev, plain or release)
endif

CFLAGS  := $(STD) $(WARN) $(OPT) -MMD -MP -Isrc
LDFLAGS := $(if $(filter dev,$(MODE)),$(SAN),)
BUILD   := build/$(MODE)

SERVER_SRC := $(wildcard src/*.c)
CLIENT_SRC := tools/minikv-cli.c

SERVER_OBJ := $(patsubst %.c,$(BUILD)/%.o,$(SERVER_SRC))
CLIENT_OBJ := $(patsubst %.c,$(BUILD)/%.o,$(CLIENT_SRC))

TEST_SRC := $(wildcard tests/test_*.c)
TEST_BIN := $(patsubst tests/%.c,$(BUILD)/tests/%,$(TEST_SRC))

.PHONY: all test valgrind format clean

ifeq ($(strip $(SERVER_SRC)),)
all:
	@echo "No server sources yet. Application build skipped."
else ifeq ($(wildcard $(CLIENT_SRC)),)
all:
	@echo "No client source yet. Application build skipped."
else
all: $(BUILD)/minikv $(BUILD)/minikv-cli
endif

$(BUILD)/minikv: $(SERVER_OBJ)
	@mkdir -p $(@D)
	$(CC) $^ $(LDFLAGS) -o $@

$(BUILD)/minikv-cli: $(CLIENT_OBJ)
	@mkdir -p $(@D)
	$(CC) $^ $(LDFLAGS) -o $@

$(BUILD)/%.o: %.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/tests/%: tests/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

test: $(TEST_BIN)
	@set -e; for t in $(TEST_BIN); do ./$$t; done

valgrind:
	$(MAKE) MODE=plain test
	@set -e; for t in $(patsubst tests/%.c,build/plain/tests/%,$(TEST_SRC)); do \
		valgrind --leak-check=full --error-exitcode=1 ./$$t; \
	done

format:
	clang-format -i $$(find src tools tests -type f \( -name '*.c' -o -name '*.h' \))

clean:
	rm -rf build/

-include $(shell find build -name '*.d' 2>/dev/null)
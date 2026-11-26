## 2026-11-25 (2 hours) Part 2, Setup and Toolchain

Did:
- Set up WSL2 Ubuntu and VS Code.
- Installed and verified development tools.
- Configured Git and GitHub SSH authentication.
- Created the MiniKV repository and pushed the initial commit.
- Completed C toolchain and debugging experiments.
- Created and tested the Makefile and smoke test.
- Verified dependency tracking.

Learned:
- I learned how to configure git and use GitHub for the first time, and learned how a Makefile works.

Stuck on:
- No major issues. Needed some guidance when configuring and understanding the Makefile.

Next:
- Begin Stage 0 warm-up exercises.

Question:
- What is the proper git and GitHub habit? and how to practice it?

## 2026-11-25 (5.5 hours) Stage 0, Tasks 1–7

Did:
- Completed the whole Part 2 checklist.
- Completed Exercise A (wc-lite).
- Completed Exercise B (multi-file C program).
- Completed Exercise C (growable integer array).
- Created and tested the Makefile.
- Checked dependency tracking.
- Created docs/LOG.md and docs/BUGS.md.

Learned:
- I learned how to use fopen(), fread(), and fclose() to read bytes from files by building wc-lite, a small command-line utility inspired by the Unix wc utility.
- I learned how multi-file C programs work, including how header files, function declarations, definitions, compilation, and linking work together.
- I learned how growable arrays work using malloc() and realloc(), and how to detect memory bugs using Valgrind and AddressSanitizer.

Stuck on:
- BUG-001: Heap-buffer-overflow in dynamic array.

Next:
- Stage 1: Core library.

Question:
- None.

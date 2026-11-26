## BUG-001 Heap-buffer-overflow in dynamic array (Stage 0, 15 min)

Symptom: Program attempted to write beyond allocated memory.

Root cause: Tried to access index 8 in an array allocated for 8 integers.

Found by: Valgrind and AddressSanitizer.

Fix: Corrected the condition on line 23 (compared the current count against the capacity instead of checking p[i] == size), introduced a separate variable to track the number of stored elements, and corrected the realloc() size calculation on line 26 (used size * sizeof(int) instead of size * 2).

Lesson: Array indexes must stay within allocated memory.

Catch sooner: Check the current element count against capacity before inserting an integer.
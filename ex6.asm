# Title:  AP2L0B Example 6. for loop	Filename: ex6.asm
# Author:  				Date:
# Description: Write the MIPS program for this C++ program.
#     int main()
#     {
#        int A[10] = {4, -1, 7, 10, 2, 8, -3, 5, 6, 1};
#        int N, sum = 0;
#        cin >> N;                // 0 to 10
#        for (int i = 0; i < N; i += 1) {
#           sum += A[i];
#        }
#        cout << sum;
#     }
#   Read N (syscall 5) into N. The for loop tests i < N BEFORE the body (slt + beq), so with
#   N = 0 the body never runs. Store sum (sw), then print it.
#   A = 0x10010000-0x10010024, N = 0x10010028, sum = 0x1001002C.
#   Keep the .data block as it is. Do not use the pseudo-instructions blt, bgt, ble, bge.
# Input:  N, from 0 to 10
# Output: sum   (and sum in memory after the run)
################# Data segment #####################
.data
	A:	.word	4, -1, 7, 10, 2, 8, -3, 5, 6, 1
	N:	.word	0
	sum:	.word	0
################# Code segment #####################
.text
.globl main
main:

	# TODO: implement

li $v0, 10  # Exit program
syscall

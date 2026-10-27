# Title:  AP2L0B Example 4. do-while loop	Filename: ex4.asm
# Author:  				Date:
# Description: Write the MIPS program for this C++ program.
#     int main()
#     {
#        int A[6] = {5, -2, 8, 10, 3, 6};
#        int N;
#        int step = 1, sum = 0, i = 0;
#        cin >> N;                // 1 to 6
#        do {
#           sum += A[i];
#           i += step;
#        } while (i != N);
#        cout << sum;
#     }
#   Read N (syscall 5) into N. The body runs first; the bne test is at the bottom.
#   A[i] is at the address of A + 4 * i (sll by 2 = times 4). Store sum (sw), then print it.
#   A = 0x10010000-0x10010014, N = 0x10010018, step = 0x1001001C, sum = 0x10010020.
#   Keep the .data block as it is. Do not use the pseudo-instructions blt, bgt, ble, bge.
# Input:  N, from 1 to 6
# Output: sum   (and sum in memory after the run)
################# Data segment #####################
.data
	A:	.word	5, -2, 8, 10, 3, 6
	N:	.word	0
	step:	.word	1
	sum:	.word	0
################# Code segment #####################
.text
.globl main
main:

	# TODO: implement

li $v0, 10  # Exit program
syscall

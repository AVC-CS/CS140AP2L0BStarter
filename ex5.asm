# Title:  AP2L0B Example 5. while loop	Filename: ex5.asm
# Author:  				Date:
# Description: Write the MIPS program for this C++ program.
#     int main()
#     {
#        int A[6] = {10, 20, 30, 40, 50, 60};
#        int k, i = 0;
#        cin >> k;                // 0 to 59
#        while (A[i] <= k) {
#           i += 1;
#        }
#        cout << i;
#     }
#   Read k (syscall 5) into k. The test comes first, so the body may run zero times.
#   A[i] <= k is false exactly when k < A[i]: test that with slt and leave the loop on true.
#   Store i (sw), then print it.
#   A = 0x10010000-0x10010014, k = 0x10010018, i = 0x1001001C.
#   Keep the .data block as it is. Do not use the pseudo-instructions blt, bgt, ble, bge.
# Input:  k, from 0 to 59
# Output: i   (and i in memory after the run)
################# Data segment #####################
.data
	A:	.word	10, 20, 30, 40, 50, 60
	k:	.word	0
	ival:	.word	0
################# Code segment #####################
.text
.globl main
main:

	# TODO: implement

li $v0, 10  # Exit program
syscall

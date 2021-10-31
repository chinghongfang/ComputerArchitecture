# cycles 417
# instrs.retired 279
# CPI 1.49
# IPC 0.669

.data
nums:    .word 1,5,10
numsSize:    .word 3
n: .word 2000000000

.text
# #include<stdio.h>
# // Greedy construct
# int minPatches(const int *, int, int);
# 
# int main(){
#     const int nums[] = {1,5,10};
#     const int numsSize = 3;
#     const int n = 2000000000;
#     printf("%d\n", minPatches(nums, numsSize, n));
#     return 0;
# }
# int minPatches(const int *nums, int numsSize, int n){ 
#     unsigned int m = 1, res = 0, i = 0;
#     while (m <= n)
#         m += (i < numsSize && nums[i] <= m) ? nums[i++] : (res++, m); 
#     return res;
# }

main:
    la     a0, nums         # s1 = nums[];  // array
    lw     a1, numsSize     # s2 = numsSize;     // length of the array
    lw     a2, n            # s3 = n;  // range upper bound
    jal    ra, minPatches   # Function call

    # a0 is the return value and also the value we want to print
    li     a7, 1            # print a0
    ecall
    li     a0, 0            # return 0
    li     a7, 10           # Exit code
    ecall                   
    
minPatches:
    addi   s0, x0, 1        # s0 = m
    addi   s1, x0, 0        # s1 = res
    addi   s2, x0, 0        # s2 = i
    bltu   a2, s0, exit     # m < n
    loop:
        slli   t0, s2, 2    # i*4
        add    t0, a0, t0   # nums + i*4
        lw     t0, (0)t0    # t0 = nums[i]
        bge    s2, a1, else # i >= numsSize
        bltu   s0, t0, else # m < nums[i]
        addi   s2, s2, 1    # ++i
        j      done         # jump out of if-else statement
        else:
        addi   s1, s1, 1    # ++res
        mv     t0, s0       # t0 = m
        done:
        add    s0, s0, t0   # m += nums[i] or m
        bgeu   a2, s0, loop # n <= m
exit:
    mv     a0, s1           # return value = res
    ret

.data
nums:    .word 1,5,10
numsSize:    .word 3
n: .word 2000000000



.text

#// Greedy construct
# int minPatches(int *, int, int);

# int main(){
#     const int nums[] = {1,5,10};
#     const int numsSize = 3;
#     const int n = 2000000000;
#     minPatches(nums, numsSize, target);
#     return 0;
# }
# 
# int minPatches(int *nums, int numsSize, int n){ 
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
    
minPatches:
    addi   s0, x0, 1        # s0 = m
    addi   s1, x0, 0        # s1 = res
    addi   s2, x0, 0        # s2 = i
    bgtu   a2, s0, exit     # n > m
    loop:
        slli   t0, s2, 2    # i*4
        add    t0, a0, t0   # nums + i*4
        lw     t0, (0)t0    # t0 = nums[i]
        bge    s2, a1, else # i >= numsSize
        bgtu   t0, s0, else # nums[i] > m
        addi   s2, s2, 1    # ++i
        j      done         # jump out of if-else statement
        else:
        addi   s1, s1, 1    # ++res
        mv     t0, s0       # t0 = m
        done:
        add    s0, s0, t0   # m += nums[i] or m
        bleu   s0, a2, loop # m <= n
exit:
    mv     a0, s1           # return value = res
    ret

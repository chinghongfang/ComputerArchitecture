.data
nums:   .word 1,5,10
len:    .word 3
target: .word 20

.text

#// Greedy construct
# int main(){
#   int nums[] = {1,5,10};
#   int len = 3;
#   int target = 20;
#
#   int ans = 0;
#   long now = 0;
#   int idx = 0;
#   while (now < target){
#       if (idx < len && (long)nums[idx] <= now+1){
#           now += nums[idx];
#           ++idx;
#       }else {
#           now += now+1;
#           ++ans;
#       }
#   }
#   printf("%d\n", ans);
#   return ans;
# }

main:
    la     s1, nums        # s1 = nums[];  // array
    lw     s2, len         # s2 = len;     // length of the array
    lw     s3, target      # s3 = target;  // range upper bound
    add    s4, zero, zero  # s4 = ans = 0; // set `ans` to 0
    add    s5, zero, zero  # s5, s6 represent `now`. A 64-bits integer.
    add    s6, zero, zero  # Set `now` to zero
    add    s7, zero, zero  # s7 = idx = 0; // set `idx` to 0
    
    while:
    bgt    s5, zero, exit  # now > target. s5 is more significant.
    bge    s6, s3, exit    # Check s6 >= s3 to break the while loop
        # if statment
        bge    s7, s2, else    # idx >= len
        lw     t0, (0)s1       # t0 = nums[idx]
        addi   t0, t0, -1      # t0 -= 1
        blt    zero, s5, if    # nums[idx]-1 < now
        bgt    t0, s6, else    # nums[idx]-1 > now
        if:
            # now += nums[0];   // In fact, now += nums[idx];
            add    a0, zero, s5    # do function call place argument
            add    a1, zero, s6    # do function call place argument
            add    a2, zero, zero  # do function call place argument
            lw     a3, (0)s1       # do function call place argument
            jal    ra, add_positive_long    # function call
            add    s5, zero, a0    # get return value
            add    s6, zero, a1    # get rerurn value
            addi   s1, s1, 4       # nums += 1
            addi   s7, s7, 1       # ++idx
            j      while           # Loop again
        else:
            add    a0, zero, s5    # do function call place argument
            add    a1, zero, s6    # do function call place argument
            add    a2, zero, s5    # do function call place argument
            addi   a3, s6, 1       # do function call place argument
            jal    ra, add_positive_long    # function call
            add    s5, zero, a0    # get return value
            add    s6, zero, a1    # get rerurn value
            addi   s4, s4, 1       # ++ans
            j      while           # Loop again
    
    exit:
    add    a0, s4, zero    # load print value
    li     a7, 1           # print a0
    ecall
    li      a7, 10         # exit
    ecall

add_positive_long:
    # a0a1 + a2a3
    add    a1, a1, a3      # Add lower bit. a1 = a1 + a3 
    bge    a1, zero, no_carry    # a1 becomes negative if overflow occurs.

    addi   a0, a0, 1       # Add 1 to higher bit
    # make mask: 0x7fff_ffff
    addi   t0, zero, 1     # t0 = 1
    slli   t0, t0, 31      # t0 = 0x8000_0000
    not    t0, t0          # t0 = 0x7fff_ffff
    # clear sign bit
    and    a1, a1, t0      # a1 = a1 & 0x7fff_ffff
    
    no_carry:
    add    a0, a0, a2      # a0 = a0 + a2
    ret

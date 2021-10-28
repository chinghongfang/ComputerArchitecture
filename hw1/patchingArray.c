/**
 * LeetCode 330. Patching Array
 * Given a sorted integer array nums and an integer n, add/patch elements to 
 * the array such that any number in the range [1, n] inclusive can be formed 
 * by the sum of some elements in the array.
 *
 * Return the minimum number of patches required.
 * 
 * Thought:
 *   1. Start from 1(now), check if the number is in the sorted array.
 *      Add if not.
 *   2. All numbers in range [1, now] can be formed by patching and part of
 *      the `nums`. Then all numbers in range [1, now+nums[i]] can be formed.
 *      0(or 1) < i < {length of nums}
 *   3. Keep update `now` by checking the number in nums to get broader range.
 */

#include<stdio.h>
// Greedy construct
int minPatches(const int *, int, int);

int main(){
    const int nums[] = {1,5,10};
    const int numsSize = 3;
    const int n = 2000000000;
    printf("%d\n", minPatches(nums, numsSize, n));
    return 0;
}

// Using unsigned is enough.
int minPatches(const int *nums, int numsSize, int n){ 
    unsigned int m = 1, res = 0, i = 0;
    while (m <= n)
        // check is there any gap between [1, m] and [nums[idx], nums[idx]+now]
        //     if there is no gap, use nums[idx].
        //     else use the best number we can use
        m += (i < numsSize && nums[i] <= m) ? nums[i++] : (res++, m); 
    return res;
}

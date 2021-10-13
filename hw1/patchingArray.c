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
int main()
{
    int nums[] = {1, 5, 10};     // Numbers we have.
    int len = 3;                // The length of the array
    int target = 20;            // The upper bound of the range

    int ans = 0;                // Number of patches we need
    long now = 0;               // The range of number we can form now
    int idx = 0;                // The `nums` index we have consumed 
    while (now < target) {
        // check not out of bound
        // check is there any gap between 
        //   [1, now] and [nums[idx], nums[idx]+now] 
        if (idx < len && (long) nums[idx] <= now + 1) {
            // Update the range we can form the number
            now += nums[idx];
            ++idx;
        } else {
            // Fill the gap with n+1 (The optimal choice.)
            now += now + 1;
            ++ans;
        }
    }
    printf("%d\n", ans);
    return 0;
}

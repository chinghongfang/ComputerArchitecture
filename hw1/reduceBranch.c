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
    //while (m <= n)
        // check is there any gap between [1, m] and [nums[idx], nums[idx]+now]
        //     if there is no gap, use nums[idx].
        //     else use the best number we can use
        //m += (i < numsSize && nums[i] > m) ? nums[i++] : (res++, m); 
    if (m > n) return 0;

select_add:
    if (i >= numsSize) goto only_plus_m;

    if (nums[i] > m) goto plus_m;
    m += nums[i++];
    if (m > n) goto ret;
    goto select_add;
plus_m:
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    goto select_add;

only_plus_m:
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;

    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;

    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;
    m <<= 1;
    ++res;
    if (m > n) goto ret;

ret:
    return res;
}

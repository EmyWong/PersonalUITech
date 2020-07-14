//
//  main.m
//  sortDemo
//
//  Created by Emy on 2020/5/10.
//  Copyright © 2020 Emy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <limits.h>
#include <stdio.h>

int cal(int n) {
    int sum = 0;
    int i = 1;
    for (;i <= n; i++) {
        printf("%d ",i);
        sum = sum + i;
    }
    printf("\nsum = %d",sum);
    return sum;
}

int cal2(int n) {
    int sum = 0;
    int i = 1;
    int j = 1;
    for (;i <= n; i++) {
        printf ("%d ",i);
        j = 1;
        for (;j <= n; j++) {
            sum = sum + i;
        }
    }
    printf("\nsum = %d",sum);
    return sum;
}

void insert(int val, int count, int array[], int length) {
    if (count == length) {
        int sum = 0;
        for (int i = 0; i < length; ++i) {
            sum = sum + array[i];
        }
        array[0] = sum;
        count = 1;
    }
    array[count] = val;
    ++count;
}

int calOneHundrend() {
    int i,sum = 0,n = 100;
    for (i = 1; i < n; i++) {
        sum = sum + i;
    }
    printf("%d",sum);
    return sum;
}


//输出数组
void printArray(char *type,int array[], int count) {
    printf("%s:",type);
    for (int n = 0; n < count; n++) {
                  printf("%d ",array[n]);
              }
    printf("\n");
}


//冒泡排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(n^2)
// 最优时间复杂度 ---- 如果能在内部循环第一次运行时,使用一个旗标来表示有无需要交换的可能,可以把最优时间复杂度降低到O(n)
// 平均时间复杂度 ---- O(n^2)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 稳定
void BubbleSort(int array[], int count) {
       for (int i = 0; i < count - 1; i++) {
           for (int j = 0; j < count - 1 - i; j++) {
               if (array[j] > array[j+1]) {
                   int temp = array[j];
                   array[j] = array[j+1];
                   array[j+1] = temp;
               }
           }
       }
    printArray("冒泡排序",array, count);
}

//冒泡排序OC写法
void OCBubbleSort(NSMutableArray *array) {
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - i - 1; j++) {
            if ([array[j] intValue] < [array[j + 1] intValue]) {
                [array exchangeObjectAtIndex:j + 1 withObjectAtIndex:j];
            }
        }
    }
    NSLog(@"%@",array);
}

//鸡尾酒排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(n^2)
// 最优时间复杂度 ---- 如果序列在一开始已经大部分排序过的话,会接近O(n)
// 平均时间复杂度 ---- O(n^2)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 稳定
void CockTailSort (int array[], int count) {
    int left = 0;
    int right = count - 1; //初始化边界
    while (left < right) {
        for (int i = left; i < right; i++) { //前半轮，将最大元素排到最后
            if (array[i] > array[i + 1]) {
                int temp = array[i];
                array[i] = array[i + 1];
                array[i + 1] = temp;
            }
        }
        right--;
        for (int i = right; i > left; i--) { //后半轮，将最小元素放在前面
            if (array[i - 1] > array[i]) {
                int temp = array[i - 1];
                array[i - 1] = array[i];
                array[i] = temp;
            }
        }
        left++;
    }
    printArray("鸡尾酒排序",array, count);
}

//鸡尾酒排序OC写法
void OCCockTailSort(NSMutableArray *array) {
    int left = 0;
    int right = (int)(array.count - 1);
    while (left < right) {
        for (int i = left; i < right; i++) {
            if ([array[i] intValue] > [array[i + 1] intValue]) {
                [array exchangeObjectAtIndex:i + 1 withObjectAtIndex:i];
            }
        }
        right--;
        for (int i = right; i > left; i--) {
            if ([array[i - 1] intValue] > [array[i] intValue]) { //如果前面的元素大于后面的元素 调换位置 将小的调到前面
                [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
        left++;
    }
    NSLog(@"%@",array);
}

//选择排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(n^2)
// 最优时间复杂度 ---- O(n^2)
// 平均时间复杂度 ---- O(n^2)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 不稳定
void SelectionSort(int array[], int count) {
    for (int i = 0; i < count - 1; i++) { //i是已排序序列的末尾
        int min = i;
        for (int j = i + 1; j < count; j++) { //未排序序列
            if (array[j] < array[min]) {
                min = j; //找出未排序序列的最小值
            }
        }
        if (min != i) {
            int temp = array[min];
            array[min] = array[i];
            array[i] = temp; // 放到已排序序列的末尾，该操作很有可能把稳定性打乱，所以选择排序是不稳定的排序算法
        }
    }
    printArray("选择排序",array, count);
}

//选择排序OC写法
void OCSelectionSort(NSMutableArray *array) {
    for (int i = 0; i < array.count - 1; i++) {
        int min = i;
        for (int j = i + 1; j < array.count; j++) {
            if ([array[j] intValue] < [array[min] intValue]) {
                min = j;
            }
        }
        if (min != i) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:min];
        }
    }
    NSLog(@"%@",array);
}

//插入排序
// 分类 ------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- 最坏情况为输入序列是降序排列的,此时时间复杂度O(n^2)
// 最优时间复杂度 ---- 最好情况为输入序列是升序排列的,此时时间复杂度O(n)
// 平均时间复杂度 ---- O(n^2)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 稳定
void InsertionSort(int array[], int count) {
    for (int i = 1; i  < count; i++) { //类似扑克牌排序
        int get = array[i]; //抓到的牌需要和已经排好序的牌比较
        int j = i - 1; //排好序的牌最后一张
        while (j >= 0 && array[j] > get) {
            array[j + 1] = array[j];
            j--; //继续向前推进
        }
        array[j + 1] = get; //直到没有比get大的牌了，就把get插入到后面一个的位置上。
    }
    printArray("插入排序",array, count);
}
//插入排序OC写法
void OCInsertionSort(NSMutableArray *array) {
    for (int i = 1; i < array.count; i++) {
        int get = [array[i] intValue];;
        int j = i - 1;
        while (j >= 0 && [array[j] intValue] > get) {
            [array exchangeObjectAtIndex:j + 1 withObjectAtIndex:j];
            j--;
        }
    }
    NSLog(@"%@",array);
}

//二分插入排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(n^2)
// 最优时间复杂度 ---- O(nlogn)
// 平均时间复杂度 ---- O(n^2)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 稳定
void InsertionSortDichotomy(int array[], int count) {
    for (int i = 0; i < count; i++) {
        int get = array[i];
        int left = 0;//边界
        int right = i - 1;
        
        while (left <= right) {
            int mid = (left + right) / 2;
            if (array[mid] > get) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        
        for (int j = i - 1; j >= left; j--) {
            array[j + 1] = array[j];
        }
        array[left] = get;
    }
    printArray("二分插入排序",array, count);
}

//二分插入排序OC写法
void OCInsertionSortDichotomy(NSMutableArray *array) {
    for (int i = 1; i < array.count; i++) {
        int get = [array[i] intValue];
        int left = 0;
        int right = i - 1;
        while (left <= right) {
            int mid = (left + right) / 2;
            if ([array[mid] intValue] > get) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        for (int j = i - 1; j >= left; j--) {
            [array exchangeObjectAtIndex:j + 1 withObjectAtIndex:j];
        }
    }
    NSLog(@"%@",array);
}

// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- 根据步长序列的不同而不同。已知最好的为O(n(logn)^2)
// 最优时间复杂度 ---- O(n)
// 平均时间复杂度 ---- 根据步长序列的不同而不同。
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 不稳定
//希尔排序
void ShellSort(int array[], int count) {
    int d = 0;
    while (d <= count) {
        d = 3 * d + 1;
    }
    
    while (d >= 1) {
        for (int i = d; i < count; i++) {
            int get = array[i];
            int j = i - d;
            while (j >= 0 && array[j] > get) {
                array[j + d] = array[j];
                j = j - d;
            }
            array[j + d] = get;
        }
        d = (d - 1) / 3;
    }
    printArray("希尔排序",array, count);
}

//希尔排序OC写法
void OCShellSort(NSMutableArray *array) {
    int d = 0;
    while (d <= array.count) {
        d = d * 3 + 1;
    }
    
    while (d >= 1) {
        for (int i = d; i < array.count; i++) {
            int get = [array[i] intValue];
            int j = i - d;
            while (j >= 0 && [array[j] intValue] > get) {
                [array exchangeObjectAtIndex:j + d withObjectAtIndex:j];
                j = j - d;
            }
        }
        d = (d - 1) / 3;
    }
    NSLog(@"%@",array);
}

//归并排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(nlogn)
// 最优时间复杂度 ---- O(nlogn)
// 平均时间复杂度 ---- O(nlogn)
// 所需辅助空间 ------ O(n)
// 稳定性 ------------ 稳定
void Merge(int array[], int left, int mid, int right) { //合并两个数组 left - mid mid+1 - right
    int len = right - left + 1;
    int *temp = malloc(len * sizeof(int)); // 辅助空间O(n)
    int index = 0;
    int i = left; // 前一数组的起始元素
    int j = mid + 1; // 后一数组的起始元素
    while (i <= mid && j <= right) {
        temp[index++] = array[i] <= array[j] ? array[i++] : array[j++];
    }
    while (i <= mid) {
        temp[index++] = array[i++];
    }
    while (j <= right) {
        temp[index++] = array[j++];
    }
    for (int k = 0; k < len; k++) {
        array[left++] = temp[k];
    }
    free(temp);
}


//将数组一直对半分，直到分成长度为1
void DivideArray(int array[], int left, int right) {
    int mid = (left + right) / 2;
    if (left >= right) {
        return;
    }
    DivideArray(array, left, mid);
    DivideArray(array, mid + 1, right);
    
    Merge(array, left, mid, right);
}


//堆排序
// 分类 -------------- 内部比较排序
// 数据结构 ---------- 数组
// 最差时间复杂度 ---- O(nlogn)
// 最优时间复杂度 ---- O(nlogn)
// 平均时间复杂度 ---- O(nlogn)
// 所需辅助空间 ------ O(1)
// 稳定性 ------------ 不稳定
void Heapify(int array[], int i,int size) {
    int left_child = 2 * i + 1;// 左孩子索引
    int right_child = 2 * i + 2;//右孩子索引
    int max = i;// 选出当前结点与其左右孩子三者之中的最大值

    if (left_child < size && array[left_child] > array[max]) {
        max = left_child;
    }
    if (right_child < size && array[right_child] > array[max]) {
        max = right_child;
    }
    if (max != i) {
        int temp = array[i];
        array[i] = array[max];
        array[max] = temp; // 把当前结点和它的最大(直接)子节点进行交换
        Heapify(array, max, size);// 递归调用，继续从当前结点向下进行堆调整
    }
}

int BuildHeap(int array[], int count) {
    int heap_size = count;
    //heap_size / 2是找到了非叶子结点有几个，每一个非叶子结点要建一个大顶堆
    for (int i = heap_size / 2 - 1; i >= 0; i--) {
        Heapify(array, i, heap_size);
    }
    return heap_size;
}

void HeapSort(int array[], int count) {
    // 建立一个大顶堆
    int heap_size = BuildHeap(array, count);
    // 堆（无序区）元素个数大于1，未完成排序
    while (heap_size > 1) {
        int i = --heap_size;
        int temp = array[0];
        array[0] = array[i];
        array[i] = temp;// 将堆顶元素与堆的最后一个元素互换，并从堆中去掉最后一个元素
        Heapify(array, 0, heap_size);// 从新的堆顶元素开始向下进行堆调整，时间复杂度O(logn)
    }
}

//快速排序
// 分类 ------------ 内部比较排序
// 数据结构 --------- 数组
// 最差时间复杂度 ---- 每次选取的基准都是最大（或最小）的元素，导致每次只划分出了一个分区，需要进行n-1次划分才能结束递归，时间复杂度为O(n^2)
// 最优时间复杂度 ---- 每次选取的基准都是中位数，这样每次都均匀的划分出两个分区，只需要logn次划分就能结束递归，时间复杂度为O(nlogn)
// 平均时间复杂度 ---- O(nlogn)
// 所需辅助空间 ------ 主要是递归造成的栈空间的使用(用来保存left和right等局部变量)，取决于递归树的深度，一般为O(logn)，最差为O(n)
// 稳定性 ---------- 不稳定
int Partition(int array[], int left, int right) {
    int pivot = array[right];               // 这里每次都选择最后一个元素作为基准
    int tail = left - 1;                // tail为小于基准的子数组最后一个元素的索引
    for (int i = left; i < right; i++)  // 遍历基准以外的其他元素
    {
        if (array[i] <= pivot)              // 把小于等于基准的元素放到前一个子数组末尾
        {
            int j = ++tail;
            int temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
    }
    int temp = array[tail + 1];
    array[tail + 1] = array[right];
    array[right] = temp;
        // 最后把基准放到前一个子数组的后边，剩下的子数组既是大于基准的子数组
                                        // 该操作很有可能把后面元素的稳定性打乱，所以快速排序是不稳定的排序算法
    return tail + 1;                    // 返回基准的索引
}

void QuickSort(int array[], int left, int right) {
    if (left > right) {
        return;
    }
    int pivot_index = Partition(array, left, right);
    QuickSort(array, left, pivot_index - 1);
    QuickSort(array, pivot_index + 1, right);
}

int main(int argc, char * argv[]) {
    
    int numbers[6] = {4,14,88,22,60,35};

    int count = sizeof(numbers) / sizeof(numbers[0]);
    //冒泡排序C语言写法
    BubbleSort(numbers, count);
    
//    NSMutableArray *numbers2 = [@[@4,@14,@88,@22,@60,@35] mutableCopy];
    //冒泡排序OC写法
//    OCBubbleSort(numbers2);
    
    //鸡尾酒排序
    CockTailSort(numbers, count);
    //鸡尾酒排序OC写法
//    OCCockTailSort(numbers2);
    
    //选择排序
    SelectionSort(numbers, count);
    //选择排序OC写法
//    OCSelectionSort(numbers2);
    
    //插入排序
    InsertionSort(numbers, count);
    //插入排序OC算法
//    OCInsertionSort(numbers2);
    
    //二分插入排序
    InsertionSortDichotomy(numbers, count);
    //二分插入排序OC写法
//    OCInsertionSortDichotomy(numbers2);
    
    //希尔排序
    ShellSort(numbers, count);
    //希尔排序OC写法
//    OCShellSort(numbers2);
    
    //归并排序
    DivideArray(numbers, 0, count - 1);
    printArray("归并排序",numbers, count);

    //堆排序
    HeapSort(numbers, count);
    printArray("堆排序",numbers, count);

    //快速排序
    QuickSort(numbers, 0, 5);
    printArray("快速排序",numbers, count);

   return 0;

}



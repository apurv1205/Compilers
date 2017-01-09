/*
Test file to check the yacc parser for our compiler
The code below contains three programs:
    - Quicksort implementation
    - Nth fibonacci number using dynamic programming
    - 0-1 knapsack problem using dynamic programming
    - and some custom codes for ensuring complete and intensive check of our syntax analyzer
The custom code is written such that its syntax remains correct and all possible keywords, statements and expressions are used
for intensive and complete testing of our syntax analyzer
*/




/* C implementation QuickSort */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NIL -1
#define MAX 100
// A utility function to swap two elements
void swap(int* a, int* b)
{
    int t = *a;
    *a = *b;
    *b = t;
}
 
/* This function takes last element as pivot, places
   the pivot element at its correct position in sorted
    array, and places all smaller (smaller than pivot)
   to left of pivot and all greater elements to right
   of pivot */
int partition (int arr[], int low, int high)
{
    int pivot = arr[high];    // pivot
    int i = (low - 1);  // Index of smaller element
 
    for (int j = low; j <= high- 1; j++)
    {
        // If current element is smaller than or
        // equal to pivot
        if (arr[j] <= pivot)
        {
            i++;    // increment index of smaller element
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}
 
/* The main function that implements QuickSort
 arr[] --> Array to be sorted,
  low  --> Starting index,
  high  --> Ending index */
void quickSort(int arr[], int low, int high)
{
    if (low < high)
    {
        /* pi is partitioning index, arr[p] is now
           at right place */
        int pi = partition(arr, low, high);
 
        // Separately sort elements before
        // partition and after partition
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}
 
/* Function to print an array */
void printArray(int arr[], int size)
{
    int i;
    for (i=0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}
 
// Driver program to test above functions












/*
Program for nth fibonacci number using dynamic programming
*/
 
int lookup[MAX];
 
/* Function to initialize NIL values in lookup table */
void _initialize()
{
  int i;
  for (i = 0; i < MAX; i++)
    lookup[i] = NIL;
}
 
/* function for nth Fibonacci number */
inline int fib(int n)
{
   if (lookup[n] == NIL)
   {
      if (n <= 1)
         lookup[n] = n;
      else
         lookup[n] = fib(n-1) + fib(n-2);
   }
 
   return lookup[n];
}





/*
Auxillary functions for 0-1 knapsack problem taken from the site geeksforgeeks.com for ensuring syntactically correct code 
*/


// A utility function that returns maximum of two integers
int max(int a, int b) { return (a > b)? a : b; }
 
// Returns the maximum value that can be put in a knapsack of capacity W
int knapSack(int W, int wt[], int val[], int n)
{
   int i, w;
   int K[n+1][W+1];
 
   // Build table K[][] in bottom up manner
   for (i = 0; i <= n; i++)
   {
       for (w = 0; w <= W; w++)
       {
           if (i==0 || w==0)
               K[i][w] = 0;
           else if (wt[i-1] <= w)
                 K[i][w] = max(val[i-1] + K[i-1][w-wt[i-1]],  K[i-1][w]);
           else
                 K[i][w] = K[i-1][w];
       }
   }
 
   return K[n][W];
}



int main()
{
    int arr[] = {10, 7, 8, 9, 1, 5};
    int n = sizeof(arr)/sizeof(arr[0]);
    quickSort(arr, 0, n-1);
    printf("Sorted array: \n");
    printArray(arr, n);

    //driver for nth fibonacci problem
    int n1 = 40;
    _initialize();
    printf("Fibonacci number is %d ", fib(n1));


    //driver for 0-1 knapsack problem using dynamic programming
    int val[] = {60, 100, 120};
    int wt[] = {10, 20, 30};
    int  W = 50;
    int n = sizeof(val)/sizeof(val[0]);
    printf("%d", knapSack(W, wt, val, n));

    /*Some other random code snippets for intensive and complete checking of  the syntax analyser of our compiler*/
    auto float abcd = -45.56 ;
    volatile int defg = 89;
    char text[100];
    text="Hello World!\n";
    const char ch='a';
    extern short int a=(5^7)|9;
    signed int b=-a;
    unsigned long c= a+b;

    int i=0;
    for(i=0;i<50;i++) {
        switch(i) {
            case(1) : continue;
            case(2) : break;
            default : return -1;
        }
    }

    i++;
    i--;
    i=i*i;
    i=i-5;
    if (i&&0||!i) i=i+50;

    if(i==0) { i=i*i; }
    i=i%2;
    i= (((i>>5)<<8)+9)-100;
    i=8^5;

    if(i > 10) {i%=20;}
    else if (i < -10) i+=5;
    else i-=7;
    i<<=5;
    i>>=2;
    i&=21;
    i^=12;

    do{
    auto int j=0,k=0;
    j|=i;
    i--;
    if(j>i) break;
    }
    while(i||i+10);

    i=sizeof(char);
    _Bool   a;
    _Complex    b;
    _Imaginary  c;

    enum days;

    return 0;
}
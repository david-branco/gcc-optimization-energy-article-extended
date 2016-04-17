#import <Foundation/Foundation.h>
#import "sorts.h"

#define N 8000


void initalize_array (NSMutableArray *arr)
{
    NSUInteger i;

    srand( (unsigned)time( NULL ) );
    for (i = 0; i < N; i++) {
        [arr addObject:[NSNumber numberWithInt: rand()]];
    }
}


int main()
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    NSMutableArray *arr = [NSMutableArray array]; 

    initalize_array(arr);   
    selectionSort(arr);
    //NSLog(@"%@",[arr description]);

    initalize_array(arr);   
    insertionSort(arr);
    //NSLog(@"%@",[arr description]);

    initalize_array(arr);   
    heapSort(arr);
    //NSLog(@"%@",[arr description]);

    initalize_array(arr);   
    quickSort(arr);
    //NSLog(@"%@",[arr description]);

    initalize_array(arr);   
    mergeSort(arr);
    //NSLog(@"%@",[arr description]);

    initalize_array(arr);   
    bubbleSort(arr);
    //NSLog(@"%@",[arr description]);

    
    NSLog(@"END\n");
    [pool drain];
    return 0;
}
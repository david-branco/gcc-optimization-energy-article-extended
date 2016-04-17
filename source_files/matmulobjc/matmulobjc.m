#import <Foundation/Foundation.h>
#include <time.h>
#include <stdlib.h>


int main()
{
	int N = 800;
	int i, j, k, aux;
	int a[N][N], b[N][N], c[N][N]; 

	srand((unsigned int) time(NULL));

	//INIT
	for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }

    //PRINT
    //for (i = 0; i < N; i++) {
    //    for (j = 0; j < N; j++) {
    //      NSLog(@"a[%d][%d] = %d\n", i, j ,a[i][j]);
    //      NSLog(@"b[%d][%d] = %d\n", i, j ,b[i][j]);
    //      NSLog(@"c[%d][%d] = %d", i, j ,c[i][j]);
    //    }
    //}
    

    //FORM 1
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {

            aux = 0;

            for (k = 0; k < N; k++)
                aux += a[i][k] * b[k][j];

            c[i][j] = aux;
        }
    }

    //INIT
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }
    


    //FORM 2
    for (j = 0; j < N; j++) {
        for (i = 0; i < N; i++) {

            aux = 0;

            for (k = 0; k < N; k++)
                aux += a[i][k] * b[k][j];

            c[i][j] = aux;
        }
    }

    //INIT
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }

    //FORM 3
    for (k = 0; k < N; k++) {
        for (i = 0; i < N; i++) {

            aux = a[i][k];

            for (j = 0; j < N; j++)
                c[i][j] += aux * b[k][j];
        }
    }

    //INIT
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }

    //FORM 4
    for (i = 0; i < N; i++) {
        for (k = 0; k < N; k++) {

            aux = a[i][k];

            for (j = 0; j < N; j++)
                c[i][j] += aux * b[k][j];
        }
    }

    //INIT
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }

    //FORM 5
    for (j = 0; j < N; j++) {
        for (k = 0; k < N; k++) {

            aux = b[k][j];

            for (i = 0; i < N; i++)
                c[i][j] += a[i][k] * aux;
        }
    }

    //INIT
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            a[i][j] = (int) rand() % 1000; 
            b[i][j] = (int) rand() % 1000; 
            c[i][j] = 0; 
        }
    }

    //FORM 6
    for (k = 0; k < N; k++) {
        for (j = 0; j < N; j++) {

            aux = b[k][j];

            for (i = 0; i < N; i++)
                c[i][j] += a[i][k] * aux;
        }
    }

    //PRINT
    //for (i = 0; i < N; i++) {
    //    for (j = 0; j < N; j++) {
    //    	NSLog(@"a[%d][%d] = %d\n", i, j ,a[i][j]);
    //    	NSLog(@"b[%d][%d] = %d\n", i, j ,b[i][j]);
    //    	NSLog(@"c[%d][%d] = %d", i, j ,c[i][j]);
    //    }
    //}

    NSLog(@"END\n");   

	return 0;
}

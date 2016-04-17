
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024

void ijk(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float sum;

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {

            sum = 0.0;

            for (k = 0; k < n; k++)
                sum += a[i][k] * b[k][j];

            c[i][j] = sum;

        }
    }

}

void jik(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float sum;

    for (j = 0; j < n; j++) {
        for (i = 0; i < n; i++) {

            sum = 0.0;

            for (k = 0; k < n; k++)
                sum += a[i][k] * b[k][j];

            c[i][j] = sum;

        }
    }

}

void kij(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float r;

    for (k = 0; k < n; k++) {
        for (i = 0; i < n; i++) {

            r = a[i][k];

            for (j = 0; j < n; j++)
                c[i][j] += r * b[k][j];

        }
    }

}

void ikj(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float r;

    for (i = 0; i < n; i++) {
        for (k = 0; k < n; k++) {

            r = a[i][k];

            for (j = 0; j < n; j++)
                c[i][j] += r * b[k][j];

        }
    }

}

void jki(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float r;

    for (j = 0; j < n; j++) {
        for (k = 0; k < n; k++) {

            r = b[k][j];

            for (i = 0; i < n; i++)
                c[i][j] += a[i][k] * r;

        }
    }

}

void kji(float (*a)[N], float (*b)[N], float (*c)[N], int n) {

    int i, j, k;
    float r;

    for (k = 0; k < n; k++) {
        for (j = 0; j < n; j++) {

            r = b[k][j];

            for (i = 0; i < n; i++)
                c[i][j] += a[i][k] * r;

        }
    }

}

void initVal(float (*ret)[N], float val, int n) {

    int i, j;

    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            ret[i][j] = val;
        }
    }

}

void initRandom(float (*ret)[N], int n) {

    int i, j;

    srand((unsigned int) time(NULL));

    for (i = 0; i < n; i++) {

        for (j = 0; j < n; j++) {
            ret[i][j] = (float) rand() / (float) (RAND_MAX / 1000); // limite = 1000
        }
    }

}

int main() {

    float (*matA)[N] = malloc(sizeof (float) * N * N);
    float (*matB)[N] = malloc(sizeof (float) * N * N);
    float (*matC)[N] = malloc(sizeof (float) * N * N);
    
    //int i, j;

    initRandom(matA, N);
    initVal(matB, 1, N);
    initVal(matC, 0, N);

    ijk(matA, matB, matC, N);
    jik(matA, matB, matC, N);
    kij(matA, matB, matC, N);
    ikj(matA, matB, matC, N);
    jki(matA, matB, matC, N);
    kji(matA, matB, matC, N);

    /*for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            printf("%f ", matC[i][j]);
        }
        printf("\n");
    }*/

    return 0;

}


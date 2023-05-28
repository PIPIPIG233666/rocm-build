
#include <hipblas/hipblas.h>
#include <cstdio>

int main()
{
    printf("[hipBLAS]    %d %d %d\n", hipblasVersionMajor, hipblaseVersionMinor, hipblasVersionPatch);
    return 0;
}



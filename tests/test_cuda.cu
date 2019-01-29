#include <stdio.h>
#include <driver_types.h>
#include <curand_mtgp32_kernel.h>

// KERNEL
__global__ void square(float *d_out, float *d_in){
    int idx = threadIdx.x;
    float f = d_in[idx];
//    d_out[idx] = f*f;
    d_out[idx] = f*f*f;
}

int main(){
//    const int ARRAY_SIZE = 64;
    const int ARRAY_SIZE = 96;
    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);

    //input array on host
    float *h_in = (float*) std::malloc(ARRAY_BYTES);
    for (int i = 0; i < ARRAY_SIZE; i++){
        h_in[i] = float(i);
    }

    float *h_out = (float*) std::malloc(ARRAY_BYTES);

    // GPU pointers
    float * d_in;
    float * d_out;

    // Allocate GPU
    cudaMalloc((void **) &d_in, ARRAY_BYTES);
    cudaMalloc((void **) &d_out, ARRAY_BYTES);

    // Move from cpu to gpu
    cudaMemcpy(d_in, h_in, ARRAY_BYTES, cudaMemcpyHostToDevice);

    // Launch a kernel
    square<<<1, ARRAY_SIZE>>>(d_out, d_in);

    // copy back to cpu
    cudaMemcpy(h_out, d_out, ARRAY_BYTES, cudaMemcpyDeviceToHost);

    // Print array
    for (int i = 0; i < ARRAY_SIZE; i++){
        printf("%.0f", h_out[i]);
        printf(((i % 4) != 3) ? "\t": "\n");
    }

    cudaFree(d_in);
    cudaFree(d_out);

    std::free(h_in);
    std::free(h_out);

    return 0;
}
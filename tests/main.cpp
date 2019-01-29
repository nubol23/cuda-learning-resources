#include <iostream>

int main() {
    int n = 64;
    int *v = (int*) malloc(n * sizeof(int));
    for (int i = 0; i < n; i++){
        v[i] = i;
    }

    for (int i = 0; i < n; i++){
        v[i] = i*i;
    }

    for (int i = 0; i < n; i++){
        printf("%d\n", v[i]);
    }

    free(v);
    return 0;
}
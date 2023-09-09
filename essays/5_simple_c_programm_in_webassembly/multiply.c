#include <stdio.h>

int multiply(int a, int b) {
    return a * b;
}

int main() {
    int a = 2;
    int b = 21;
    int result = multiply(a, b);
    printf("%d * %d = %d\n", a, b, result);
    return 0;
}
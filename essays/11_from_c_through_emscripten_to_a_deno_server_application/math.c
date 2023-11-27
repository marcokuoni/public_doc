#include <emscripten.h>

EMSCRIPTEN_KEEPALIVE
int mul(int a, int b) {
    return a * b;
}

EMSCRIPTEN_KEEPALIVE
int div(int a, int b) {
    return a / b;
}
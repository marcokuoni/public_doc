DEPS = 
OBJ = hello_world.o
NANOLIBC_OBJ = $(patsubst %.cpp,%.o,$(wildcard nanolibc/*.cpp))
OUTPUT = hello_world.wasm

COMPILE_FLAGS = -Wall \
		--target=wasm32 \
		-Os \
		-nostdlib \
		-fvisibility=hidden \
		-std=c++14 \
		-ffunction-sections \
		-fdata-sections \
		-DPRINTF_DISABLE_SUPPORT_FLOAT=1 \
		-DPRINTF_DISABLE_SUPPORT_LONG_LONG=1 \
		-DPRINTF_DISABLE_SUPPORT_PTRDIFF_T=1

$(OUTPUT): $(OBJ) $(NANOLIBC_OBJ) Makefile
	wasm-ld \
		-o $(OUTPUT) \
		--no-entry \
		--strip-all \
		--export-dynamic \
		--allow-undefined \
		--initial-memory=131072 \
		-error-limit=0 \
		--lto-O3 \
		-O3 \
		--gc-sections \
		$(OBJ) \
		$(LIBCXX_OBJ) \
		$(NANOLIBC_OBJ)


%.o: %.cpp $(DEPS) Makefile nanolibc/libc.h nanolibc/libc_enviroment.h
	clang++ \
		-c \
		$(COMPILE_FLAGS) \
		-o $@ \
		$<

hello_world.wat: $(OUTPUT) Makefile
	wasm2wat -o hello_world.wat $(OUTPUT)

wat: hello_world.wat

clean:
	rm -f $(OBJ) $(NANOLIBC_OBJ) $(OUTPUT) hello_world.wat
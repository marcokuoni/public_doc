(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (func $multiply (type 0) (param i32 i32) (result i32)
    local.get 1
    local.get 0
    i32.mul)
  (table (;0;) 1 1 funcref)
  (memory (;0;) 16)
  (global $__stack_pointer (mut i32) (i32.const 1048576))
  (global (;1;) i32 (i32.const 1048576))
  (global (;2;) i32 (i32.const 1048576))
  (export "memory" (memory 0))
  (export "multiply" (func $multiply))
  (export "__data_end" (global 1))
  (export "__heap_base" (global 2)))

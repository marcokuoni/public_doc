(module
  (func $alert (import "imports" "alert_func") (param i32))

  (func $multiply (param $a i32) (param $b i32) (result i32)
    local.get $a
    local.get $b
    i32.mul
  )

  (func $alert_multiply (param $a i32) (param $b i32)
    local.get $a
    local.get $b
    call $multiply
    call $alert
  )

  (export "multiply" (func $multiply))
  (export "alert_multiply" (func $alert_multiply))
)
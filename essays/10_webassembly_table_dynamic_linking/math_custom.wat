(module
    (import "env" "math_tbl" (table 2 funcref))

    (type $t0 (func (param $a i32) (param $b i32) (result i32)))

    (func $mul_cust (export "mul_cust") (param $a i32) (param $b i32) (result i32)
        (call_indirect (type $t0) (local.get $a) (local.get $b) (i32.const 0))
    )

    (func $div_cust (export "div_cust") (param $a i32) (param $b i32) (result i32)
        (call_indirect (type $t0) (local.get $a) (local.get $b) (i32.const 1))
    )
)
(module
    (func $mul (param $a i32) (param $b i32) (result i32)
        (i32.mul (local.get $a) (local.get $b))
    )

    (func $div (param $a i32) (param $b i32) (result i32)
        (i32.div_s (local.get $a) (local.get $b))
    )

    (table (export "math_tbl") 2 funcref)
    (elem (i32.const 0) $mul $div)
)
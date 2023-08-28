(module
    (memory (import "js" "mem") 1)
    (func (export "fibonacci") (param $n i32)
        (local $index i32)
        (local $ptr i32)    

        (i32.store (i32.const 0) (i32.const 0))
        (i32.store (i32.const 4) (i32.const 1))

        (set_local $index (i32.const 2))
        (set_local $ptr (i32.const 8))

        (block $break
            (loop $loop
                (i32.store
                    (get_local $ptr)
                    (i32.add
                        (i32.load (i32.sub (get_local $ptr) (i32.const 4)))
                        (i32.load (i32.sub (get_local $ptr) (i32.const 8)))
                    )
                )
                (set_local $index (i32.add (get_local $index) (i32.const 1)))
                (set_local $ptr (i32.add (get_local $ptr) (i32.const 4)))
                (br_if $break (i32.ge_u (get_local $index) (get_local $n)))
                (br $loop)
            )
        )
    )
)
(module
  (memory (export "mem") 1 4) ;; 1 page initial, grow to max 4 pages
  (data (i32.const 0x1) "\01\02\03") ;; initialize at 0x1 with 3 bytes
)
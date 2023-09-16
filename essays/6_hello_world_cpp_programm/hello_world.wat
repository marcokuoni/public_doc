(module
  (type (;0;) (func (param i32 i32 i32 i32)))
  (type (;1;) (func (param i32)))
  (type (;2;) (func))
  (type (;3;) (func (param i32 i32 i32) (result i32)))
  (type (;4;) (func (param i32) (result i32)))
  (type (;5;) (func (param i32 i32) (result i32)))
  (type (;6;) (func (param i32 i32 i32 i32 i32) (result i32)))
  (type (;7;) (func (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)))
  (import "env" "print_string" (func (;0;) (type 1)))
  (func (;1;) (type 2)
    i32.const 1117
    call 4
    drop)
  (func (;2;) (type 2)
    unreachable)
  (func (;3;) (type 3) (param i32 i32 i32) (result i32)
    (local i32)
    block  ;; label = @1
      local.get 2
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      local.set 3
      loop  ;; label = @2
        local.get 3
        local.get 1
        i32.store8
        local.get 3
        i32.const 1
        i32.add
        local.set 3
        local.get 2
        i32.const -1
        i32.add
        local.tee 2
        br_if 0 (;@2;)
      end
    end
    local.get 0)
  (func (;4;) (type 4) (param i32) (result i32)
    local.get 0
    call 0
    i32.const 0)
  (func (;5;) (type 4) (param i32) (result i32)
    local.get 0
    call 6)
  (func (;6;) (type 4) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 1
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        br_if 0 (;@2;)
        i32.const 0
        local.set 2
        br 1 (;@1;)
      end
      i32.const 0
      local.set 3
      block  ;; label = @2
        block  ;; label = @3
          i32.const 0
          i32.load offset=1412
          local.tee 2
          i32.eqz
          br_if 0 (;@3;)
          i32.const 0
          local.set 4
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        local.get 2
                        local.tee 5
                        i32.load offset=8
                        i32.const -16843010
                        i32.eq
                        br_if 0 (;@10;)
                        i32.const 0
                        local.set 4
                        br 1 (;@9;)
                      end
                      local.get 5
                      i32.load
                      local.tee 6
                      local.get 0
                      i32.ge_u
                      br_if 1 (;@8;)
                      block  ;; label = @10
                        local.get 4
                        br_if 0 (;@10;)
                        local.get 6
                        local.set 4
                        local.get 5
                        local.set 3
                        br 1 (;@9;)
                      end
                      local.get 4
                      local.get 6
                      i32.add
                      i32.const 12
                      i32.add
                      local.set 4
                    end
                    local.get 5
                    i32.load offset=4
                    local.set 2
                    local.get 4
                    local.get 0
                    i32.lt_u
                    br_if 2 (;@6;)
                    local.get 3
                    local.get 4
                    i32.store
                    local.get 3
                    local.get 2
                    i32.store offset=4
                    br 1 (;@7;)
                  end
                  local.get 5
                  i32.load offset=4
                  local.set 2
                  local.get 6
                  local.set 4
                  local.get 5
                  local.set 3
                end
                block  ;; label = @7
                  local.get 2
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 4
                  local.get 0
                  i32.const 22
                  i32.add
                  i32.le_u
                  br_if 0 (;@7;)
                  local.get 0
                  i32.const 12
                  i32.div_u
                  i32.const 12
                  i32.mul
                  local.tee 0
                  local.get 3
                  i32.add
                  local.tee 6
                  i32.const 24
                  i32.add
                  local.tee 5
                  local.get 2
                  local.get 5
                  i32.sub
                  i32.const -12
                  i32.add
                  i32.store
                  local.get 6
                  i32.const 28
                  i32.add
                  local.get 2
                  i32.store
                  local.get 3
                  local.get 0
                  i32.const 12
                  i32.add
                  i32.store
                  local.get 6
                  i32.const 32
                  i32.add
                  i32.const -16843010
                  i32.store
                  local.get 3
                  local.get 5
                  i32.store offset=4
                  local.get 4
                  local.get 0
                  local.get 5
                  i32.load
                  i32.add
                  i32.const 24
                  i32.add
                  i32.ne
                  br_if 5 (;@2;)
                end
                block  ;; label = @7
                  local.get 3
                  i32.load offset=8
                  i32.const -16843010
                  i32.ne
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const 8
                  i32.add
                  local.set 2
                  br 3 (;@4;)
                end
                call 7
                local.get 1
                i32.const 1129
                i32.store offset=8
                local.get 1
                i32.const 164
                i32.store offset=4
                local.get 1
                i32.const 1024
                i32.store
                i32.const 1359
                local.get 1
                call 13
                drop
                call 2
                unreachable
              end
              local.get 2
              br_if 0 (;@5;)
            end
            local.get 5
            local.get 0
            i32.const 12
            i32.add
            call 8
            local.tee 3
            i32.store offset=4
            local.get 3
            local.get 0
            i32.store
            local.get 3
            i32.const 0
            i32.store offset=4
            local.get 3
            i32.const 8
            i32.add
            local.set 2
          end
          local.get 2
          i32.const -1044266559
          i32.store
          local.get 3
          i32.const 12
          i32.add
          local.set 2
          br 2 (;@1;)
        end
        local.get 0
        i32.const 12
        i32.add
        call 8
        local.tee 2
        i64.const -4485090719211454464
        i64.store offset=4 align=4
        local.get 2
        local.get 0
        i32.store
        i32.const 0
        local.get 2
        i32.store offset=1412
        local.get 2
        i32.const 12
        i32.add
        local.set 2
        br 1 (;@1;)
      end
      call 7
      local.get 1
      i32.const 1056
      i32.store offset=24
      local.get 1
      i32.const 121
      i32.store offset=20
      local.get 1
      i32.const 1024
      i32.store offset=16
      i32.const 1359
      local.get 1
      i32.const 16
      i32.add
      call 13
      drop
      call 2
      unreachable
    end
    local.get 1
    i32.const 32
    i32.add
    global.set 0
    local.get 2)
  (func (;7;) (type 2)
    (local i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 80
    i32.sub
    local.tee 0
    global.set 0
    i32.const 1044
    call 4
    drop
    i32.const 0
    local.set 1
    i32.const 0
    local.set 2
    block  ;; label = @1
      i32.const 0
      i32.load offset=1412
      local.tee 3
      i32.eqz
      br_if 0 (;@1;)
      i32.const 0
      local.set 2
      i32.const 0
      local.set 1
      loop  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 3
              i32.load offset=8
              local.tee 4
              i32.const -1044266559
              i32.eq
              br_if 0 (;@5;)
              local.get 4
              i32.const -16843010
              i32.eq
              br_if 1 (;@4;)
              call 7
              local.get 0
              i32.const 1170
              i32.store offset=56
              local.get 0
              i32.const 135
              i32.store offset=52
              local.get 0
              i32.const 1024
              i32.store offset=48
              i32.const 1359
              local.get 0
              i32.const 48
              i32.add
              call 13
              drop
              call 2
              unreachable
            end
            local.get 3
            i32.load
            local.tee 5
            local.get 1
            i32.add
            local.set 1
            br 1 (;@3;)
          end
          local.get 3
          i32.load
          local.tee 5
          local.get 2
          i32.add
          local.set 2
        end
        local.get 0
        local.get 5
        i32.store offset=68
        local.get 0
        i32.const 1165
        i32.const 1250
        local.get 4
        i32.const -16843010
        i32.eq
        select
        i32.store offset=72
        local.get 0
        local.get 3
        i32.store offset=64
        i32.const 1387
        local.get 0
        i32.const 64
        i32.add
        call 13
        drop
        local.get 3
        i32.load offset=4
        local.tee 3
        br_if 0 (;@2;)
      end
    end
    local.get 0
    local.get 1
    i32.store offset=32
    i32.const 1326
    local.get 0
    i32.const 32
    i32.add
    call 13
    drop
    local.get 0
    local.get 2
    local.get 1
    i32.add
    i32.store offset=16
    i32.const 1293
    local.get 0
    i32.const 16
    i32.add
    call 13
    drop
    local.get 0
    i32.const 0
    i32.load offset=1416
    i32.store
    i32.const 1260
    local.get 0
    call 13
    drop
    local.get 0
    i32.const 80
    i32.add
    global.set 0)
  (func (;8;) (type 4) (param i32) (result i32)
    (local i32 i32)
    block  ;; label = @1
      i32.const 0
      i32.load offset=1416
      local.tee 1
      br_if 0 (;@1;)
      i32.const 0
      memory.size
      i32.const 64896
      i32.mul
      local.tee 1
      i32.store offset=1416
    end
    local.get 1
    local.set 2
    block  ;; label = @1
      memory.size
      i32.const 64896
      i32.mul
      local.get 1
      i32.sub
      local.get 0
      i32.ge_u
      br_if 0 (;@1;)
      local.get 0
      i32.const 64896
      i32.div_u
      i32.const 1
      i32.add
      memory.grow
      drop
      i32.const 0
      i32.load offset=1416
      local.set 2
    end
    i32.const 0
    local.get 2
    local.get 0
    i32.add
    i32.store offset=1416
    local.get 1)
  (func (;9;) (type 4) (param i32) (result i32)
    local.get 0
    call 6)
  (func (;10;) (type 1) (param i32)
    local.get 0
    call 11)
  (func (;11;) (type 1) (param i32)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 1
    global.set 0
    block  ;; label = @1
      block  ;; label = @2
        local.get 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 0
        i32.const -4
        i32.add
        local.tee 0
        i32.load
        i32.const -1044266559
        i32.ne
        br_if 1 (;@1;)
        local.get 0
        i32.const -16843010
        i32.store
      end
      local.get 1
      i32.const 16
      i32.add
      global.set 0
      return
    end
    call 7
    local.get 1
    i32.const 1214
    i32.store offset=8
    local.get 1
    i32.const 208
    i32.store offset=4
    local.get 1
    i32.const 1024
    i32.store
    i32.const 1359
    local.get 1
    call 13
    drop
    call 2
    unreachable)
  (func (;12;) (type 1) (param i32)
    local.get 0
    call 11)
  (func (;13;) (type 5) (param i32 i32) (result i32)
    (local i32)
    global.get 0
    i32.const 16
    i32.sub
    local.tee 2
    global.set 0
    local.get 2
    local.get 1
    i32.store offset=12
    i32.const 1
    local.get 2
    i32.const 11
    i32.add
    i32.const -1
    local.get 0
    local.get 1
    call 15
    local.set 1
    local.get 2
    i32.const 16
    i32.add
    global.set 0
    local.get 1)
  (func (;14;) (type 0) (param i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      call 18
    end)
  (func (;15;) (type 6) (param i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    local.get 0
    i32.const 2
    local.get 1
    select
    local.set 5
    i32.const 0
    local.set 6
    loop (result i32)  ;; label = @1
      local.get 3
      i32.const 2
      i32.add
      local.set 0
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            loop  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  local.get 3
                  i32.load8_u
                  local.tee 7
                  i32.eqz
                  br_if 0 (;@7;)
                  local.get 7
                  i32.const 37
                  i32.ne
                  br_if 1 (;@6;)
                  i32.const 0
                  local.set 7
                  block  ;; label = @8
                    loop  ;; label = @9
                      i32.const 1
                      local.set 3
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  local.get 0
                                  i32.const -1
                                  i32.add
                                  local.tee 8
                                  i32.load8_s
                                  local.tee 9
                                  i32.const -43
                                  i32.add
                                  br_table 2 (;@13;) 7 (;@8;) 1 (;@14;) 7 (;@8;) 7 (;@8;) 5 (;@10;) 0 (;@15;)
                                end
                                local.get 9
                                i32.const -32
                                i32.add
                                br_table 2 (;@12;) 6 (;@8;) 6 (;@8;) 3 (;@11;) 6 (;@8;)
                              end
                              i32.const 2
                              local.set 3
                              br 3 (;@10;)
                            end
                            i32.const 4
                            local.set 3
                            br 2 (;@10;)
                          end
                          i32.const 8
                          local.set 3
                          br 1 (;@10;)
                        end
                        i32.const 16
                        local.set 3
                      end
                      local.get 0
                      i32.const 1
                      i32.add
                      local.set 0
                      local.get 7
                      local.get 3
                      i32.or
                      local.set 7
                      br 0 (;@9;)
                    end
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          local.get 9
                          i32.const -48
                          i32.add
                          i32.const 255
                          i32.and
                          i32.const 9
                          i32.gt_u
                          br_if 0 (;@11;)
                          i32.const 0
                          local.set 3
                          loop  ;; label = @12
                            local.get 3
                            i32.const 10
                            i32.mul
                            local.get 9
                            i32.const 255
                            i32.and
                            i32.add
                            i32.const -48
                            i32.add
                            local.set 3
                            local.get 8
                            i32.const 1
                            i32.add
                            local.tee 8
                            i32.load8_u
                            local.tee 9
                            i32.const -48
                            i32.add
                            i32.const 255
                            i32.and
                            i32.const 10
                            i32.lt_u
                            br_if 0 (;@12;)
                            br 2 (;@10;)
                          end
                        end
                        i32.const 0
                        local.set 3
                        local.get 9
                        i32.const 42
                        i32.eq
                        br_if 1 (;@9;)
                      end
                      local.get 8
                      local.set 0
                      br 1 (;@8;)
                    end
                    local.get 7
                    i32.const 2
                    i32.or
                    local.get 7
                    local.get 4
                    i32.load
                    local.tee 3
                    i32.const 0
                    i32.lt_s
                    select
                    local.set 7
                    local.get 3
                    local.get 3
                    i32.const 31
                    i32.shr_s
                    local.tee 9
                    i32.add
                    local.get 9
                    i32.xor
                    local.set 3
                    local.get 4
                    i32.const 4
                    i32.add
                    local.set 4
                    local.get 0
                    i32.load8_u
                    local.set 9
                  end
                  i32.const 0
                  local.set 10
                  block  ;; label = @8
                    block  ;; label = @9
                      local.get 9
                      i32.const 255
                      i32.and
                      i32.const 46
                      i32.eq
                      br_if 0 (;@9;)
                      local.get 0
                      local.set 8
                      br 1 (;@8;)
                    end
                    local.get 0
                    i32.const 1
                    i32.add
                    local.set 8
                    local.get 7
                    i32.const 1024
                    i32.or
                    local.set 7
                    block  ;; label = @9
                      local.get 0
                      i32.load8_u offset=1
                      local.tee 9
                      i32.const -48
                      i32.add
                      i32.const 255
                      i32.and
                      i32.const 9
                      i32.gt_u
                      br_if 0 (;@9;)
                      i32.const 0
                      local.set 10
                      loop  ;; label = @10
                        local.get 10
                        i32.const 10
                        i32.mul
                        local.get 9
                        i32.const 255
                        i32.and
                        i32.add
                        i32.const -48
                        i32.add
                        local.set 10
                        local.get 8
                        i32.const 1
                        i32.add
                        local.tee 8
                        i32.load8_u
                        local.tee 9
                        i32.const -48
                        i32.add
                        i32.const 255
                        i32.and
                        i32.const 10
                        i32.lt_u
                        br_if 0 (;@10;)
                        br 2 (;@8;)
                      end
                    end
                    local.get 9
                    i32.const 255
                    i32.and
                    i32.const 42
                    i32.ne
                    br_if 0 (;@8;)
                    local.get 4
                    i32.load
                    local.tee 9
                    i32.const 0
                    local.get 9
                    i32.const 0
                    i32.gt_s
                    select
                    local.set 10
                    local.get 0
                    i32.const 2
                    i32.add
                    local.set 8
                    local.get 4
                    i32.const 4
                    i32.add
                    local.set 4
                    local.get 0
                    i32.load8_u offset=2
                    local.set 9
                  end
                  i32.const 512
                  local.set 0
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            local.get 9
                            i32.const 24
                            i32.shl
                            i32.const 24
                            i32.shr_s
                            i32.const -104
                            i32.add
                            i32.const 31
                            i32.rotl
                            local.tee 11
                            br_table 1 (;@11;) 3 (;@9;) 0 (;@12;) 4 (;@8;) 4 (;@8;) 4 (;@8;) 4 (;@8;) 4 (;@8;) 4 (;@8;) 2 (;@10;) 4 (;@8;)
                          end
                          block  ;; label = @12
                            local.get 8
                            i32.load8_u offset=1
                            local.tee 9
                            i32.const 108
                            i32.eq
                            br_if 0 (;@12;)
                            local.get 8
                            i32.const 1
                            i32.add
                            local.set 8
                            local.get 7
                            i32.const 256
                            i32.or
                            local.set 7
                            br 4 (;@8;)
                          end
                          i32.const 2
                          local.set 11
                          i32.const 768
                          local.set 0
                          br 2 (;@9;)
                        end
                        block  ;; label = @11
                          local.get 8
                          i32.load8_u offset=1
                          local.tee 9
                          i32.const 104
                          i32.eq
                          br_if 0 (;@11;)
                          local.get 8
                          i32.const 1
                          i32.add
                          local.set 8
                          local.get 7
                          i32.const 128
                          i32.or
                          local.set 7
                          br 3 (;@8;)
                        end
                        i32.const 2
                        local.set 11
                        i32.const 192
                        local.set 0
                        br 1 (;@9;)
                      end
                      i32.const 1
                      local.set 11
                      i32.const 256
                      local.set 0
                    end
                    local.get 7
                    local.get 0
                    i32.or
                    local.set 7
                    local.get 8
                    local.get 11
                    i32.add
                    local.tee 8
                    i32.load8_u
                    local.set 9
                  end
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 9
                              i32.const 24
                              i32.shl
                              i32.const 24
                              i32.shr_s
                              local.tee 0
                              i32.const 97
                              i32.gt_s
                              br_if 0 (;@13;)
                              local.get 0
                              i32.const 37
                              i32.eq
                              br_if 5 (;@8;)
                              local.get 0
                              i32.const 88
                              i32.eq
                              br_if 1 (;@12;)
                              br 9 (;@4;)
                            end
                            block  ;; label = @13
                              local.get 0
                              i32.const -98
                              i32.add
                              br_table 1 (;@12;) 2 (;@11;) 1 (;@12;) 9 (;@4;) 9 (;@4;) 9 (;@4;) 9 (;@4;) 1 (;@12;) 9 (;@4;) 9 (;@4;) 9 (;@4;) 9 (;@4;) 9 (;@4;) 1 (;@12;) 4 (;@9;) 9 (;@4;) 9 (;@4;) 3 (;@10;) 9 (;@4;) 1 (;@12;) 0 (;@13;)
                            end
                            local.get 0
                            i32.const 120
                            i32.ne
                            br_if 8 (;@4;)
                          end
                          i32.const 16
                          local.set 11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                block  ;; label = @15
                                  block  ;; label = @16
                                    local.get 9
                                    i32.const 255
                                    i32.and
                                    local.tee 0
                                    i32.const 110
                                    i32.gt_s
                                    br_if 0 (;@16;)
                                    local.get 0
                                    i32.const 88
                                    i32.eq
                                    br_if 2 (;@14;)
                                    local.get 0
                                    i32.const 98
                                    i32.ne
                                    br_if 1 (;@15;)
                                    i32.const 2
                                    local.set 11
                                    br 3 (;@13;)
                                  end
                                  block  ;; label = @16
                                    local.get 0
                                    i32.const 111
                                    i32.ne
                                    br_if 0 (;@16;)
                                    i32.const 8
                                    local.set 11
                                    br 3 (;@13;)
                                  end
                                  local.get 0
                                  i32.const 120
                                  i32.eq
                                  br_if 1 (;@14;)
                                end
                                local.get 7
                                i32.const -17
                                i32.and
                                local.set 7
                                i32.const 10
                                local.set 11
                              end
                              local.get 7
                              i32.const 32
                              i32.or
                              local.get 7
                              local.get 0
                              i32.const 88
                              i32.eq
                              select
                              local.set 7
                              local.get 0
                              i32.const 100
                              i32.eq
                              br_if 1 (;@12;)
                              local.get 0
                              i32.const 105
                              i32.eq
                              br_if 1 (;@12;)
                            end
                            local.get 7
                            i32.const -13
                            i32.and
                            local.set 7
                          end
                          local.get 7
                          i32.const -2
                          i32.and
                          local.get 7
                          local.get 7
                          i32.const 1024
                          i32.and
                          select
                          local.set 7
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 0
                              i32.const 105
                              i32.eq
                              br_if 0 (;@13;)
                              local.get 0
                              i32.const 100
                              i32.ne
                              br_if 1 (;@12;)
                            end
                            local.get 7
                            i32.const 512
                            i32.and
                            br_if 10 (;@2;)
                            block  ;; label = @13
                              local.get 7
                              i32.const 256
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 4
                              i32.load
                              local.set 0
                              local.get 4
                              i32.const 4
                              i32.add
                              local.set 4
                              local.get 5
                              local.get 1
                              local.get 6
                              local.get 2
                              local.get 0
                              local.get 0
                              i32.const 31
                              i32.shr_s
                              local.tee 9
                              i32.add
                              local.get 9
                              i32.xor
                              local.get 0
                              i32.const 31
                              i32.shr_u
                              local.get 11
                              local.get 10
                              local.get 3
                              local.get 7
                              call 17
                              local.set 6
                              br 11 (;@2;)
                            end
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 7
                                i32.const 64
                                i32.and
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 4
                                i32.load8_s
                                local.set 0
                                br 1 (;@13;)
                              end
                              local.get 4
                              i32.load
                              local.set 0
                              local.get 7
                              i32.const 128
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 0
                              i32.const 16
                              i32.shl
                              i32.const 16
                              i32.shr_s
                              local.set 0
                            end
                            local.get 4
                            i32.const 4
                            i32.add
                            local.set 4
                            local.get 5
                            local.get 1
                            local.get 6
                            local.get 2
                            local.get 0
                            local.get 0
                            i32.const 31
                            i32.shr_s
                            local.tee 9
                            i32.add
                            local.get 9
                            i32.xor
                            local.get 0
                            i32.const 31
                            i32.shr_u
                            local.get 11
                            local.get 10
                            local.get 3
                            local.get 7
                            call 17
                            local.set 6
                            br 10 (;@2;)
                          end
                          local.get 7
                          i32.const 512
                          i32.and
                          br_if 9 (;@2;)
                          block  ;; label = @12
                            local.get 7
                            i32.const 256
                            i32.and
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 5
                            local.get 1
                            local.get 6
                            local.get 2
                            local.get 4
                            i32.load
                            i32.const 0
                            local.get 11
                            local.get 10
                            local.get 3
                            local.get 7
                            call 17
                            local.set 6
                            local.get 4
                            i32.const 4
                            i32.add
                            local.set 4
                            br 10 (;@2;)
                          end
                          block  ;; label = @12
                            block  ;; label = @13
                              local.get 7
                              i32.const 64
                              i32.and
                              i32.eqz
                              br_if 0 (;@13;)
                              local.get 4
                              i32.load8_u
                              local.set 0
                              br 1 (;@12;)
                            end
                            local.get 4
                            i32.load
                            local.tee 0
                            i32.const 65535
                            i32.and
                            local.get 0
                            local.get 7
                            i32.const 128
                            i32.and
                            select
                            local.set 0
                          end
                          local.get 4
                          i32.const 4
                          i32.add
                          local.set 4
                          local.get 5
                          local.get 1
                          local.get 6
                          local.get 2
                          local.get 0
                          i32.const 0
                          local.get 11
                          local.get 10
                          local.get 3
                          local.get 7
                          call 17
                          local.set 6
                          br 9 (;@2;)
                        end
                        i32.const 1
                        local.set 9
                        block  ;; label = @11
                          local.get 7
                          i32.const 2
                          i32.and
                          local.tee 10
                          br_if 0 (;@11;)
                          i32.const 2
                          local.set 9
                          local.get 3
                          i32.const 2
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 3
                          i32.const -1
                          i32.add
                          local.set 7
                          local.get 3
                          i32.const 1
                          i32.add
                          local.set 9
                          i32.const 0
                          local.set 0
                          loop  ;; label = @12
                            i32.const 32
                            local.get 1
                            local.get 6
                            local.get 0
                            i32.add
                            local.get 2
                            local.get 5
                            call_indirect (type 0)
                            local.get 7
                            local.get 0
                            i32.const 1
                            i32.add
                            local.tee 0
                            i32.ne
                            br_if 0 (;@12;)
                          end
                          local.get 6
                          local.get 0
                          i32.add
                          local.set 6
                        end
                        local.get 4
                        i32.load8_s
                        local.get 1
                        local.get 6
                        local.get 2
                        local.get 5
                        call_indirect (type 0)
                        local.get 6
                        i32.const 1
                        i32.add
                        local.set 6
                        local.get 4
                        i32.const 4
                        i32.add
                        local.set 4
                        local.get 10
                        i32.eqz
                        br_if 8 (;@2;)
                        local.get 9
                        local.get 3
                        i32.ge_u
                        br_if 8 (;@2;)
                        local.get 3
                        local.get 9
                        i32.sub
                        local.set 0
                        loop  ;; label = @11
                          i32.const 32
                          local.get 1
                          local.get 6
                          local.get 2
                          local.get 5
                          call_indirect (type 0)
                          local.get 6
                          i32.const 1
                          i32.add
                          local.set 6
                          local.get 0
                          i32.const -1
                          i32.add
                          local.tee 0
                          br_if 0 (;@11;)
                          br 9 (;@2;)
                        end
                      end
                      local.get 4
                      i32.load
                      local.tee 12
                      local.set 9
                      block  ;; label = @10
                        local.get 12
                        i32.load8_u
                        local.tee 11
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 10
                        i32.const -1
                        local.get 10
                        select
                        i32.const -1
                        i32.add
                        local.set 13
                        local.get 12
                        local.set 9
                        loop  ;; label = @11
                          local.get 13
                          local.set 0
                          local.get 9
                          i32.const 1
                          i32.add
                          local.tee 9
                          i32.load8_u
                          i32.eqz
                          br_if 1 (;@10;)
                          local.get 0
                          i32.const -1
                          i32.add
                          local.set 13
                          local.get 0
                          br_if 0 (;@11;)
                        end
                      end
                      local.get 9
                      local.get 12
                      i32.sub
                      local.tee 0
                      local.get 10
                      local.get 0
                      local.get 10
                      i32.lt_u
                      select
                      local.get 0
                      local.get 7
                      i32.const 1024
                      i32.and
                      local.tee 9
                      select
                      local.set 13
                      block  ;; label = @10
                        local.get 7
                        i32.const 2
                        i32.and
                        local.tee 14
                        br_if 0 (;@10;)
                        block  ;; label = @11
                          local.get 13
                          local.get 3
                          i32.lt_u
                          br_if 0 (;@11;)
                          local.get 13
                          i32.const 1
                          i32.add
                          local.set 13
                          br 1 (;@10;)
                        end
                        local.get 3
                        local.get 13
                        i32.sub
                        local.set 7
                        local.get 3
                        i32.const 1
                        i32.add
                        local.set 13
                        i32.const 0
                        local.set 0
                        loop  ;; label = @11
                          i32.const 32
                          local.get 1
                          local.get 6
                          local.get 0
                          i32.add
                          local.get 2
                          local.get 5
                          call_indirect (type 0)
                          local.get 7
                          local.get 0
                          i32.const 1
                          i32.add
                          local.tee 0
                          i32.ne
                          br_if 0 (;@11;)
                        end
                        local.get 6
                        local.get 0
                        i32.add
                        local.set 6
                        local.get 12
                        i32.load8_u
                        local.set 11
                      end
                      block  ;; label = @10
                        local.get 11
                        i32.const 255
                        i32.and
                        i32.eqz
                        br_if 0 (;@10;)
                        local.get 12
                        i32.const 1
                        i32.add
                        local.set 0
                        loop  ;; label = @11
                          block  ;; label = @12
                            local.get 9
                            i32.eqz
                            br_if 0 (;@12;)
                            local.get 10
                            i32.eqz
                            br_if 2 (;@10;)
                            local.get 10
                            i32.const -1
                            i32.add
                            local.set 10
                          end
                          local.get 11
                          i32.const 24
                          i32.shl
                          i32.const 24
                          i32.shr_s
                          local.get 1
                          local.get 6
                          local.get 2
                          local.get 5
                          call_indirect (type 0)
                          local.get 6
                          i32.const 1
                          i32.add
                          local.set 6
                          local.get 0
                          i32.load8_u
                          local.set 11
                          local.get 0
                          i32.const 1
                          i32.add
                          local.set 0
                          local.get 11
                          br_if 0 (;@11;)
                        end
                      end
                      local.get 4
                      i32.const 4
                      i32.add
                      local.set 4
                      local.get 14
                      i32.eqz
                      br_if 7 (;@2;)
                      local.get 13
                      local.get 3
                      i32.ge_u
                      br_if 7 (;@2;)
                      local.get 3
                      local.get 13
                      i32.sub
                      local.set 0
                      loop  ;; label = @10
                        i32.const 32
                        local.get 1
                        local.get 6
                        local.get 2
                        local.get 5
                        call_indirect (type 0)
                        local.get 6
                        i32.const 1
                        i32.add
                        local.set 6
                        local.get 0
                        i32.const -1
                        i32.add
                        local.tee 0
                        br_if 0 (;@10;)
                        br 8 (;@2;)
                      end
                    end
                    local.get 5
                    local.get 1
                    local.get 6
                    local.get 2
                    local.get 4
                    i32.load
                    i32.const 0
                    i32.const 16
                    local.get 10
                    i32.const 8
                    local.get 7
                    i32.const 33
                    i32.or
                    call 17
                    local.set 6
                    local.get 4
                    i32.const 4
                    i32.add
                    local.set 4
                    br 6 (;@2;)
                  end
                  i32.const 37
                  local.get 1
                  local.get 6
                  local.get 2
                  local.get 5
                  call_indirect (type 0)
                  br 4 (;@3;)
                end
                i32.const 0
                local.get 1
                local.get 6
                local.get 2
                i32.const -1
                i32.add
                local.get 6
                local.get 2
                i32.lt_u
                select
                local.get 2
                local.get 5
                call_indirect (type 0)
                local.get 6
                return
              end
              local.get 7
              i32.const 24
              i32.shl
              i32.const 24
              i32.shr_s
              local.get 1
              local.get 6
              local.get 2
              local.get 5
              call_indirect (type 0)
              local.get 0
              i32.const 1
              i32.add
              local.set 0
              local.get 3
              i32.const 1
              i32.add
              local.set 3
              local.get 6
              i32.const 1
              i32.add
              local.set 6
              br 0 (;@5;)
            end
          end
          local.get 0
          local.get 1
          local.get 6
          local.get 2
          local.get 5
          call_indirect (type 0)
        end
        local.get 6
        i32.const 1
        i32.add
        local.set 6
      end
      local.get 8
      i32.const 1
      i32.add
      local.set 3
      br 0 (;@1;)
    end)
  (func (;16;) (type 0) (param i32 i32 i32 i32))
  (func (;17;) (type 7) (param i32 i32 i32 i32 i32 i32 i32 i32 i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    global.get 0
    i32.const 32
    i32.sub
    local.tee 10
    global.set 0
    local.get 9
    local.get 9
    i32.const -17
    i32.and
    local.get 4
    select
    local.tee 11
    i32.const 1024
    i32.and
    local.set 12
    block  ;; label = @1
      block  ;; label = @2
        local.get 4
        br_if 0 (;@2;)
        i32.const 0
        local.set 9
        local.get 12
        br_if 1 (;@1;)
      end
      local.get 11
      i32.const 32
      i32.and
      i32.const 97
      i32.xor
      i32.const 246
      i32.add
      local.set 13
      i32.const 0
      local.set 14
      loop  ;; label = @2
        local.get 10
        local.get 14
        i32.add
        local.get 4
        local.get 4
        local.get 6
        i32.div_u
        local.tee 15
        local.get 6
        i32.mul
        i32.sub
        local.tee 9
        i32.const 48
        local.get 13
        local.get 9
        i32.const 254
        i32.and
        i32.const 10
        i32.lt_u
        select
        i32.add
        i32.store8
        local.get 14
        i32.const 1
        i32.add
        local.set 9
        local.get 4
        local.get 6
        i32.lt_u
        br_if 1 (;@1;)
        local.get 14
        i32.const 31
        i32.lt_u
        local.set 16
        local.get 9
        local.set 14
        local.get 15
        local.set 4
        local.get 16
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 11
      i32.const 2
      i32.and
      local.tee 15
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          local.get 8
          br_if 0 (;@3;)
          i32.const 0
          local.set 8
          br 1 (;@2;)
        end
        local.get 11
        i32.const 1
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        local.get 8
        local.get 11
        i32.const 12
        i32.and
        i32.const 0
        i32.ne
        local.get 5
        i32.or
        i32.sub
        local.set 8
      end
      block  ;; label = @2
        local.get 9
        local.get 7
        i32.ge_u
        br_if 0 (;@2;)
        local.get 9
        i32.const 31
        i32.gt_u
        br_if 0 (;@2;)
        local.get 10
        local.get 9
        i32.add
        i32.const 48
        local.get 9
        i32.const -1
        i32.xor
        local.get 7
        i32.add
        local.tee 4
        i32.const 31
        local.get 9
        i32.sub
        local.tee 14
        local.get 4
        local.get 14
        i32.lt_u
        select
        i32.const 1
        i32.add
        local.tee 4
        call 3
        drop
        local.get 4
        local.get 9
        i32.add
        local.set 9
      end
      local.get 11
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      local.get 9
      local.get 8
      i32.ge_u
      br_if 0 (;@1;)
      local.get 9
      i32.const 31
      i32.gt_u
      br_if 0 (;@1;)
      local.get 10
      local.get 9
      i32.add
      i32.const 48
      local.get 8
      local.get 9
      i32.const -1
      i32.xor
      i32.add
      local.tee 4
      i32.const 31
      local.get 9
      i32.sub
      local.tee 14
      local.get 4
      local.get 14
      i32.lt_u
      select
      local.tee 4
      i32.const 1
      i32.add
      call 3
      drop
      local.get 9
      local.get 4
      i32.add
      i32.const 1
      i32.add
      local.set 9
    end
    block  ;; label = @1
      block  ;; label = @2
        local.get 11
        i32.const 16
        i32.and
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 12
          br_if 0 (;@3;)
          local.get 9
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 9
            local.get 7
            i32.eq
            br_if 0 (;@4;)
            local.get 9
            local.get 8
            i32.ne
            br_if 1 (;@3;)
          end
          local.get 9
          i32.const -2
          i32.add
          local.get 9
          i32.const -1
          i32.add
          local.tee 4
          local.get 4
          select
          local.get 4
          local.get 6
          i32.const 16
          i32.eq
          select
          local.set 9
        end
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 6
              i32.const 16
              i32.ne
              br_if 0 (;@5;)
              block  ;; label = @6
                local.get 11
                i32.const 32
                i32.and
                local.tee 14
                br_if 0 (;@6;)
                i32.const 120
                local.set 4
                local.get 9
                i32.const 32
                i32.lt_u
                br_if 2 (;@4;)
              end
              local.get 14
              i32.eqz
              br_if 2 (;@3;)
              i32.const 88
              local.set 4
              local.get 9
              i32.const 32
              i32.lt_u
              br_if 1 (;@4;)
              br 2 (;@3;)
            end
            local.get 6
            i32.const 2
            i32.ne
            br_if 1 (;@3;)
            i32.const 98
            local.set 4
            local.get 9
            i32.const 31
            i32.gt_u
            br_if 1 (;@3;)
          end
          local.get 10
          local.get 9
          i32.add
          local.get 4
          i32.store8
          local.get 9
          i32.const 1
          i32.add
          local.set 9
        end
        local.get 9
        i32.const 31
        i32.gt_u
        br_if 1 (;@1;)
        local.get 10
        local.get 9
        i32.add
        i32.const 48
        i32.store8
        local.get 9
        i32.const 1
        i32.add
        local.set 9
      end
      local.get 9
      i32.const 31
      i32.gt_u
      br_if 0 (;@1;)
      i32.const 45
      local.set 4
      block  ;; label = @2
        local.get 5
        br_if 0 (;@2;)
        i32.const 43
        local.set 4
        local.get 11
        i32.const 4
        i32.and
        br_if 0 (;@2;)
        i32.const 32
        local.set 4
        local.get 11
        i32.const 8
        i32.and
        i32.eqz
        br_if 1 (;@1;)
      end
      local.get 10
      local.get 9
      i32.add
      local.get 4
      i32.store8
      local.get 9
      i32.const 1
      i32.add
      local.set 9
    end
    local.get 2
    local.set 4
    block  ;; label = @1
      local.get 11
      i32.const 3
      i32.and
      br_if 0 (;@1;)
      local.get 2
      local.set 4
      local.get 9
      local.get 8
      i32.ge_u
      br_if 0 (;@1;)
      local.get 8
      local.get 9
      i32.sub
      local.set 14
      local.get 2
      local.set 4
      loop  ;; label = @2
        i32.const 32
        local.get 1
        local.get 4
        local.get 3
        local.get 0
        call_indirect (type 0)
        local.get 4
        i32.const 1
        i32.add
        local.set 4
        local.get 14
        i32.const -1
        i32.add
        local.tee 14
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 9
      i32.eqz
      br_if 0 (;@1;)
      local.get 10
      i32.const -1
      i32.add
      local.set 14
      loop  ;; label = @2
        local.get 14
        local.get 9
        i32.add
        i32.load8_s
        local.get 1
        local.get 4
        local.get 3
        local.get 0
        call_indirect (type 0)
        local.get 4
        i32.const 1
        i32.add
        local.set 4
        local.get 9
        i32.const -1
        i32.add
        local.tee 9
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 15
      i32.eqz
      br_if 0 (;@1;)
      local.get 4
      local.get 2
      i32.sub
      local.get 8
      i32.ge_u
      br_if 0 (;@1;)
      i32.const 0
      local.get 2
      i32.sub
      local.set 9
      loop  ;; label = @2
        i32.const 32
        local.get 1
        local.get 4
        local.get 3
        local.get 0
        call_indirect (type 0)
        local.get 9
        local.get 4
        i32.const 1
        i32.add
        local.tee 4
        i32.add
        local.get 8
        i32.lt_u
        br_if 0 (;@2;)
      end
    end
    local.get 10
    i32.const 32
    i32.add
    global.set 0
    local.get 4)
  (func (;18;) (type 1) (param i32)
    (local i32 i32)
    i32.const 0
    i32.load offset=1424
    local.set 1
    loop  ;; label = @1
      block  ;; label = @2
        local.get 1
        br_if 0 (;@2;)
        i32.const 0
        i32.const 100
        call 6
        local.tee 1
        i32.store offset=1424
      end
      i32.const 0
      i32.load offset=1420
      local.set 2
      block  ;; label = @2
        local.get 0
        i32.const 255
        i32.and
        i32.const 10
        i32.ne
        br_if 0 (;@2;)
        local.get 1
        local.get 2
        i32.add
        i32.const 0
        i32.store8
        i32.const 0
        i32.load offset=1424
        call 0
        i32.const 0
        i32.const 0
        i32.store offset=1420
        return
      end
      block  ;; label = @2
        local.get 2
        i32.const 98
        i32.gt_s
        br_if 0 (;@2;)
        i32.const 0
        local.get 2
        i32.const 1
        i32.add
        i32.store offset=1420
        local.get 1
        local.get 2
        i32.add
        local.get 0
        i32.store8
        i32.const 0
        i32.load offset=1424
        local.set 1
        i32.const 0
        i32.load offset=1420
        local.set 2
      end
      i32.const 10
      local.set 0
      local.get 2
      i32.const 99
      i32.eq
      br_if 0 (;@1;)
    end)
  (table (;0;) 3 3 funcref)
  (memory (;0;) 2)
  (global (;0;) (mut i32) (i32.const 66976))
  (export "memory" (memory 0))
  (export "helloWorld" (func 1))
  (export "_Znwm" (func 5))
  (export "_Znam" (func 9))
  (export "_ZdlPv" (func 10))
  (export "_ZdaPv" (func 12))
  (elem (;0;) (i32.const 1) func 14 16)
  (data (;0;) (i32.const 1024) "nanolibc/memory.cpp\00Memory dump\00old_size == current->size + sizeof(MemoryBlock) + next->size\00Hello World\00block->state == MemoryBlock::State::FREE\00block->state == MemoryBlock::State::FREE || block->state == MemoryBlock::State::ALLOCATED\00  Peak memory usage: %9d bytes.\0a\00  Tot. memory usage: %9d bytes.\0a\00  Cur. memory usage: %9d bytes.\0a\00Memory error at %s:%d: %s.\0a\00  0x%X: size %d. %s.\0a\00"))

#[no_mangle]
pub extern "C" fn multiply(a: i32, b: i32) -> i32 {
    a * b
}

fn main() {
    println!("2 * 21 = {}", multiply(2, 21));
}
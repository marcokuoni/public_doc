fn fibonacci(n: u64) -> u64 {
    if n == 0 {
        return 0;
    } else if n == 1 {
        return 1;
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}

fn main() {
    println!("Starting");
    let n = 35; // Change this to the desired Fibonacci number you want to compute
    let result = fibonacci(n);
    println!("Fibonacci({}) = {}", n, result);
    println!("Stopped");
}
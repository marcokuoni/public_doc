use std::fs;
use std::io::{Read, Write};

fn main() {
    let greeting = "Hello Security";
    let outfile = "hello.txt";
    let mut output_file = fs::File::create(outfile).expect(&format!("Error creating {}", outfile));

    output_file
        .write_all(greeting.as_bytes())
        .expect(&format!("Error writing: {}", outfile));

    let mut input_file = fs::File::open(outfile).expect(&format!("Error opening {}", outfile));

    let mut input = String::new();
    input_file
        .read_to_string(&mut input)
        .expect(&format!("Error reading: {}", outfile));

    println!("Read in from file: {}", input);
}

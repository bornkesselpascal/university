use std::any::type_name;
use std::fmt;

fn print_type<T>(name: &str, _: T) {
    println!("The type of {} is {}", name, type_name::<T>());
}

fn print_type_2<T: std::fmt::Display>(name: &str, var: T) {
    println!("The type of {} is {} {var}", name, type_name::<T>());
}

fn exec_int() {
    let x = 123;
    let x2: i64 = 123;
    let x3: isize = 321;

    let s: i8 = 123;
    // let mut s : i8 = 123; s += 124; // Does not compile, beacause it would overflow.

    print_type("x", x);
    print_type("x2", x2);
    print_type("x3", x3);
    print_type("s", s);
}

fn exec_float() {
    let y = 123.3;
    let y2: f32 = 123.123;

    print_type("y", y);
    print_type("y2", y2);
}

fn binary_expr() {
    let x = 10;
    let y = 10.;

    let x_sub3 = x - 3;
    let x_add3 = x + 3;
    let x_div2 = x / 3;
    let x_mul3 = x * 3;
    let x_mod3 = x % 3;

    print_type_2("x_sub3", x_sub3);
    print_type_2("x_add3", x_add3);
    print_type_2("x_div2", x_div2);
    print_type_2("x_mul3", x_mul3);
    print_type_2("x_mod3", x_mod3);

    // let k = x - y; // does not work

    let y_sub3 = y - 3.;
    let y_add3 = y + 3.;
    let y_div2 = y / 3.;
    let y_mul3 = y * 3.;
    let y_mod3 = y % 3.;

    print_type_2("y_sub3", y_sub3);
    print_type_2("y_add3", y_add3);
    print_type_2("y_div2", y_div2);
    print_type_2("y_mul3", y_mul3);
    print_type_2("y_mod3", y_mod3);

    let mut x_2 = 3;
    // ++x_2; does not work
    // x_2++; does not work

    x_2 += 1;
    println!("x_2 : {}", x_2);
}

fn exec_bool() {
    let t = true;
    let f: bool = false;

    print_type_2("t", t);
    print_type_2("f", f);
}

fn exec_str() {
    // String on the stack
    let str1 = "Hello"; 

    // String on the heap
    let str2 = String::from("Hello from Heap");
    print!("{}", str2);
}

fn exec_char() {
    let c = 'c';
    let d: char = 'd';

    print_type_2("c", c);
    print_type_2("d", d);
}

fn exec_array() {
    let ar = [1, 2, 3, 4];

    print_type("ar", ar);
    println!("ar: {:?}", ar);           // Print all elements with :?
    println!("ar: {} {}", ar[0], ar[1]);

    //let ar2 = [1, 1.3]; // does not work, different values

    //println!("{}", ar[9]); // does not work (but can compile if idx is externally provided)

    let mut y = [5; 7];
    println!("{:?}", y);
    y[5] = -123; // Knows that 9 is not part of, will not compile; unlike C++ (-> segementation fault)
    println!("{:?}", y);
}

fn exec_tuple() {
    // Store differenty types of data with a tuple
    // "Simple Struct/Class" without names

    let x = (1, 1.3, 'd', "hello");

    print_type("x", x);

    println!("{:?}", x);
    println!("tuple: {}, {}, {}, {}", x.0, x.1, x.2, x.3);
    // x.2 = 'c'; // Does not work, because this tuple tuple is immutable

    let y: (i32, u8, bool) = (9, 123, true);
    let (a, b, c) = y; // Unpack the values...
    println!("{a}, {b} {c}");

    let mut z = (9, true);
    println!("Before: {:?}", z);
    z.1 = false;
    println!("After: {:?}", z);

    let tup = ();   // Empty tuple, unit type
    print_type("tup (called unit)", tup);

    //println!("{}", x.5); // does not work
}

pub fn main_datatypes() {
    //exec_int();
    //exec_float();
    //binary_expr();
    //exec_bool();
    //exec_char();
    exec_tuple();
    //exec_array();
}

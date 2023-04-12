pub fn main() {
    example_fkt();
    example_fkt_params(123, 123.);
    // example_fkt_params(1239, 123.); // does not work
    println!("Got return: {}", return_value(3, 3));
    //println!("Got return 2: {:?}", return_value_other(3, 3, false));
    println!(
        "Got return correct {:?}",
        return_value_other_correct(3, 3, false)
    );
    println!("Caleld empty return: {:?}", empty_return());
    unused_t(1, 2, 3);
}

fn example_fkt() {
    println!("The example_fkt was called");
}

// fn example_fkt(i : i32) {        // does not work, no overloading
//     println!("The example_fkt was called with param: {i}");
// }

// also there are no default parameters

fn example_fkt_params(k: i8, j: f64) {   // Info: Implicitly this is returning ()
    println!("I the the params: {k} and {j}")
}

fn return_value(x: i32, y: i32) -> i32 {
    x + y // no semicolon here, beacause it is the last statement, better to use return x + y;
}

// does not do what would be expected...
// fn return_value_other(x: i32, y: i32, d: bool) -> i32 {
//     if d {
//         x + y;
//     } else {
//         x - y;
//     }
// }

fn return_value_other_correct(x: i32, y: i32, d: bool) -> i32 {
    if d {
        return x + y;
    } else {
        return x - y;
    }
}

fn empty_return() {
    println!("Hello empty return");
}

// Rust "does not have" default parameters
// fn default_param(k : i32, j : i32 = 123)
// {
//     println!("Called default param: {k} {j}")
// }

// Rust does not support classical fkt overloading
// fn fkt(k: i32) -> i32 {
//     k + 123
// }

// fn fkt(j: u8, i : u8) -> u8 {
//     j + 1
// }

fn unused_t(var: i32, _var2: i32, _: i32) { // _var2 and _ are unused variables, variable with _ is immidiately dropped
                                            // Why? Maybe we want, that the destructor of the 3rd variable is called (if it has one)
                                            // See for examle datatypes.rs, where we only want the type of a variable
    println!("Unused var called");
}

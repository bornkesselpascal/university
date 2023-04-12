const MY_CONST : u32 = 123;
//let x = 321; // does not work!

pub fn main() {
    let var = 123;
    println!("We got a var of: {var}");
    //var = 321;  This does not work
    //println!("Changed var to: {var}");

    let mut var_mut = 123;
    println!("We got a mutable var of: {var_mut}");
    var_mut = -321;
    println!("Changed this mutable var to: {var_mut}");

    let mut test_var = 123;
    println!("We got another test_var of: {test_var}");

    println!("I can now access my const: {MY_CONST}");

    // Create constant
    const MY_CONST : u32 = 123; // Type must be specified here, no autotype
    test_var = MY_CONST + 5;
    //const OTHER_CONST : u32 = var * 3; // does not work, value needs to be known at compile time

    {
        let var = var * 9; // ! Shadowing, creates new var in block, overwrite only the variable name
        println!("The value of (inner) var is: {var}"); // Read var from outside, create new var in block, does not change outside var
    }
    println!("The value of (outer) var is: {var}")
}

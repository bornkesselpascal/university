fn call_by_ref(t_str: &String) { // Called by reference, so it is not moved inside the function, the original reference is still valid
    println!("I got: {t_str}");
    // t_str.push_str("Oh nooo"); // does not work
}

fn call_by_mut_ref(t_str: &mut String) {
    t_str.push_str("I tried this change");
}

fn mut_refs() {
    let mut x = 123;
    let x3 = &mut x;
    *x3 = -321;

    println!("The value of x is : {x}");
}

fn mult_mut_refs() {
    let mut x = 123;

    let x_r1 = &x;
    let x_r2 = &x;

    println!("Vals of x_r1 ({x}) and x_r2 ({x_r1}) and x ({x_r2})");

    let x_mr1 = &mut x;

    //println!("Printing x_r1({x_r1})"); // this line leads to an error
}

// Does not work!
// fn inv_return() -> & /*'static*/ String {
//     let x = String::from("An example string");
//     &x  // We return a reference to x, but x is destroyed when the function ends
// We also can not return a reference to a local variable, because the variable is destroyed when the function ends
// }

fn val_return() -> String {
    let x = String::from("An example string");
    x
}

pub fn main() {
    let x = String::from("Hello world");
    call_by_ref(&x); // If we want to call it by reference, we need to pass & to the function
    println!("I can access it: {x}"); // We can call it, there is only one valid owner, we just borrowed it

    let mut z = String::from("Hello world2");
    call_by_mut_ref(&mut z);

    // We can borrow multiple immutable references, but only one mutable reference (and then no other mutable or immutable references if we borrowed it as mutable)
    println!("I now have: {z}");

    mut_refs();
    //mult_mut_refs();
    let x = val_return();
    println!("I got: {x}");
}

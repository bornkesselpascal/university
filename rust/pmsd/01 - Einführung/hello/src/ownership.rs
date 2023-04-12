fn basic_example() {
    // this all happens on stack
    let x: i32 = 123;
    let y = x;

    println!("x({x}) and y({y})");

    let z = "hello";
    let z2 = z;

    println!("z({z}) and z2({z2})");
}

fn complex_example() {
    // we now need to change to heap!
    let x = String::from("Hello world!");

    let y = x; // x is moved to y, x is not valid anymore; invalidation by compiler
    // In C++ it would call the copy constructor (if present) or the move constructor (if we dont use x later)

    println!("The value of y({y})");
    //println!("The value of x({x})"); // this does not work anymore
    // because x is moved to y, x is not valid anymore (value borrowed here after move)
}

fn complex_example_2() {
    let s = String::from("Hello world");
    {
        let xs2 = String::from("Hello world 2");

        //xs2 goes out of scope, mem freed
    }
    // println!("Access xs2: {xs2}"); // is not allowed anymore, xs2 was freed because reference got out of scope

    // s goes out of scope, memory freed
}

fn clone_example() {
    // Sometimes we need two references to the same object, we can use clone
    // clone is a deep copy, it copies the whole object (on the heap), thei are pointing to different objects on the heap
    let s = String::from("Hello world");
    let s2 = s.clone();

    // Clone is only possible for types that implement the Clone trait, it does a deep copy (copy of the whole object)
    // The copy trait allows to copy the object, it is a shallow copy (copy of the pointer to the object on the heap) without invalidating the original reference

    // Clone is our own implementation, we need to specify it for our own types

    println!("s({s}) and s2({s2})");
}

fn call_move_str(t_str: String) { // Called without reference, so it is moved inside the function and the original reference is invalid, then it is destroyed, ownership is transferred
    println!("My received str is: {t_str}");
}

fn call_move_int(t_int: i32) { // Called by copy, not by move
    println!("My received i32 is: {t_int}");
}

fn ret_other() -> String {
    let x = String::from("Hello world");
    x
}

fn tak_ret(t_str: String) -> String { // Called by move, ownership is transferred, then it is returned
    println!("Got in tak_ret: {t_str}");
    t_str
} // Bad practise, because it is copied twice, first to t_str, then to the return value (if we had two varibles we need to return a tuple)

pub fn main() {
    basic_example();
    complex_example();
    complex_example_2();
    clone_example();

    let y = 123;
    call_move_int(y);
    println!("I would like to print y: {y}");

    let x = String::from("Hello world");
    call_move_str(x); // x is moved to the function, x is not valid anymore (beacuse not called by reference)
    // Behavior is very different to C++ (copy constructor would be called, x would be still valid)
    //println!("I would like to print x: {x}"); // does not work

    let z = ret_other(); // This is allowed
    println!("I got z: {z}"); // z is the only valid reference to the object

    let z1 = tak_ret(z);
    println!("And again z1: {z1}");
}

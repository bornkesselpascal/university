use std::{borrow::BorrowMut, cell::RefCell, rc::Rc};

struct MyStruct {
    val1: i32,
}

impl Drop for MyStruct {
    fn drop(&mut self) {
        println!("Drop thingy...");
    }
}

fn box_ptr() {
    let mut x = Box::new(MyStruct { val1: -99 }); // Box is a smart pointer, it is a pointer to a heap allocated object

    // Box pointer has only one owner, it is moved when it is assigned to another variable
    println!("This is on heap... {}", x.val1);
    x.val1 = 123;
    println!("This is on heap... {}", x.val1);
    change_box_ptr(&mut x); // &mut x is a mutable reference to x which is a Box pointer to MyStruct

    println!("This is on heap... {}", x.val1);
}

fn change_box_ptr(i: &mut Box<MyStruct>) { // If we had the box pointer not as a reference, it would be moved and we would not be able to use it anymore (borrowing)
    println!("I got something {}", i.val1);
    i.val1 = 999;
}

fn my_ptr(i: &mut Box<MyStruct>) {
    println!("Begin my_tr...");
    *i = Box::new(MyStruct { val1: -123 }); // Create a new box pointer and assign it to i, on C++ this would be a memory leak, but on Rust the old box pointer is destroyed
    // We dont need to free the old box pointer, it is destroyed automatically
    println!("Mid my_tr...");
    *i = Box::new(MyStruct { val1: -321 }); // On C++ you cant reassign a smart pointer, but on Rust you can
    println!("End my_tr...");
}

fn rc_ptr() { // Rc is a reference counted pointer, it is a pointer to a heap allocated object, but it can have multiple owners, in C++ this would be a shared pointer
    let x = Box::new(MyStruct { val1: 99 });
    let y = x; // ONlny one owner, x is moved to y, x is not valid anymore

    println!("Value is: {}", y.val1 /*x.val1 would not work,because box ptr has only one valid referene*/);

    let mut z = Rc::new(MyStruct { val1: -99 });

    let a = Rc::clone(&z); // We need to clone the pointer, because we want to have two owners, we can not move it, because it has multiple owners and also not copy it, because it is a pointer (copy would do a primitive memory copy)
    println!("Values are {} and {}", z.val1, a.val1);

    // z.val1 = 99; // does not work because we need to do dereferencing which is not implemented here
    let v = Rc::get_mut(&mut z);  // We need to get a mutable reference to z, because we want to change the value of z
    match v {                                                  // We need to do this, because we can not change the value of z, because it has multiple owners
        Some(x) => x.val1 = 123,                // If we request two times a multiple reference, we would get none
        None => println!("can't do that change"),
        // We are here in none, beacuse we have two references to it

        // Returns a mutable reference into the given Rc, if there are no other Rc or Weak pointers to the same allocation.
        // Returns None otherwise, because it is not safe to mutate a shared value.
    }

    println!("{} HERE", z.val1);
}

fn ref_cell() {
    let mut x = Rc::new(RefCell::new(MyStruct { val1: 321 })); // This is a reference counted pointer to a RefCell, which is a smart pointer to a heap allocated object, but it can have multiple owners, but it can be borrowed mutably
    println!("Initial val: {}", x.borrow().val1); // We need to call borror (after auto-deref), which allows us to access the value of the RefCell

    let mut r = RefCell::borrow_mut(&mut x); // We need to borrow the RefCell mutably, because we want to change the value of the RefCell
    // If there is another mutable borrow to the RefCell, we would get an error, because we can not have multiple mutable references to the same object
    r.val1 = 99;

    println!("New value is {}", r.val1);

    // We have mutliple Rcs to the same value, and we can now edit it
    // Without RefCell we would not be able to do this 
    // But we can not have multiple mutable borrows to the same value	
}

pub fn main() {
    //box_ptr();

    //let mut x = Box::new(MyStruct { val1: -999 });
    //my_ptr(&mut x);

    //rc_ptr();
    ref_cell();

    println!("End of main");
}

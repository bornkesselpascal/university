struct Example {
    var1: i32,
    var2: i32,
    add: bool,
}

// Structs are used for storing data in a structured way (not like tuples)

struct ComplexExample {
    var1: i32,
    var2: i32,
    add: String,
}

fn my_example_struct() {
    let x = Example { // We need to provide all fields, but the order does not matter
        var1: 123,
        var2: 321,
        add: true,
    };

    // Everything is put into the stack, no heap allocation

    println!("The struct has: {} - {} and {}", x.var1, x.var2, x.add);

    //x.add = false; // does not work
}

fn my_example_mut_struct() {
    let mut x = Example { // A mutable struct, fileds are also mutable (alle!)
        var1: 123,
        var2: 321,
        add: true,
    };

    x.add = false;

    println!("The struct has: {} - {} and {}", x.var1, x.var2, x.add);
}

fn example_inst() {
    let x = Example {
        var2: 321, // Do not forget the comma
        var1: 123,
        add: true,
    };

    let y = Example { ..x }; // Copy all fields from x, make a copy of x with ..x
    println!("The struct has: {} - {} and {}", y.var1, y.var2, y.add); // Access the fields with the dot operator and the field name
    println!("The org struct has: {} - {} and {}", x.var1, x.var2, x.add);

    let cx = ComplexExample {
        var1: 123,
        var2: 321,
        add: String::from("Hello world..."), // This is a String, not a &str and it lives on the heap! (not on the stack like any other vars here )
    };


    let cy = ComplexExample { ..cx };
    println!("Complex str is: {}", cy.add);
    //println!("Org str is: {}", cx.add) // does not work!
}

pub fn main() {
    //my_example_struct();
    //my_example_mut_struct();
    example_inst();
}

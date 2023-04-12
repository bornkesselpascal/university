fn if_else() {
    let num = 3;

    if num > 3 {
        println!("Number greater than 3");
    } else if num < 3 {
        println!("Number smaller than 3");
    } else {
        println!("Numer is 3");
    }
}

fn if_let() {
    let x = 9;
    let y = if x > 5 { 3 } else { 7 };

    // let z = if x > 5 { "three" } else { 7 }; // does not work

    println!("y is assigned: {y}");
}

fn basic_loop() {
    let mut x = 0;

    loop {
        x += 1;

        if x < 5 {
            continue;
        }

        println!("val of x is {x}");

        if x > 10 {
            break;      // Control the loop ending yourself
        }
    }

    x = 0;
    let re = loop {
        x += 1;

        if x > 15 {
            break x * 10; // Break can also return a value and assign this to re
        }
    };
    println!("Result is: {re}");
}

fn while_loop() {
    let mut var = 0;

    while var < 10 {
        var += 1;
        // continue + break work here too
    }

    println!("Var is: {var}");

    // does not work: KEEP IN MIND
    // var = -6;
    // let x = while var < 10 {
    //     if var == 5 {
    //         break var * 9;
    //     }
    //     var += 1;
    // };
}

fn for_loop() {
    let ar = [1, 2, 3, 4, 5];

    for elem in ar { // iterates over the array (or any other iterable/element)
        if elem < 3 {
            continue;
        } else if elem > 4 {
            break;
        }
        println!("Value is: {elem}");
    }
    
    // does not work
    // let tup = (1, 2, 3, 4);
    // for elem in tup {
    //     println!("Value is: {}")
    // }

    for z in (1..5) {
        println!("The z val is {z}");
    }
}

/*
fn if_wrong_type() {
let num = 9;
*/

// does not work
// if num {
//     println!("I would print something")
// }
//}

pub fn main() {
    //if_else();
    //if_let();
    //basic_loop();
    //while_loop();
    for_loop();
}

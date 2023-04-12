use std::fmt::Error;

fn do_panic() {
    panic!("Something went really wrong!");
}

fn do_return(val: bool) -> Result<i32, Error> {
    if val {
        Result::Ok(123)
    } else {
        Result::Err(Error {})
    }
}

pub fn main() {
    //do_panic();

    let res = do_return(true);

    // This type of exception handling is not very common in Rust
    match res {
        Ok(r) => println!("I got: {}", r),
        Err(_) => println!("There was an error"),
    }

    // This is the more common way to handle exceptions
    let r = res.unwrap(); // This will panic if there is an error (unwrap_or(0) would return 0 if there is an error)
    println!("Anything else: {r}");

    // Example with unwrap_or_else
    let res = do_return(false);
    let r = res.unwrap_or_else(|e| {
        println!("There was an error: {}", e);
        0
    });

    // Explanation of the above:
    // unwrap_or_else takes a closure as an argument, which is executed if there is an error
    // The closure takes the error as an argument, and returns the value that should be returned if there is an error
    // The closure is only executed if there is an error, so it is not executed if there is no error
    // The closure is executed before the unwrap_or_else function returns
    
    // What is a closure?
    // A closure is a function that is defined inside another function
    // The closure can access the variables of the outer function
    // The closure can be passed as an argument to another function
    // The closure can be returned from another function
    // The closure can be executed multiple times
}

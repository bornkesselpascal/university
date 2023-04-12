use std::collections::HashMap;

fn basic_collection(k: i32) {
    //let ar = [0; k]; // does not work
    let ar = [0; 5];

    println!("Element 3 of ar is: {}", ar[3]);
}

fn iterators_with_arrays_string() {
    let x = [
        String::from("a"),
        String::from("b"),
        String::from("c"),
        String::from("d"),
    ];

    let mut x1 = x.clone();
    let mut x2 = x.clone();
    let mut x3 = x.clone(); // We created a copy of x, really new arrays (everything is copied)

    // let mut x4 = x; // We moved x into x4, x is not valid anymore

    // A clone is a deep copy, so all the elements are copied
    // In python, clone would not copy the elements, but only the reference to the elements

    println!("Mem x {:p} and others: {:p} {:p} {:p}", &x, &x1, &x2, &x3);

    for (ctr, val) in x1.iter().enumerate() {
        println!("Enumerate on  {ctr} and {val}"); // Print out element and index
    }

    for elem in x2.iter_mut() {
        println!("Enumerate on {elem}");
        *elem = String::from("l"); // Mutable reference to the string
    }

    for (i, elem) in x3.into_iter().enumerate() { // Enumerate packs the index and the element into a tuple
        println!("Enumerate on {elem}"); // x3 is moved into the for loop, we do not borrow it
        // This iterator consumes the array, so we cannot use it anymore (it is moved into the for loop)
    }

    //println!("{} {} {} {}", x[1], x1[1], x2[1], x3[1]); // does not work
}

fn iterators_with_arrays_str() {
    let x = ["a", "b", "c", "d"]; // Now an array with basic strings
    // These strings are on the text section of the binary, so they are immutable / the array has a reference to the strings

    let mut x1 = x; // Cannot be cloned
    let mut x2 = x;
    let mut x3 = x;

    println!("STR Mem x {:p} and others: {:p} {:p} {:p}", &x, &x1, &x2, &x3);

    for (ctr, val) in x1.iter().enumerate() {
        println!("Enumerate on  {ctr} and {val}");
    }

    for elem in x2.iter_mut() {
        println!("Enumerate on {elem}");
        *elem = "l";
    }

    for elem in x3 {
        println!("Ohter iter... {elem}");
    }

    for elem in x3.into_iter() {
        println!("Enumerate on {elem}");
    } // IntoIter does the same as an assignment, it moves the array into the for loop
    // This here does not consume the array, so we can use it again (beacause it is coqied here for &str)

    println!("{} {} {} {}", x[1], x1[1], x2[1], x3[1]);
}

fn vectors() {
    // Two ways to create a vector
    let v0 = vec![1, 2, 3, 4];
    let mut v1: Vec<i32> = Vec::new();

    v1.push(123);
    v1.push(456);
    v1.push(789);

    println!("Content of v0 {:?} and v1 {:?}", v0, v1);

    let idx_sel = 2;

    // getting elements:
    println!("The first element is: {}", v0[idx_sel]); // will panic if out of bounds
    // We dont read memory that is not ours, so we do not get a segfault just a panic

    match v0.get(idx_sel) {
        Some(x) => println!("We got the value: {}", x),
        None => println!("This was a out of bounds thing"),
    } 
    // match will return a value, so we can use it in the next line
    // or it will return a None, so we can do something else (out of bounds)

    v1[0] = -123;
    match v1.get_mut(1) {
        Some(x) => *x = -999,
        None => println!("Can't do that"),
    }
    v1.pop();

    println!("Content of v1 {:?} with a len {}", v1, v1.len());
}

fn hash_map() {
    let mut my_map: HashMap<i32, char> = HashMap::new();

    my_map.insert(3, 'a');
    my_map.insert(7, 'c');

    for (k, v) in my_map.iter() {
        println!("{k} -- {v}");
    }

    for (k, v) in &my_map {
        println!("{k} - {v}");
    }

    my_map.insert(5, 'f');
    my_map.insert(3, 'k');

    println!("{:?}", my_map);

    // It is never failing, it will just return None (Vacant entry means that the key may be not in the map)
    let x = my_map.entry(10).or_insert('l'); // If the key is not in the map, insert it

    println!("{}", x);
    println!("{:?}", my_map);
}

pub fn main() {
    basic_collection(4);
    iterators_with_arrays_string();
    iterators_with_arrays_str();
    vectors();
    hash_map();
}

enum Vehicle {
    CAR(i32),
    TRUCK { max_l: i32, other_l: i32 },
    AIRPLANE,
    FERRY,
    TRAIN(i32),
}

fn check_vehicle() {
    let _x = Vehicle::AIRPLANE;
    let _y = Vehicle::CAR(123);

    match _y {
        Vehicle::AIRPLANE => println!("I am an airplane"),

        Vehicle::TRUCK { max_l, .. } => {
            println!("I am a ferry with max_l {max_l}");
        }

        Vehicle::CAR(ps) => println!("I am an car with {ps} ps",),

        _ => println!("I am something else"),
    }
}

fn check_val() {
    let x = 999;

    match x {
        1 => println!("I received 1"),
        2 | 3 | 4 => println!("I received 2,3 or 4"),
        i if i < 3 => println!("I got smething negative"),
        //i if i > 4 => println!("OK"),
        _ => println!("I got something else"),
    }
}

fn ret_opt(k: i32) -> Option<i32> {
    if k < 0 {
        None
    } else {
        Some(k)
    }
}

fn optional_fkt() {
    let x = ret_opt(123);
    match x {
        Some(v) => println!("I received some value {v}"),
        None => println!("well, nothing received..."),
    }
}

pub fn main() {
    //check_vehicle();
    //check_val();
    optional_fkt();
}

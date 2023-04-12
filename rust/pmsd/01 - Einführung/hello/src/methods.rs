struct Test {
    var1: i32, // vars are protected by default, they can be accessed in the same module
    var2: i32,
}

impl Test { // impl is used to implement methods for a struct
    fn add(&self) -> i32 { // &self is a reference to the object, it is IMMUTABLE, use it to read values
        self.var1 + self.var2
    }

    fn sub(&self) -> i32 {
        self.var1 - self.var2
    }

    fn mul(&self) -> i32 {
        return self.var1 * self.var2;
    }

    fn div(&self) -> i32 {
        self.var2 / self.var2
    }

    // overloading is not possible in rust...
}

impl Test {
    fn exchange_vals(&mut self) {
        let tmp = self.var1;
        self.var1 = self.var2;
        self.var2 = tmp;
    }

    fn set_new(&mut self, var: i32) {
        self.var1 = var;
    }

    fn print_vars(&self) {
        println!("The vars are: {} and {}", self.var1, self.var2);
    }

    fn new() {
        println!("This is new");
    }
}

pub fn main() {
    let t = Test { var1: 1, var2: 2 };

    println!("The result is {}", t.add());

    // t.exchange_vals(); // does not work as it changes values (&mut self)
    (&t).print_vars();
    t.print_vars();

    let mut t2 = &t;
    // t2.set_new(5); // does not work as it changes values, t2 is a reference to t which is immutable
    // but we can change the reference to t2 to a mutable reference, beacuse the reference itself is mutable
    t.print_vars();

    let mut t = Test { var1: 3, var2: 4 };
    // Old t is not destroyed here, it is shadowed by the new t and destroyed we it goes out of scope
    t.exchange_vals();
    t.print_vars();

    // t.new() // this is a static method, it is called on the type itself, not on an instance
    Test::new();
}

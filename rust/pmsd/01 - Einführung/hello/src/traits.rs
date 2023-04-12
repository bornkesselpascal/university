// Provide a placeholder, like the C++ generics

fn get_max<T: std::cmp::PartialOrd>(l: &[T]) -> &T { // PartialOrd is a trait which needes to be implemented for the type T, if we would try it with a type which does not implement PartialOrd, we would get a compiler error
    let mut x = &l[0]; // copy the first element;

    for elem in l {
        if elem > x {
            x = elem;
        }
    }

    x
}

pub trait PrintSpecific { // trait is a definition of an interface (which requires these two functions in this case)
    fn small_print(&self);
    fn large_print(&self);
}

struct A1<T> { // T could be any type (int, string, float, ...)
    var1: T,
}

impl PrintSpecific for A1<i32> { // we can implement the trait for a specific type, we need to implement the functions of the trait
    fn small_print(&self) {
        println!("all is small here: {}", self.var1);
    }

    fn large_print(&self) {
        println!("ALL IS LARGE HERE: {}", self.var1);
    }
}

fn print_specific<T: PrintSpecific>(i: &T) { // Would only accept clases that implement the PrintSpecific trait (for generic T)
    i.small_print();
}

fn print_specific2<T: PrintSpecific + PartialOrd>(i: &T) { // also mutiple traits can be specified
    i.small_print();
}

fn print_specific_other<T>(i: &T)
where
    T: PrintSpecific, // We can also specify the trait in a where clause
{
    i.large_print();
}

pub fn main() {
    let x = [1, 3, 5, 3, 9, 1];

    println!("Max of li is: {}", get_max(&x)); // Would alos work if x would be floats

    let y = A1 { var1: -99 };
    // let y = A1 { var1: -99.0 }; // Would not work because the trait is not implemented for floats
    print_specific(&y);
    print_specific_other(&y);
}

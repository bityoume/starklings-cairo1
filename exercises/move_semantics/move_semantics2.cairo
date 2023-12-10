// move_semantics2.cairo
// Make me compile without changing line 16 or moving line 13!
// Execute `starklings hint move_semantics2` or use the `hint` watch subcommand for a hint.

use array::ArrayTrait;
use debug::PrintTrait;

fn main() {
    let arr0 = ArrayTrait::new();

    let mut arr1 = fill_arr(arr0.clone());

    // Do not change the following line!
    arr0.print();
}

fn fill_arr(arr: Array<felt252>) -> Array<felt252> {
    let mut arr = arr;

    arr.append(22);
    arr.append(44);
    arr.append(66);

    arr
}

// $ ./starklings hint move_semantics2
// So, `arr0` is passed into the `fill_arr` function as an argument. In Cairo,
// when an argument is passed to a function and it's not explicitly returned,
// you can't use the original variable anymore. We call this "moving" a variable.
// Variables that are moved into a function (or block scope) and aren't explicitly
// returned get "dropped" at the end of that function. This is also what happens here.
// There's a few ways to fix this, try them all if you want:
// 1. Make another, separate version of the data that's in `arr0` and pass that
//    to `fill_arr` instead.
// 2. Make `fill_arr` *mutably* borrow a reference to its argument (which will need to be
//    mutable) with the `ref` keyword , modify it directly, then not return anything. Then you can get rid
//    of `arr1` entirely -- note that this will change what gets printed by the
//    first `print`
// 3. Make `fill_arr` borrow an immutable view of its argument instead of taking ownership by using the snapshot operator `@`,
//    and then copy the data within the function in order to return an owned
//    `Array<felt>`. This requires an explicit clone of the array and should generally be avoided in Cairo, as the memory is write-once and cloning can be expensive. To clone an object, you will need to import the trait `clone::Clone` and the implementation of the Clone trait for the array located in `array::ArrayTCloneImpl`
# Как входные параметры

В то время как замыкания Rust выбирают способ захвата переменных на лету, по
большей части без указания типов, эта двусмысленность недопустима при написании
функций. При использовании замыкания в качестве входного параметра, его тип
должен быть указан с использованием одного из типажей. Вот они, в порядке
уменьшения ограничений:

- `Fn`: замыкание захватывает по ссылке (`&T`)
- `FnMut`: замыкание захватывает по изменяемой ссылке (`&mut T`)
- `FnOnce`: замыкание захватывает по значению (`T`)

Компилятор стремится захватывать переменные наименее ограничивающим способом.

Для примера, рассмотрим аргумент, указанный как `FnOnce`. Это означает, что
замыкание *может* захватывать `&T`, `&mut T`, или `T`, но компилятор в итоге
будет выбирать в зависимости от того, как захваченные переменные используются
в замыкании.

Это связано с тем, что если перемещение возможно, тогда любой тип заимствования
также должен быть возможен. Отметим, что обратное не верно. Если параметр
указан как `Fn`, то захват переменных как `&mut T` или `T` недопустим.

В следующем примере попробуйте поменять местами использование `Fn`, `FnMut`, и
`FnOnce`, чтобы увидеть результат:

```rust,editable
// A function which takes a closure as an argument and calls it.
// <F> denotes that F is a "Generic type parameter"
fn apply<F>(f: F) where
    // The closure takes no input and returns nothing.
    F: FnOnce() {
    // ^ TODO: Try changing this to `Fn` or `FnMut`.

    f();
}

// A function which takes a closure and returns an `i32`.
fn apply_to_3<F>(f: F) -> i32 where
    // The closure takes an `i32` and returns an `i32`.
    F: Fn(i32) -> i32 {

    f(3)
}

fn main() {
    use std::mem;

    let greeting = "hello";
    // A non-copy type.
    // `to_owned` creates owned data from borrowed one
    let mut farewell = "goodbye".to_owned();

    // Capture 2 variables: `greeting` by reference and
    // `farewell` by value.
    let diary = || {
        // `greeting` is by reference: requires `Fn`.
        println!("I said {}.", greeting);

        // Mutation forces `farewell` to be captured by
        // mutable reference. Now requires `FnMut`.
        farewell.push_str("!!!");
        println!("Then I screamed {}.", farewell);
        println!("Now I can sleep. zzzzz");

        // Manually calling drop forces `farewell` to
        // be captured by value. Now requires `FnOnce`.
        mem::drop(farewell);
    };

    // Call the function which applies the closure.
    apply(diary);

    // `double` satisfies `apply_to_3`'s trait bound
    let double = |x| 2 * x;

    println!("3 doubled: {}", apply_to_3(double));
}
```

### Смотрите также:

[`std::mem::drop`](https://doc.rust-lang.org/std/mem/fn.drop.html), [`Fn`](https://doc.rust-lang.org/std/ops/trait.Fn.html), [`FnMut`](https://doc.rust-lang.org/std/ops/trait.FnMut.html), [Обобщения](../../generics.md), [where](../../generics/where.md) и [`FnOnce`](https://doc.rust-lang.org/std/ops/trait.FnOnce.html)

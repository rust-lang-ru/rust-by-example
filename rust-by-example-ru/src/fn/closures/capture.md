# Захват

Замыкания довольно гибкие и делают всё, что требуется для работы с ними без
дополнительных указаний. Это позволяет захватывать переменные, перемещая их или
заимствуя, в зависимости от необходимости.
Замыкания могут захватывать переменные:

* по ссылке: `&T`
* по изменяемой ссылке: `&mut T`
* по значению: `T`

Они преимущественно захватывают переменные по ссылке, если явно не указан другой
способ.

```rust,editable
fn main() {
    use std::mem;

    let color = "green";

    // Замыкание для вывода `color`, которое немедленно заимствует (`&`)
    // `color` и сохраняет его и замыкание в переменной `print`.
    // `color` будет оставаться заимствованным до выхода `print` из области
    // видимости. `println!` требует только ссылку, поэтому он не накладывает
    // дополнительных ограничений.
    let print = || println!("`color`: {}", color);

    // Вызываем замыкание, используя заимствование.
    print();
    print();

    let mut count = 0;

    // Замыкание для увеличения `count` может принимать как `&mut count`,
    // так и `count`, но использование `&mut count` менее ограничено, так что
    // замыкание выбирает первый способ, т.е. немедленно заимствует `count`.
    //
    // `inc` должен быть `mut`, поскольку внутри него хранится `&mut`.
    // Таким образом, вызов замыкания изменяет его, что недопустимо без `mut`.
    let mut inc = || {
        count += 1;
        println!("`count`: {}", count);
    };

    // Вызываем замыкание.
    inc();
    inc();

    //let reborrow = &mut count;
    // ^ TODO: попробуйте раскомментировать эту строку.

    // Тип без возможности копирования.
    let movable = Box::new(3);

    // `mem::drop` требует `T`, так что захват производится по значению.
    // Копируемый тип будет скопирован в замыкание, оставив оригинальное
    // значение без изменения. Некопируемый тип должен быть перемещён, так что
    // `movable` немедленно перемещается в замыкание.
    let consume = || {
        println!("`movable`: {:?}", movable);
        mem::drop(movable);
    };

    // `consume` поглощает переменную, так что оно может быть вызвано только раз.
    consume();
    //consume();
    // ^ TODO: Попробуйте раскомментировать эту строку.
}
```

Using `move` before vertical pipes forces closure
to take ownership of captured variables:

```rust,editable
fn main() {
    // `Vec` has non-copy semantics.
    let haystack = vec![1, 2, 3];

    let contains = move |needle| haystack.contains(needle);

    println!("{}", contains(&1));
    println!("{}", contains(&4));

    // `println!("There're {} elements in vec", haystack.len());`
    // ^ Uncommenting above line will result in compile-time error
    // because borrow checker doesn't allow re-using variable after it
    // has been moved.
    
    // Removing `move` from closure's signature will cause closure
    // to borrow _haystack_ variable immutably, hence _haystack_ is still
    // available and uncommenting above line will not cause an error.
}
```

### Смотрите также:

[`Box`][box] and [`std::mem::drop`][drop]

[box]: std/box.html
[drop]: https://doc.rust-lang.org/std/mem/fn.drop.html

# `Result`

[`Result`](https://doc.rust-lang.org/std/result/enum.Result.html) является более богатой версией типа [`Option`](https://doc.rust-lang.org/std/option/enum.Option.html), тип который описывает возможную *ошибку* вместо возможного её *отсутствия*.

`Result<T, E>` имеет два возможных значения:

- `Ok<T>`: Значение типа `T`
- `Err<E>`: Ошибка обработки элемента, типа `E`

By convention, the expected outcome is `Ok` while the unexpected outcome is `Err`.

Like `Option`, `Result` has many methods associated with it. `unwrap()`, for
example, either yields the element `T` or `panic`s. For case handling,
there are many combinators between `Result` and `Option` that overlap.

In working with Rust, you will likely encounter methods that return the
`Result` type, such as the [`parse()`](https://doc.rust-lang.org/std/primitive.str.html#method.parse) method. It might not always
be possible to parse a string into the other type, so `parse()` returns a
`Result` indicating possible failure.

Давайте посмотрим, что происходит, когда мы успешно и безуспешно попытаемся преобразовать строку с помощью `parse()`:

```rust,editable,ignore,mdbook-runnable
fn multiply(first_number_str: &str, second_number_str: &str) -> i32 {
    // Давайте попробуем использовать `unwrap()` чтобы получить число. Он нас укусит?
    let first_number = first_number_str.parse::<i32>().unwrap();
    let second_number = second_number_str.parse::<i32>().unwrap();
    first_number * second_number
}

fn main() {
    let twenty = multiply("10", "2");
    println!("удовоенное {}", twenty);

    let tt = multiply("t", "2");
    println!("удвоенное {}", tt);
}
```

In the unsuccessful case, `parse()` leaves us with an error for `unwrap()`
to `panic` on. Additionally, the `panic` exits our program and provides an
unpleasant error message.

To improve the quality of our error message, we should be more specific
about the return type and consider explicitly handling the error.

## Использование `Result` в `main`

The `Result` type can also be the return type of the `main` function if
specified explicitly. Typically the `main` function will be of the form:

```rust
fn main() {
    println!("Hello World!");
}
```

However `main` is also able to have a return type of `Result`. If an error
occurs within the `main` function it will return an error code and print a debug
representation of the error (using the [`Debug`](https://doc.rust-lang.org/std/fmt/trait.Debug.html) trait). The following example
shows such a scenario and touches on aspects covered in [the following section](result/early_returns.md).

```rust,editable
use std::num::ParseIntError;

fn main() -> Result<(), ParseIntError> {
    let number_str = "10";
    let number = match number_str.parse::<i32>() {
        Ok(number)  => number,
        Err(e) => return Err(e),
    };
    println!("{}", number);
    Ok(())
}
```

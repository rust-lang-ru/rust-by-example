# `FromStr` и `ToString`

## Конвертация в строку

To convert any type to a `String` is as simple as implementing the [`ToString`](https://doc.rust-lang.org/std/string/trait.ToString.html)
trait for the type. Rather than doing so directly, you should implement the
[`fmt::Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html) trait which automagically provides [`ToString`](https://doc.rust-lang.org/std/string/trait.ToString.html) and
also allows printing the type as discussed in the section on [`print!`](../hello/print.md).

```rust,editable
use std::fmt;

struct Circle {
    radius: i32
}

impl fmt::Display for Circle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Круг радиусом {}", self.radius)
    }
}

fn main() {
    let circle = Circle { radius: 6 };
    println!("{}", circle.to_string());
}
```

## Парсинг строки

One of the more common types to convert a string into is a number. The idiomatic
approach to this is to use the [`parse`](https://doc.rust-lang.org/std/primitive.str.html#method.parse) function and provide the type for the
function to parse the string value into, this can be done either without type
inference or using the 'turbofish' syntax.

This will convert the string into the type specified so long as the [`FromStr`](https://doc.rust-lang.org/std/str/trait.FromStr.html)
trait is implemented for that type. This is implemented for numerous types
within the standard library. To obtain this functionality on a user defined type
simply implement the [`FromStr`](https://doc.rust-lang.org/std/str/trait.FromStr.html) trait for that type.

```rust
fn main() {
    let parsed: i32 = "5".parse().unwrap();
    let turbo_parsed = "10".parse::<i32>().unwrap();

    let sum = parsed + turbo_parsed;
    println!("Сумма: {:?}", sum);
}
```
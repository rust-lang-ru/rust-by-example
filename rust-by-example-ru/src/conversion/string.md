# `FromStr` и `ToString`

## Конвертация в строку

Преобразовать любой тип в `String` так же просто, как и реализовать для него типаж [`ToString`](https://doc.rust-lang.org/std/string/trait.ToString.html). Вместо того, чтобы делать это напрямую, вы должны реализовать типаж [`fmt::Display`](https://doc.rust-lang.org/std/fmt/trait.Display.html), который автоматически предоставляет реализацию [`ToString`](https://doc.rust-lang.org/std/string/trait.ToString.html), а 
также позволяет распечатать тип, как обсуждалось в секции [`print!`](../hello/print.md).

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

Один из наиболее общим типов конвертации - это преобразование строки в число. Идиоматический подход это сделать при помощи функции [`parse`](https://doc.rust-lang.org/std/primitive.str.html#method.parse) и указания типа, в который будем преобразовывать, что можно сделать либо через выведение типа, либо при помощи 'turbofish'-синтаксиса.

Это преобразует строку в указанный тип при условии, что для этого типа реализован типаж [`FromStr`](https://doc.rust-lang.org/std/str/trait.FromStr.html). 
Он реализован для множества типов стандартной библиотеки. 
Чтобы получить эту функциональность для пользовательского типа, надо просто реализовать для этого типа типаж [`FromStr`](https://doc.rust-lang.org/std/str/trait.FromStr.html).

```rust
fn main() {
    let parsed: i32 = "5".parse().unwrap();
    let turbo_parsed = "10".parse::<i32>().unwrap();

    let sum = parsed + turbo_parsed;
    println!("Сумма: {:?}", sum);
}
```

# Ограничения

При работе с обобщениями параметры типа часто должны использовать типажи
в качестве *ограничений*, чтобы определить какие функциональные возможности
реализует тип. Например, в следующем примере для печати используется
типаж `Display` и поэтому требуется `T` ограничить по `Display`.
Это значит что `T` *должен* реализовать `Display`.

```rust,ignore
// Определим функцию `printer`, которая принимает обобщённый тип `T`,
// который должен реализовать типаж `Display`
fn printer<T: Display>(t: T) {
    println!("{}", t);
}
```

Ограничение сужает список типов, допустимых к использованию. То есть:

```rust,ignore
struct S<T: Display>(T);

// Ошибка! `Vec<T>` не реализует `Display`. Эта
// специализация не удастся
let s = S(vec![1]);
```

Другой эффект ограничения заключается в том, что обобщённые экземпляры
имеют доступ к [`методам`](fn/methods.html) типажей, указанных в ограничениях. Например:

```rust,editable
// Типаж, который реализует маркер печати: `{:?}`.
use std::fmt::Debug;

trait HasArea {
    fn area(&self) -> f64;
}

impl HasArea for Rectangle {
    fn area(&self) -> f64 { self.length * self.height }
}

#[derive(Debug)]
struct Rectangle { length: f64, height: f64 }
#[allow(dead_code)]
struct Triangle  { length: f64, height: f64 }

// Обобщённый тип `T` должен реализовать `Debug`. Независимо
// от типа, это будет работать правильно.
fn print_debug<T: Debug>(t: &T) {
    println!("{:?}", t);
}

// `T` должен реализовать `HasArea`. Любая функция, которая удовлетворяет
// ограничению может получить доступ к функции `area` из `HasArea`.
fn area<T: HasArea>(t: &T) -> f64 { t.area() }

fn main() {
    let rectangle = Rectangle { length: 3.0, height: 4.0 };
    let _triangle = Triangle  { length: 3.0, height: 4.0 };

    print_debug(&rectangle);
    println!("Area: {}", area(&rectangle));

    //print_debug(&_triangle);
    //println!("Area: {}", area(&_triangle));
    // ^ TODO: Попробуйте раскомментировать эти строки.
    // | Ошибка: Не реализован `Debug` или `HasArea`.
}
```

Утверждения [`where`](generics/where.html) также могут использоваться для применения
ограничений в некоторых случаях, чтобы добавить выразительности.

### Смотрите также:

[`std::fmt`](../hello/print.md)[, ](../hello/print.md)[`struct`](../custom_types/structs.md) и [`trait`](../trait.md)

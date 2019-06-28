# `From` и `Into`

Типажи [`From`](https://doc.rust-lang.org/std/convert/trait.From.html) и [`Into`](https://doc.rust-lang.org/std/convert/trait.Into.html) связаны по своей сути, и это стало частью их реализации. Если вы можете конвертировать тип `А` в тип `В`, то будет легко предположить, что мы должны быть в состоянии конвертировать тип `В` в тип `А`.

## `From`

Типаж [`From`](https://doc.rust-lang.org/std/convert/trait.From.html) позволяет типу определить, как он будет создаваться из другого типа, что предоставляет очень простой механизм конвертации между несколькими типами. Есть несколько реализаций этот типажа в стандартной библиотеке для преобразования примитивов и общих типов.

Для примера, мы можем легко конвертировать `str` в `String`

```rust
let my_str = "привет";
let my_string = String::from(my_str);
```

Мы можем сделать нечто похожее для определения конвертации для нашего собственного типа.

```rust,editable
use std::convert::From;

#[derive(Debug)]
struct Number {
    value: i32,
}

impl From<i32> for Number {
    fn from(item: i32) -> Self {
        Number { value: item }
    }
}

fn main() {
    let num = Number::from(30);
    println!("Мой номер {:?}", num);
}
```

## `Into`

Типаж [`Into`](https://doc.rust-lang.org/std/convert/trait.Into.html) является полной противоположностью типажа `From`. Так что если вы реализовали для вашего типа типаж  `From`, реализацию типажа `Into` вы получите бесплатно.

Использование типажа `Into` обычно требует спецификации типа, в который мы собираемся конвертировать, так как компилятор чаще всего не может это вывести.
Однако это небольшой компромисс, учитывая, что данную функциональность мы получаем бесплатно.

```rust,editable
use std::convert::From;

#[derive(Debug)]
struct Number {
    value: i32,
}

impl From<i32> for Number {
    fn from(item: i32) -> Self {
        Number { value: item }
    }
}

fn main() {
    let int = 5;
    // Попробуйте убрать аннотацию типа
    let num: Number = int.into();
    println!("Мой номер {:?}", num);
}
```

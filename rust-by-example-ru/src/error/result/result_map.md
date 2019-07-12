# `map` для `Result`

Паника в предыдущем примере делает код ненадёжным.
Обычно, мы хотим вернуть ошибку вызывающей стороне, чтобы 
уже она решала, как с ней поступить.

Первое, что нам нужно знать - это с каким типом ошибки мы 
работаем. Для определения типа `Err`, мы посмотрим 
на [`parse()`](https://doc.rust-lang.org/std/primitive.str.html#method.parse), реализованную с типажом 
[`FromStr`](https://doc.rust-lang.org/std/str/trait.FromStr.html) для [`i32`](https://doc.rust-lang.org/std/primitive.i32.html).
В результате, тип `Err` указан как 
[`ParseIntError`](https://doc.rust-lang.org/std/num/struct.ParseIntError.html).

В примере ниже, простой `match` делает код более громоздким.

```rust,editable
use std::num::ParseIntError;

// Мы используем сопоставление с образцом без `unwrap()` и меняем тип результата.
fn multiply(first_number_str: &str, second_number_str: &str) -> Result<i32, ParseIntError> {
    match first_number_str.parse::<i32>() {
        Ok(first_number)  => {
            match second_number_str.parse::<i32>() {
                Ok(second_number)  => {
                    Ok(first_number * second_number)
                },
                Err(e) => Err(e),
            }
        },
        Err(e) => Err(e),
    }
}

fn print(result: Result<i32, ParseIntError>) {
    match result {
        Ok(n)  => println!("n равно {}", n),
        Err(e) => println!("Ошибка: {}", e),
    }
}

fn main() {
    // Это даёт разумный ответ.
    let twenty = multiply("10", "2");
    print(twenty);

    // Следующее теперь предоставляет более понятное сообщение об ошибке.
    let tt = multiply("t", "2");
    print(tt);
}
```

К счастью, `map`, `and_then` многие 
другие комбинаторы `Option` также реализованы и 
для `Result`. 
<a href="https://doc.rust-lang.org/std/result/enum.Result.html" data-md-type="link">Документация по `Result`</a> содержит полный 
их список.

```rust,editable
use std::num::ParseIntError;

// Как и с `Option`, мы можем использовать комбинаторы, как `map()`.
// Эта функция в основном идентична предыдущей и читается как:
// изменяем n при валидном значении, иначе передаём ошибку.
fn multiply(first_number_str: &str, second_number_str: &str) -> Result<i32, ParseIntError> {
    first_number_str.parse::<i32>().and_then(|first_number| {
        second_number_str.parse::<i32>().map(|second_number| first_number * second_number)
    })
}

fn print(result: Result<i32, ParseIntError>) {
    match result {
        Ok(n)  => println!("n равно {}", n),
        Err(e) => println!("Ошибка: {}", e),
    }
}

fn main() {
    // Это даёт разумный ответ.
    let twenty = multiply("10", "2");
    print(twenty);

    // Следующее теперь предоставляет более понятное сообщение об ошибке.
    let tt = multiply("t", "2");
    print(tt);
}
```

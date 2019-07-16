# Представляем: `?`

Иногда мы хотим получить простоту `unwrap`, но без 
`panic`. До текущего момента `unwrap` 
заставлял нас делать всё больше и больше, в то время как мы 
хотели только *извлечь* переменную. Для этих целей был 
введён `?`.

При обнаружении `Err`, можно выполнить два действия:

1. `panic!`, который мы решили по возможности избегать 
2. `return` так как возврат `Err` говорит о том, что мы её не обрабатывали

`?` *почти*[^†] эквивалентен
`unwrap`, который при `Err` делает 
`return` вместо `panic`. Давайте 
посмотрим как мы можем упростить наш пример, использующий 
комбинаторы:

```rust,editable
use std::num::ParseIntError;

fn multiply(first_number_str: &str, second_number_str: &str) -> Result<i32, ParseIntError> {
    let first_number = first_number_str.parse::<i32>()?;
    let second_number = second_number_str.parse::<i32>()?;

    Ok(first_number * second_number)
}

fn print(result: Result<i32, ParseIntError>) {
    match result {
        Ok(n)  => println!("n равно {}", n),
        Err(e) => println!("Ошибка: {}", e),
    }
}

fn main() {
    print(multiply("10", "2"));
    print(multiply("t", "2"));
}
```

## Макрос `try!`

До появления `?`, аналогичная функциональность 
была доступна через макрос `try!`.
Сейчас рекомендуется использовать оператор `?`, но 
вы до сих пор можете найти `try!`, когда 
просматриваете старый код. Функция `multiply` из 
предыдущего примера с использованием `try!` будет 
выглядеть следующим образом:

```rust,editable
// Для компиляции и запуска с помощью Cargo этого примера без ошибок
// поменяйте в `Cargo.toml` значение поля `edition` секции 
// `[package]` на "2015".

use std::num::ParseIntError;

fn multiply(first_number_str: &str, second_number_str: &str) -> Result<i32, ParseIntError> {
    let first_number = try!(first_number_str.parse::<i32>());
    let second_number = try!(second_number_str.parse::<i32>());

    Ok(first_number * second_number)
}

fn print(result: Result<i32, ParseIntError>) {
    match result {
        Ok(n)  => println!("n равно {}", n),
        Err(e) => println!("Ошибка: {}", e),
    }
}

fn main() {
    print(multiply("10", "2"));
    print(multiply("t", "2"));
}
```

[^†]: Посмотрите главу ["Другие способы использования `?`"](../multiple_error_types/reenter_question_mark.md) для большей информации.

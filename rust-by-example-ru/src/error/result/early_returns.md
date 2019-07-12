# Ранний выход

В предыдущем примере мы явно обработали ошибки при помощи комбинаторов.
Другой способ сделать это - использовать комбинацию выражения 
`match` и *раннего выхода*.

Таким образом мы просто можем остановить работу функции и 
вернуть ошибку, если она произошла. Для некоторых, такой код 
будет легче в чтении и написании. Посмотрите код из предыдущего 
примера, переписанный с использованием раннего выхода:

```rust,editable
use std::num::ParseIntError;

fn multiply(first_number_str: &str, second_number_str: &str) -> Result<i32, ParseIntError> {
    let first_number = match first_number_str.parse::<i32>() {
        Ok(first_number)  => first_number,
        Err(e) => return Err(e),
    };

    let second_number = match second_number_str.parse::<i32>() {
        Ok(second_number)  => second_number,
        Err(e) => return Err(e),
    };

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

На данный момент, мы изучили обработку ошибок при помощи 
комбинаторов и раннего выхода. Мы хотим избежать паники, но 
явная обработка всех ошибок достаточно громоздка.

В следующем разделе, мы познакомимся с `?` для 
случаев, где нам просто хотим сделать `unwrap` без 
возможности вызова `panic`.

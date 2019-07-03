# Упаковка ошибок (`Box`)

Чтобы написать простой код и при этом использовать 
оригинальные ошибки, необходимо упаковать 
([`Box`](https://doc.rust-lang.org/std/boxed/struct.Box.html)) их.
Минусом данного способа является то, что тип ошибок известен 
только во время выполнения программы, а не [определён 
статически](https://doc.rust-lang.org/book/ch17-02-trait-objects.html#trait-objects-perform-dynamic-dispatch).

Стандартная библиотека помогает упаковывать наши ошибки.
Это достигается за счёт того, что для `Box` 
реализована конвертация из любого типа, реализующего типаж 
`Error`, в типаж-объект `Box<Error>` 
через [`From`](https://doc.rust-lang.org/std/convert/trait.From.html).

```rust,editable
use std::error;
use std::fmt;

// Создадим псевдоним с типом ошибки `Box<error::Error>`.
type Result<T> = std::result::Result<T, Box<error::Error>>;

#[derive(Debug, Clone)]
struct EmptyVec;

impl fmt::Display for EmptyVec {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "неверный первый элемент")
    }
}

impl error::Error for EmptyVec {
    fn description(&self) -> &str {
        "неверный первый элемент"
    }

    fn cause(&self) -> Option<&error::Error> {
        // Общая ошибка, основная причина не отслеживается.
        None
    }
}

fn double_first(vec: Vec<&str>) -> Result<i32> {
    vec.first()
        .ok_or_else(|| EmptyVec.into()) // Упаковка (преобразование в Box)
        .and_then(|s| {
            s.parse::<i32>()
                .map_err(|e| e.into()) // Упаковка (преобразование в Box)
                .map(|i| 2 * i)
        })
}

fn print(result: Result<i32>) {
    match result {
        Ok(n) => println!("Удвоенный первый элемент: {}", n),
        Err(e) => println!("Ошибка: {}", e),
    }
}

fn main() {
    let numbers = vec!["42", "93", "18"];
    let empty = vec![];
    let strings = vec!["tofu", "93", "18"];

    print(double_first(numbers));
    print(double_first(empty));
    print(double_first(strings));
}
```

### Смотрите также:

[Динамическая диспетчеризация](https://doc.rust-lang.org/book/ch17-02-trait-objects.html#trait-objects-perform-dynamic-dispatch) и [типаж `Error`](https://doc.rust-lang.org/std/error/trait.Error.html)

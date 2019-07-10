# Оборачивание ошибок

Альтернативой упаковке ошибок является оборачивание их в ваш собственный тип.

```rust,editable
use std::error;
use std::num::ParseIntError;
use std::fmt;

type Result<T> = std::result::Result<T, DoubleError>;

#[derive(Debug)]
enum DoubleError {
    EmptyVec,
    // Мы не будем обрабатывать ошибку разбора сами, а передадим её в программу.
    // Предоставление дополнительной информации требует добавления дополнительных данных к типу
    Parse(ParseIntError),
}

impl fmt::Display for DoubleError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match *self {
            DoubleError::EmptyVec =>
                write!(f, "пожалуйста используйте вектор хотя бы с одним элементом"),
            // Это адаптер, так что обратимся к нижележащей реализации `fmt`.
            DoubleError::Parse(ref e) => e.fmt(f),
        }
    }
}

impl error::Error for DoubleError {
    fn source(&self) -> Option<&(dyn error::Error + 'static)> {
        match *self {
            DoubleError::EmptyVec => None,
            // Причиной ошибки является адаптированный тип. Здесь происходит
            // неявное преобразование к типажу `&error::Error`. Это работает
            // так как основной тип реализует типаж `Error`.
            DoubleError::Parse(ref e) => Some(e),
        }
    }
}

// Реализуем преобразование из `ParseIntError` в `DoubleError`.
// Это преобразование будет автоматически вызвано оператором `?`, 
// если будет необходимо преобразовать `ParseIntError` в `DoubleError`.
impl From<ParseIntError> for DoubleError {
    fn from(err: ParseIntError) -> DoubleError {
        DoubleError::Parse(err)
    }
}

fn double_first(vec: Vec<&str>) -> Result<i32> {
    let first = vec.first().ok_or(DoubleError::EmptyVec)?;
    let parsed = first.parse::<i32>()?;

    Ok(2 * parsed)
}

fn print(result: Result<i32>) {
    match result {
        Ok(n)  => println!("Первое удвоение {}", n),
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

Это добавляет чуть больше шаблонного кода для обработки ошибок 
и может быть не нужно всем приложениям. Есть библиотеки, 
которые могут избавить вас от написания этого шаблонного кода.

### Смотрите также:

[`From::from`](https://doc.rust-lang.org/std/convert/trait.From.html) и [`Enums`](../../custom_types/enum.md)

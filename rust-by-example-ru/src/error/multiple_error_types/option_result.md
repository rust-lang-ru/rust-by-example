# Извлечение `Result` из `Option`

Наиболее простой способ обработки ошибок разных типов - это встраивание их друг в друга.

```rust,editable
use std::num::ParseIntError;

fn double_first(vec: Vec<&str>) -> Option<Result<i32, ParseIntError>> {
    vec.first().map(|first| {
        first.parse::<i32>().map(|n| 2 * n)
    })
}

fn main() {
    let numbers = vec!["42", "93", "18"];
    let empty = vec![];
    let strings = vec!["tofu", "93", "18"];

    println!("Первое удвоенное: {:?}", double_first(numbers));

    println!("Первое удвоенное: {:?}", double_first(empty));
    // Ошибка первая: исходный вектор пустой

    println!("Первое удвоенное {:?}", double_first(strings));
    // Ошибка вторая: элемент не переводится в число
}
```

Бывает, мы хотим приостановить работу при ошибке (как при 
помощи оператора [`?`](../result/enter_question_mark.md)), но продолжать 
работать, если `Option` `None`. Есть 
пара комбинаторов, которые поменяют местами 
`Result` и `Option`.

```rust,editable
use std::num::ParseIntError;

fn double_first(vec: Vec<&str>) -> Result<Option<i32>, ParseIntError> {
    let opt = vec.first().map(|first| {
        first.parse::<i32>().map(|n| 2 * n)
    });

    let opt = opt.map_or(Ok(None), |r| r.map(Some))?;

    Ok(opt)
}

fn main() {
    let numbers = vec!["42", "93", "18"];
    let empty = vec![];
    let strings = vec!["tofu", "93", "18"];

    println!("Первое удвоенное: {:?}", double_first(numbers));
    println!("Первое удвоенное: {:?}", double_first(empty));
    println!("Первое удвоенное: {:?}", double_first(strings));
}
```

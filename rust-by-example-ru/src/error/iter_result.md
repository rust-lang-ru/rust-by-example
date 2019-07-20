# Итерирование по `Result`

При работе метода `Iter::map` может случиться ошибка, например:

```rust,editable
fn main() {
    let strings = vec!["tofu", "93", "18"];
    let numbers: Vec<_> = strings
        .into_iter()
        .map(|s| s.parse::<i32>())
        .collect();
    println!("Результаты: {:?}", numbers);
}
```

Давайте рассмотрим стратегии обработки этого.

## Игнорирование неудачных элементов с `filter_map()`

`filter_map` вызывает функцию и отфильтровывает результаты, вернувшие `None`.

```rust,editable
fn main() {
    let strings = vec!["tofu", "93", "18"];
    let numbers: Vec<_> = strings
        .into_iter()
        .map(|s| s.parse::<i32>())
        .filter_map(Result::ok)
        .collect();
    println!("Результаты: {:?}", numbers);
}
```

## Сбой всей операции с `collect()`

`Result` реализует `FromIter` так что вектор из результатов (`Vec<Result<T, E>>`)
может быть преобразован в результат с вектором (`Result<Vec<T>, E>`). Если будет найдена хотя бы одна `Result::Err`, итерирование завершится.

```rust,editable
fn main() {
    let strings = vec!["tofu", "93", "18"];
    let numbers: Result<Vec<_>, _> = strings
        .into_iter()
        .map(|s| s.parse::<i32>())
        .collect();
    println!("Результаты: {:?}", numbers);
}
```

Та же самая техника может использоваться с `Option`.

## Сбор всех корректных значений и ошибок с помощью `partition()`

```rust,editable
fn main() {
    let strings = vec!["tofu", "93", "18"];
    let (numbers, errors): (Vec<_>, Vec<_>) = strings
        .into_iter()
        .map(|s| s.parse::<i32>())
        .partition(Result::is_ok);
    println!("Числа: {:?}", numbers);
    println!("Ошибки: {:?}", errors);
}
```

Если вы посмотрите на результаты работы, вы заметите, что они всё ещё обёрнуты в `Result`. Потребуется немного больше шаблонного кода, чтобы получить нужный результат.

```rust,editable
fn main() {
    let strings = vec!["tofu", "93", "18"];
    let (numbers, errors): (Vec<_>, Vec<_>) = strings
        .into_iter()
        .map(|s| s.parse::<i32>())
        .partition(Result::is_ok);
    let numbers: Vec<_> = numbers.into_iter().map(Result::unwrap).collect();
    let errors: Vec<_> = errors.into_iter().map(Result::unwrap_err).collect();
    println!("Числа: {:?}", numbers);
    println!("Ошибки: {:?}", errors);
}
```

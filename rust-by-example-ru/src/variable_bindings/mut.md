# Изменяемость

По умолчанию связывание переменных является неизменяемым,
но с помощью модификатора `mut` можно разрешить изменения.

```rust,editable,ignore,mdbook-runnable
fn main() {
    let _immutable_binding = 1;
    let mut mutable_binding = 1;

    println!("Перед изменением: {}", mutable_binding);

    // Ok
    mutable_binding += 1;

    println!("После изменения: {}", mutable_binding);

    // Ошибка!
    _immutable_binding += 1;
    // ИСПРАВЬТЕ ^ Закомментируйте эту строку
}
```

Компилятор будет выводить подробные сообщения об ошибках, связанных с изменяемостью.

# Предварительное объявление

Можно сначала объявить связь с переменной, а инициализировать её позже. Однако такая форма используется редко, так как может привести к использованию неинициализированных переменных.

```rust,editable,ignore,mdbook-runnable
fn main() {
    // Объявляем связь с переменной
    let a_binding;

    {
        let x = 2;

        // Инициализируем связь
        a_binding = x * x;
    }

    println!("связь а: {}", a_binding);

    let another_binding;

    // Ошибка! Использование неинициализированной связи с переменной
    println!("другая связь: {}", another_binding);
    // ИСПРАВЬТЕ ^ Закомментируйте строку

    another_binding = 1;

    println!("другая связь: {}", another_binding);
}
```

Компилятор запрещает использование неинициализированных переменных, так как это привело бы к неопределённому поведению.

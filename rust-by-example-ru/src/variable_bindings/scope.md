# Область видимости и затенение

Связывание переменных происходит в локальной области видимости — они ограничены существованием внутри *блока*. Блок — это набор инструкций, заключённый между фигурными скобками `{}`.

```rust,editable,ignore,mdbook-runnable
fn main() {
    // Эта переменная живёт в функции main
    let long_lived_binding = 1;

    // Это блок, он имеет меньшую область видимости, чем функция main
    {
        // Эта переменная существует только в этом блоке
        let short_lived_binding = 2;

        println!("inner short: {}", short_lived_binding);
    }
    // Конец блока

    // Ошибка! `short_lived_binding` нет в этой области видимости
    println!("outer short: {}", short_lived_binding);
    // ИСПРАВЬТЕ ^ Закомментируйте строку

    println!("outer long: {}", long_lived_binding);
}
```

Кроме того, допускается [затенение переменных].

```rust,editable,ignore,mdbook-runnable
fn main() {
    let shadowed_binding = 1;

    {
        println!("До затенения: {}", shadowed_binding);

        // Эта переменная *затеняет* внешнюю
        let shadowed_binding = "abc";

        println!("затенённая во внутреннем блоке: {}", shadowed_binding);
    }
    println!("во внешнем блоке: {}", shadowed_binding);

    // Эта привязка *затеняет* предыдущую
    let shadowed_binding = 2;
    println!("затенённая во внешнем блоке: {}", shadowed_binding);
}
```


[затенение переменных]: https://en.wikipedia.org/wiki/Variable_shadowing
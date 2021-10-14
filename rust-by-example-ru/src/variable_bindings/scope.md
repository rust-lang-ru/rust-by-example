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

        // Эта переменная *затеняет* собой внешнюю
        let long_lived_binding = 5_f32;

        println!("inner long: {}", long_lived_binding);
    }
    // Конец блока

    // Ошибка! `short_lived_binding` нет в этой области видимости
    println!("outer short: {}", short_lived_binding);
    // ИСПРАВЬТЕ ^ Закомментируйте строку

    println!("outer long: {}", long_lived_binding);

    // Это связывание так же *скрывает* собой предыдущие
    let long_lived_binding = 'a';

    println!("outer long: {}", long_lived_binding);
}
```

Кроме того, допускается [затенение переменных](https://en.wikipedia.org/wiki/Variable_shadowing).

```rust,editable,ignore,mdbook-runnable
fn main() {
    let shadowed_binding = 1;

    {
        println!("before being shadowed: {}", shadowed_binding);

        // This binding *shadows* the outer one
        let shadowed_binding = "abc";

        println!("shadowed in inner block: {}", shadowed_binding);
    }
    println!("outside inner block: {}", shadowed_binding);

    // This binding *shadows* the previous binding
    let shadowed_binding = 2;
    println!("shadowed in outer block: {}", shadowed_binding);
}
```

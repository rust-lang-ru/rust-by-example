# `cfg`

Условная конфигурация возможна при помощи двух разных операторов:

- атрибута `cfg`: `#[cfg(...)]`, который указывается на месте атрибута
- макроса `cfg!`: `cfg!(...)`, который можно использовать в условных выражениях

В то время как первый атрибут включает условную компиляцию, второй преобразуется в литералы `true` или `false`, позволяя сделать проверку во время исполнения. Оба варианта используют идентичный синтаксис для аргументов.

```rust,editable
// Эта функция будет скомпилирована только в том случае, если целевая ОС будет linux
#[cfg(target_os = "linux")]
fn are_you_on_linux() {
    println!("Вы работаете в linux!");
}

// А эта функция будет скомпилирована, если целевая ОС *не* linux
#[cfg(not(target_os = "linux"))]
fn are_you_on_linux() {
    println!("Вы работаете *не* в linux!");
}

fn main() {
    are_you_on_linux();
    
    println!("Вы уверены?");
    if cfg!(target_os = "linux") {
        println!("Да. Это точно linux!");
    } else {
        println!("Да. Это точно *не* linux!");
    }
}
```

### Смотрите также:

[Reference], [`cfg!`][cfg], и [macros][macros].

[cfg]: https://doc.rust-lang.org/std/macro.cfg!.html
[macros]: ../macros.md
[Reference]: https://doc.rust-lang.org/reference/attributes.html#conditional-compilation

# Замораживание

Когда данные заимствуются, они заодно и *замораживаются*. *Замороженные* данные
не могут быть изменены до тех пор, пока все ссылки не выйдут за область видимости:

```rust,editable,ignore,mdbook-runnable
fn main() {
    let mut _mutable_integer = 7i32;

    {
        // Заимствуем `_mutable_integer`
        let large_integer = &_mutable_integer;

        // Ошибка! `_mutable_integer` заморожена в этой области видимости
        _mutable_integer = 50;
        // ИСПРАВЬТЕ ^ Закомментируйте эту строку

        println!("Неизменяемое заимствование числа {}", large_integer);

        // `large_integer` выходит из области видимости
    }

    // Ок! `_mutable_integer` не заморожена в этой области видимости
    _mutable_integer = 3;
}
```

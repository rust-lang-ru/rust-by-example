# Заморозка

Когда данные неизменяемо привязаны к тому же имени, они *замораживаются*. *Замороженные* данные не могут быть изменены до тех пор, пока неизменяемая привязка не выйдет из области видимости:

```rust,editable,ignore,mdbook-runnable
fn main() {
    let mut _mutable_integer = 7i32;

    {
        // Неизменяемое затенение `_mutable_integer`
        let _mutable_integer = _mutable_integer;

        // Ошибка! `_mutable_integer` заморожена в этой области
        _mutable_integer = 50;
        // ИСПРАВЬТЕ ^ Закомментируйте эту строку

        // `_mutable_integer` выходит из области видимости
    }

    // Ok! `_mutable_integer` не заморожена в этой области
    _mutable_integer = 3;
}
```

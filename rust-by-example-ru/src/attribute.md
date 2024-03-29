# Атрибуты

Атрибуты - это метаданные, применяемые к какому-либо модулю, контейнеру или их элементу. Благодаря атрибутам можно:

<!-- TODO: Link these to their respective examples -->

- выполнить [условную компиляцию кода]
- [задать имя крейта, его версию и тип (бинарный или библиотечный)]
- отключить [lints] (предупреждения)
- включить возможности компилятора (макросы, глобальный импорт и другое.)
- связаться с внешней библиотекой
- пометить функции как юнит тесты
- пометить функции, которые будут частью бенчмарка
- использовать [макросы, похожие на атрибуты]

Когда атрибуты применяются ко всему контейнеру, их синтаксис будет `#![crate_attribute]`, а когда они применяются к модулю или элементу модуля, их синтаксис станет `#[item_attribute]` (обратите внимание на отсутствие `!`).

Атрибуты могут принимать аргументы с различным синтаксисом:

- `#[attribute = "value"]`
- `#[attribute(key = "value")]`
- `#[attribute(value)]`

Атрибуты могут иметь несколько значений и могут быть разделены несколькими строками:

```rust,ignore
#[attribute(value, value2)]


#[attribute(value, value2, value3,
            value4, value5)]
```


[условную компиляцию кода]: attribute/cfg.md
[задать имя крейта, его версию и тип (бинарный или библиотечный)]: attribute/crate.md
[lints]: https://en.wikipedia.org/wiki/Lint_%28software%29
[макросы, похожие на атрибуты]: https://doc.rust-lang.org/book/ch19-06-macros.html#attribute-like-macros
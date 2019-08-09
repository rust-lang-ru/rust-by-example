# Тестирование документации

Основной способ документирования проекта на Rust - это 
аннотирование исходного кода. Документационные комментарии 
пишутся с использованием [markdown](https://daringfireball.net/projects/markdown/) и позволяют 
использовать внутри блоки кода. Rust заботится о корректности, так 
что эти блоки кода могут компилироваться и использоваться в 
качестве тестов.

```rust,ignore
/// Первая строка - это краткое описание функции.
///
/// Следующие строки представляют детальную документацию. Блоки кода /// начинаются трёх обратных кавычек и внутри содержат неявные
/// `fn main()` и `extern crate <cratename>`. Предположим, мы
/// тестируем крейт `doccomments`:
///
/// ```
/// let result = doccomments::add(2, 3);
/// assert_eq!(result, 5);
/// ```
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

/// Ообычно документационные комментарии могут содержат секции "Examples", "Panics" and "Failures".
///
/// Следующая функция делит два числа.
///
/// # Examples
///
/// ```
/// let result = doccomments::div(10, 2);
/// assert_eq!(result, 5);
/// ```
///
/// # Panics
///
/// Функция паникует, если второй аргумент равен нулю.
///
/// ```rust,should_panic
/// // паникует при делении на 0
/// doccomments::div(10, 0);
/// ```
pub fn div(a: i32, b: i32) -> i32 {
    if b == 0 {
        panic!("Ошибка деления на 0");
    }

    a / b
}
```

Тесты могут быть запущены при помощи `cargo test`:

```shell
$ cargo test
running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests doccomments

running 3 tests
test src/lib.rs - add (line 7) ... ok
test src/lib.rs - div (line 21) ... ok
test src/lib.rs - div (line 31) ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Мотивация для документационных тестов

Главная цель документационных тестов - служить примерами 
предоставляемой функциональности, что является одной из самых 
важных [рекомендаций](https://rust-lang-nursery.github.io/api-guidelines/documentation.html#examples-use--not-try-not-unwrap-c-question-mark). Это позволяет использовать 
примеры из документации в качестве полных фрагментов кода. Но 
использование `?` приведёт к ошибке компиляции, так 
как функция `main` возвращает `()` 
(`unit`). На помощь приходит возможность скрыть из документации 
некоторые строки исходного кода: можно написать 
`fn try_main() -> Result<(), ErrorType>`, скрыть 
её и вызвать её в скрытом `main` с 
`unwrap`. Звучит сложно? Вот пример:

```rust,ignore
/// Использование скрытой `try_main` в документационных тестах.
///
/// ```
/// # // скрытые строки начинаются с символа `#`, но они всё ещё компилируемы!
/// # fn try_main() -> Result<(), String> { // эта линия оборачивает тело функции, которое отображается в документации
/// let res = try::try_div(10, 2)?;
/// # Ok(()) // возвращается из try_main
/// # }
/// # fn main() { // начало `main` которая выполняет `unwrap()`
/// #    try_main().unwrap(); // вызов `try_main` и извлечение результата
/// #                         // так что в случае ошибки этот тест запаникует
/// # }
pub fn try_div(a: i32, b: i32) -> Result<i32, String> {
    if b == 0 {
        Err(String::from("Деление на 0"))
    } else {
        Ok(a / b)
    }
}
```

## Смотрите также:

- [RFC505](https://github.com/rust-lang/rfcs/blob/master/text/0505-api-comment-conventions.md) по стилю документации
- [Рекомендации для API](https://rust-lang-nursery.github.io/api-guidelines/documentation.html) по документационному тестированию

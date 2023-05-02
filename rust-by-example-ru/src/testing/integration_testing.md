# Интеграционное тестирование

[Модульные тесты] тестируют по одному модулю изолированно: они малы и могут проверить не публичный код. Интеграционные тесты являются внешними для вашего пакета и используют только его открытый интерфейс, таким же образом, как и любой другой код. Их цель в том, чтобы проверить, что многие части вашей библиотеки работают корректно вместе.

Cargo ищет интеграционные тесты в каталоге `tests` после каталога `src`.

Файл `src/lib.rs`:

```rust,ignore
// Задаём это в кресте с именем `adder`.
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

Файл с тестом: `tests/integration_test.rs`:

```rust,ignore
#[test]
fn test_add() {
    assert_eq!(adder::add(3, 2), 5);
}
```

Запустим тесты можно командой `cargo test`:

```shell
$ cargo test
running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

     Running target/debug/deps/integration_test-bcd60824f5fbfe19

running 1 test
test test_add ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests adder

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

Каждый файл с исходным кодом Rust в директории `tests` компилируется в отдельный крейт. <br>Чтобы можно было воспользоваться некоторым общим кодом в нескольких интеграционных тестах, можно создать модуль с публичными функциями, импортировать их, и использовать в тестах.

Файл `tests/common/mod.rs`:

```rust,ignore
pub fn setup() {
    // некоторый код для настройки, создание необходимых файлов/каталогов, запуск серверов.
}
```

Файл с тестом: `tests/integration_test.rs`

```rust,ignore
// импортируем модуль с общим кодом.
mod common;

#[test]
fn test_add() {
    // используем общий код.
    common::setup();
    assert_eq!(adder::add(3, 2), 5);
}
```

Создание модуля как `tests/common.rs` также работает, но не рекомендуется, потому что средство запуска тестов будет рассматривать файл как тестовый крейт и пытаться запускать тесты внутри него.


[Модульные тесты]: unit_testing.md
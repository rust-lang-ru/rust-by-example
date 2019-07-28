# Интеграционное тестирование

[Модульные тесты](unit_testing.md) тестируют по одному модулю изолированно: они малы
и могут проверить не публичный код. Интеграционные тесты являются внешними для вашего пакета и используют
только его открытый интерфейс, таким же образом, как и любой другой код. Их цель в том, чтобы проверить, что многие части вашей библиотеки работают корректно вместе.

Cargo ищет интеграционные тесты в каталоге `tests` после каталога `src`.

Файл `src/lib.rs`:

```rust,ignore
// Предположим, что наш пакет называется `adder`, для теста он будет внешним кодом.
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

Файл с тестом: `tests/integration_test.rs`:

```rust,ignore
// мы тестируем extern crate, как и любой другой код.
extern crate adder;

#[test]
fn test_add() {
    assert_eq!(adder::add(3, 2), 5);
}
```

Запустить тесты можно командой `cargo test`:

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

Каждый файл с исходным кодом в директории `tests` компилируется в отдельный пакет. 
Один из путей использовать некоторый общий код между интеграционными тестами - создать модуль с публичными функциями и импортировать их в тестах.

Файл `tests/common.rs`:

```rust,ignore
pub fn setup() {
    // некоторый код для настройки, создание необходимых файлов/каталогов, запуск серверов.
}
```

Файл с тестом: `tests/integration_test.rs`

```rust,ignore
// мы тестируем extern crate, как и любой другой код.
extern crate adder;

// импорт общего модуля.
mod common;

#[test]
fn test_add() {
    // использование общего кода.
    common::setup();
    assert_eq!(adder::add(3, 2), 5);
}
```

Модули с общим кодом следуют обычным правилам  [модулей](../mod.md). Общий модуль можно создать как `tests/common/mod.rs`.

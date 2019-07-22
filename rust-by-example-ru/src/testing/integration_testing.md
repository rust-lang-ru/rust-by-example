# Интеграционное тестирование

[Модульные тесты](unit_testing.md) тестируют по одному модулю изолированно: они малы
и могут проверить не публичный код. Интеграционные тесты являются внешними для вашего пакета и используют
только его открытый интерфейс, таким же образом, как и любой другой код. Их цель в том, чтобы проверить, что многие части вашей библиотеки работают корректно вместе.

Cargo looks for integration tests in `tests` directory next to `src`.

File `src/lib.rs`:

```rust,ignore
// Предположим, что наш пакет называется `adder`, для теста он будет внешним кодом.
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}
```

File with test: `tests/integration_test.rs`:

```rust,ignore
// extern crate we're testing, same as any other code would do.
extern crate adder;

#[test]
fn test_add() {
    assert_eq!(adder::add(3, 2), 5);
}
```

Running tests with `cargo test` command:

```bash
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

File `tests/common.rs`:

```rust,ignore
pub fn setup() {
    // some setup code, like creating required files/directories, starting
    // servers, etc.
}
```

File with test: `tests/integration_test.rs`

```rust,ignore
// extern crate we're testing, same as any other code will do.
extern crate adder;

// importing common module.
mod common;

#[test]
fn test_add() {
    // using common code.
    common::setup();
    assert_eq!(adder::add(3, 2), 5);
}
```

Modules with common code follow the ordinary [modules](../mod.md) rules, so it's ok to
create common module as `tests/common/mod.rs`.

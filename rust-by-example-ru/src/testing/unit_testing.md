# Unit-тестирование

Тесты - это функции на Rust, которые проверяют, что тестируемый 
код работает ожидаемым образом. Тело тестовых функций обычно 
выполняет некоторую настройку, запускает код, который мы 
тестируем, и затем сравнивает полученный результат с тем, что мы 
ожидаем.

Большинство модульных тестов располагается в [модуле](../mod.md) 
`tests`, помеченном [атрибутом](../attribute.md) 
`#[cfg(test)]`. Тестовые функции помечаются 
атрибутом `#[test]`.

Тесты заканчиваются неудачей, когда что-либо в тестовой функции 
вызывает [панику](../std/panic.md). Есть несколько вспомогательных 
[макросов](../macros.md):

- `assert!(expression)` - паникует, если результат выражения равен `false`.
- `assert_eq!(left, right)` и `assert_ne!(left, right)` - сравнивает левое и правое выражения на равенство и неравенство соответственно.

```rust,ignore
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

// Это действительно плохая функция сложения, её назначение в данном // примере - потерпеть неудачу.
#[allow(dead_code)]
fn bad_add(a: i32, b: i32) -> i32 {
    a - b
}

#[cfg(test)]
mod tests {
    // Обратите внимание на эту полезную идиому: импортирование имён из внешней (для mod - тестов) области видимости.
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1, 2), 3);
    }

    #[test]
    fn test_bad_add() {
        // Это утверждение запустится и проверка не сработает.
        // Заметьте, что приватные функции также могут быть протестированы!
        assert_eq!(bad_add(1, 2), 3);
    }
}
```

Тесты могут быть запущены при помощи команды `cargo test`.

```shell
$ cargo test

running 2 tests
test tests::test_bad_add ... FAILED
test tests::test_add ... ok

failures:

---- tests::test_bad_add stdout ----
        thread 'tests::test_bad_add' panicked at 'assertion failed: `(left == right)`
  left: `-1`,
 right: `3`', src/lib.rs:21:8
note: Run with `RUST_BACKTRACE=1` for a backtrace.


failures:
    tests::test_bad_add

test result: FAILED. 1 passed; 1 failed; 0 ignored; 0 measured; 0 filtered out
```

## Тестирование паники

Для тестирования функций, которые должны паниковать при 
определённых обстоятельствах, используется атрибут 
`#[should_panic]`. Этот атрибут принимает 
необязательный параметр `expected =` с текстом 
сообщения о панике. Если ваша функция может паниковать в 
разных случаях, то этот параметр поможет вам быть уверенным, 
что вы тестируете именно ту панику, которую собирались.

```rust,ignore
pub fn divide_non_zero_result(a: u32, b: u32) -> u32 {
    if b == 0 {
        panic!("Divide-by-zero error");
    } else if a < b {
        panic!("Divide result is zero");
    }
    a / b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_divide() {
        assert_eq!(divide_non_zero_result(10, 2), 5);
    }

    #[test]
    #[should_panic]
    fn test_any_panic() {
        divide_non_zero_result(1, 0);
    }

    #[test]
    #[should_panic(expected = "Divide result is zero")]
    fn test_specific_panic() {
        divide_non_zero_result(1, 10);
    }
}
```

Запуск этих тестов даст следующее:

```shell
$ cargo test

running 3 tests
test tests::test_any_panic ... ok
test tests::test_divide ... ok
test tests::test_specific_panic ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests tmp-test-should-panic

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Запуск конкретных тестов

Для запуска конкретного теста надо добавить имя теста в команду 
`cargo test`.

```shell
$ cargo test test_any_panic
running 1 test
test tests::test_any_panic ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 2 filtered out

   Doc-tests tmp-test-should-panic

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

Для запуска нескольких тестов, можно указать часть имени, 
которая есть во всех необходимых тестах.

```shell
$ cargo test panic
running 2 tests
test tests::test_any_panic ... ok
test tests::test_specific_panic ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 1 filtered out

   Doc-tests tmp-test-should-panic

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

## Игнорирование тестов

Тесты могут быть помечены атрибутом `#[ignore]`, чтобы они были исключены из списка запускаемых командой `cargo test`. Такие тесты можно запустить с помощью команды `cargo test -- --ignored`.

```rust
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 2), 4);
    }

    #[test]
    fn test_add_hundred() {
        assert_eq!(add(100, 2), 102);
        assert_eq!(add(2, 100), 102);
    }

    #[test]
    #[ignore]
    fn ignored_test() {
        assert_eq!(add(0, 0), 0);
    }
}
```

```shell
$ cargo test
running 3 tests
test tests::ignored_test ... ignored
test tests::test_add ... ok
test tests::test_add_hundred ... ok

test result: ok. 2 passed; 0 failed; 1 ignored; 0 measured; 0 filtered out

   Doc-tests tmp-ignore

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

$ cargo test -- --ignored
running 1 test
test tests::ignored_test ... ok

test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out

   Doc-tests tmp-ignore

running 0 tests

test result: ok. 0 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

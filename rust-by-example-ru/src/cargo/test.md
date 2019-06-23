# Тестирование

Как мы знаем, тестирование является неотъемлемой частью любого программного обеспечения! Rust имеет первокласную поддержку модульного и интеграционного тестирования (см.
[главу TRPL](https://doc.rust-lang.org/book/ch11-00-testing.html)).

Из разделов тестирования, приведенных выше, мы видим, как писать модульные и интеграционные тесты. Организационно, мы можем расположить модульные тесты в модулях, которые они тестируют, а интеграционные - в собственном каталоге `tests/`:

```txt
foo
├── Cargo.toml
├── src
│   └── main.rs
└── tests
    ├── my_test.rs
    └── my_other_test.rs
```

Каждый файл в каталоге `tests` - это отдельный интеграционный тест.

`cargo`  естественно, обеспечивает простой способ запуска всех ваших тестов!

```sh
cargo test
```

Вы должны увидеть примерно такой результат:

```txt
$ cargo test
   Compiling blah v0.1.0 (file:///nobackup/blah)
    Finished dev [unoptimized + debuginfo] target(s) in 0.89 secs
     Running target/debug/deps/blah-d3b32b97275ec472

running 3 tests
test test_bar ... ok
test test_baz ... ok
test test_foo_bar ... ok
test test_foo ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

You can also run tests whose name matches a pattern:

```sh
cargo test test_foo
```

```txt
$ cargo test test_foo
   Compiling blah v0.1.0 (file:///nobackup/blah)
    Finished dev [unoptimized + debuginfo] target(s) in 0.35 secs
     Running target/debug/deps/blah-d3b32b97275ec472

running 2 tests
test test_foo ... ok
test test_foo_bar ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 2 filtered out
```

One word of caution: Cargo may run multiple tests concurrently, so make sure
that they don't race with each other. For example, if they all output to a
file, you should make them write to different files.

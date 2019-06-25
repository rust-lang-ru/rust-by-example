# Контейнеры

Атрибут `crate_type` используется, чтобы сказать компилятору,
какой контейнер является библиотекой (и каким типом библиотеки),
а какой исполняемым файлом. Атрибут `crate_name` используется для указания имени контейнера.

Однако важно отметить, что атрибуты `crate_type` и `create_name` **не имеют значения** при использовании пакетного менеджера Cargo.
В виду того, что Cargo используется для большинства проектов на Rust,
это значит в реальном мире использование `crate_type` и `crate_name`
достаточно ограничено.

```rust,editable
// Этот контейнер - библиотека
#![crate_type = "lib"]
// Эта библиотека называется "rary"
#![crate_name = "rary"]

pub fn public_function() {
    println!("вызвана `public_function()` библиотеки `rary`");
}

fn private_function() {
    println!("вызвана `private_function()` библиотеки `rary`");
}

pub fn indirect_access() {
    print!("вызвана `indirect_access()` библиотеки `rary`, и в ней\n> ");

    private_function();
}
```

Если мы используем атрибут `crate_type`,
то нам больше нет необходимости передавать флаг `--crate-type` компилятору.

```bash
$ rustc lib.rs
$ ls lib*
library.rlib
```

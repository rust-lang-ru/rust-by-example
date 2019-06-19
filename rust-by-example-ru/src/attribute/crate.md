# Контейнеры

Атрибут `crate_type` используется, чтобы сказать компилятору,
какой контейнер является библиотекой (и каким типом библиотеки),
а какой исполняемым файлом. Атрибут `crate_name` используется для указания имя контейнера.

Однако важно отметить, что `crate_type` и `create_name`
атрибуты не имеют значения при использовании пакетного менеджера `Cargo`.
В виду того что `Cargo` используется для большинства проектов на Rust,
это значит в реальном мире использование `crate_type` и `crate_name`
достаточно ограничено.

```rust,editable
// Этот контейнер - библиотека
#![crate_type = "lib"]
// Эта библиотека называется "rary"
#![crate_name = "rary"]

pub fn public_function() {
    println!("вызвана rary's `public_function()`");
}

fn private_function() {
    println!("вызвана rary's `private_function()`");
}

pub fn indirect_access() {
    print!("вызвана rary's `indirect_access()`, которая\n> ");

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

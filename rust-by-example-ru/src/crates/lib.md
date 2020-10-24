# Создание проекта

Давайте создадим библиотеку и посмотрим, как связать её с другим контейнером.

```rust,ignore
pub fn public_function() {
    println!("called rary's `public_function()`");
}

fn private_function() {
    println!("called rary's `private_function()`");
}

pub fn indirect_access() {
    print!("called rary's `indirect_access()`, that\n> ");

    private_function();
}
```

```shell
$ rustc --crate-type=lib rary.rs
$ ls lib*
library.rlib
```

Библиотеки получают префикс «lib», и по умолчанию они получают имена в честь своего крейта, но это имя по умолчанию можно переопределить, передав параметр `--crate-name` в `rustc` или используя [атрибут `crate_name`].


[атрибут `crate_name`]: ../attribute/crate.md
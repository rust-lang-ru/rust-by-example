# Библиотеки

Давайте создадим библиотеку и посмотрим, как связать её с другим контейнером.

```rust,editable
pub fn public_function() {
    println!("вызвана `public_function()` контейнера rary");
}

fn private_function() {
    println!("вызвана `private_function()` контейнера rary");
}

pub fn indirect_access() {
    print!("вызвана `indirect_access()` контейнера rary, которая\n> ");

    private_function();
}
```

```bash
$ rustc --crate-type=lib rary.rs
$ ls lib*
library.rlib
```

Библиотеки получают префикс «lib», и по умолчанию имеют то же имя,
что и их контейнеры, но это имя можно изменить
с помощью [атрибута `crate_name`][crate-name].

[crate-name]: attribute/crate.html
# Иерархия файлов

Модули могут быть отображены на иерархию файлов и директорий.
Давайте разобьём [пример с видимостью модулей][visibility] на файлы:

```bash
$ tree .
.
|-- my
|   |-- inaccessible.rs
|   |-- mod.rs
|   `-- nested.rs
`-- split.rs
```

В `split.rs`:

```rust,ignore
// Эта декларация найдёт файл с именем `my.rs` или `my/mod.rs` и вставит
// его содержимое внутрь модуля с именем `my` в этой области видимости
mod my;

fn function() {
    println!("вызвана `function()`");
}

fn main() {
    my::function();

    function();

    my::indirect_access();

    my::nested::function();
}

```

В `my/mod.rs`:

```rust,ignore
// Точно так же, `mod inaccessible` и `mod nested` обнаружат файлы `nested.rs`
// и `inaccessible.rs`, и затем вставят их здесь в соответствующие модули

mod inaccessible;
pub mod nested;

pub fn function() {
    println!("вызвана `my::function()`");
}

fn private_function() {
    println!("вызывает `my::private_function()`");
}

pub fn indirect_access() {
    print!("вызвана `my::indirect_access()`, которая\n> ");

    private_function();
}
```

В `my/nested.rs`:

```rust,ignore
pub fn function() {
    println!("вызвана `my::nested::function()`");
}

#[allow(dead_code)]
fn private_function() {
    println!("вызвана `my::nested::private_function()`");
}
```

В `my/inaccessible.rs`:

```rust,ignore
#[allow(dead_code)]
pub fn public_function() {
    println!("вызвана `my::inaccessible::public_function()`");
}
```

Давайте проверим, что все ещё работает, как раньше:

```bash
$ rustc split.rs && ./split
вызвана `my::function()`
вызвана `function()`
вызвана `my::indirect_access()`, которая
> вызвана `my::private_function()`
вызвана `my::nested::function()`
```

[visibility]: mod/visibility.html

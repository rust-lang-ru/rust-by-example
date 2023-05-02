# Иерархия файлов

Модули могут быть отображены на иерархию файлов и директорий. Давайте разобьём [пример с видимостью модулей](mod/visibility.html) на файлы:

```shell
$ tree .
.
├── my
│   ├── inaccessible.rs
│   └── nested.rs
├── my.rs
└── split.rs
```

В `split.rs`:

```rust,ignore
// Это объявление запустит поиск файла с именем `my.rs` и
// вставит его содержимое в модуль с именем `my` под текущей областью видимости
mod my;

fn function() {
    println!("вызвали `function()`");
}

fn main() {
    my::function();

    function();

    my::indirect_access();

    my::nested::function();
}

```

В `my.rs` :

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

```shell
$ rustc split.rs && ./split
вызвана `my::function()`
вызвана `function()`
вызвана `my::indirect_access()`, которая
> вызвана `my::private_function()`
вызвана `my::nested::function()`
```



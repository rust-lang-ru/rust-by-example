# Собственные условия

Некоторые условия, например, `target_os` предоставляются компилятором.
Если мы хотим создать собственные условия, 
то их необходимо передать компилятору используя флаг `--cfg`.

```rust,editable,ignore,mdbook-runnable
#[cfg(some_condition)]
fn conditional_function() {
    println!("condition met!");
}

fn main() {
    conditional_function();
}
```

Попробуйте запустить без указания флага `cfg`.

С указанием флага `cfg`:

```bash
$ rustc --cfg some_condition custom.rs && ./custom
condition met!
```

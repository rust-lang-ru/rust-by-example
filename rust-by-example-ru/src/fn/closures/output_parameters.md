# Как выходные параметры

Замыкания могут выступать как в качестве входных параметров, так и в качестве выходных. Однако тип анонимных замыканий по определению не известен, из-за чего для их возврата нам придётся использовать `impl Trait`.

Для возврата замыкания мы можем использовать такие трейты:

- `Fn`
- `FnMut`
- `FnOnce`

Помимо этого, должно быть использовано ключевое слово `move`, чтобы сигнализировать о том, что все переменные захватываются по значению. Это необходимо, так как любые захваченные по ссылке значения будут удалены после выхода из функции, оставляя недопустимые ссылки в замыкании.

```rust,editable
fn create_fn() -> impl Fn() {
    let text = "Fn".to_owned();

    move || println!("a: {}", text)
}

fn create_fnmut() -> impl FnMut() {
    let text = "FnMut".to_owned();

    move || println!("a: {}", text)
}

fn create_fnonce() -> impl FnOnce() {
    let text = "FnOnce".to_owned();

    move || println!("a: {}", text)
}

fn main() {
    let fn_plain = create_fn();
    let mut fn_mut = create_fnmut();
    let fn_once = create_fnonce();

    fn_plain();
    fn_mut();
    fn_once();
}
```

### Смотрите также:

[`Fn`](https://doc.rust-lang.org/std/ops/trait.Fn.html), [`FnMut`](https://doc.rust-lang.org/std/ops/trait.FnMut.html), [обобщения](../../generics.md) и [impl Trait](../../traits/impl_trait.md).

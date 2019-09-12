# Как выходные параметры

Замыкания могут выступать как в качестве входных параметров, 
так и в качестве выходных. Однако тип анонимных замыканий по 
определению не известен, из-за чего для их возврата мы будем 
использовать `impl Trait`.

Возможные типажи для возвращаемых значений немного отличаются от прежних:

- `Fn`: как раньше
- `FnMut`: как раньше
- `FnOnce`: здесь присутствуют некоторые неожиданности, поэтому необходим тип[`FnBox`](https://doc.rust-lang.org/std/boxed/trait.FnBox.html), но он нестабиленв настоящее время. В будущем ожидаются изменения этой ситуации.

Помимо этого, должно быть использовано ключевое слово `move`, чтобы
сигнализировать о том, что все переменные захватываются по значению. Это
необходимо, так как любые захваченные по ссылке значения будут удалены после
выхода из функции, оставляя недопустимые ссылки в замыкании.

```rust,editable
fn create_fn() -> impl Fn() {
    let text = "Fn".to_owned();

    move || println!("a - {}", text)
}

fn create_fnmut() -> impl FnMut() {
    let text = "FnMut".to_owned();

    move || println!("a - {}", text)
}

fn main() {
    let fn_plain = create_fn();
    let mut fn_mut = create_fnmut();

    fn_plain();
    fn_mut();
}
```

### Смотрите также:

[`Fn`](https://doc.rust-lang.org/std/ops/trait.Fn.html), [`FnMut`](https://doc.rust-lang.org/std/ops/trait.FnMut.html), [обобщения](../../generics.md) и [impl Trait](../../traits/impl_trait.md).

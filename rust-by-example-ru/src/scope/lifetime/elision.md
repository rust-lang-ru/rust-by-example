# Сокрытие

Некоторые шаблоны времён жизни достаточно общие и поэтому 
анализатор заимствований может позволить вам опустить их чтобы 
ускорить написание кода и увеличить его читаемость.
Это известно как сокрытие времён жизни. Сокрытие появилось в Rust, 
исключительно из-за того, что они применяются к общим шаблонам.

Следующий код показывает несколько примеров сокрытия. Для более полного описания сокрытия, обратитесь к главе про [a0}сокрытие времён жизни в TRPL.

```rust,editable
// По существу, `elided_input` и `annotated_input` имеют одинаковую сигнатуру
// потому что время жизни `elided_input` выводится компилятором:
fn elided_input(x: &i32) {
    println!("`elided_input`: {}", x);
}

fn annotated_input<'a>(x: &'a i32) {
    println!("`annotated_input`: {}", x);
}

// Аналогично, `elided_pass` и `annotated_pass` имеют идентичные сигнатуры
// потому что время жизни неявно добавлено к `elided_pass`:
fn elided_pass(x: &i32) -> &i32 { x }

fn annotated_pass<'a>(x: &'a i32) -> &'a i32 { x }

fn main() {
    let x = 3;

    elided_input(&x);
    annotated_input(&x);

    println!("`elided_pass`: {}", elided_pass(&x));
    println!("`annotated_pass`: {}", annotated_pass(&x));
}
```

### Смотрите также:

[сокрытие](https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html#lifetime-elision)

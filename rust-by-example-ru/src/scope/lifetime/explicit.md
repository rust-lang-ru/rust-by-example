# Явное аннотирование

The borrow checker uses explicit lifetime annotations to determine
how long references should be valid. In cases where lifetimes are not
elided[^1], Rust requires explicit annotations to determine what the
lifetime of a reference should be. The syntax for explicitly annotating
a lifetime uses an apostrophe character as follows:

```rust,ignore
foo<'a>
// `foo` имеет параметр времени жизни `'a`
```

Подобно [замыканиям](../../fn/closures/anonymity.md), явное использование времён жизни 
требует обобщённого параметра. Кроме того, такой синтаксис 
показывает, что время жизни `foo` не может 
превышать `'a`. Явная аннотация для типа имеет 
форму `&'a T`, где `'a` уже задана.

В случаях со множественными временами жизни, синтаксис будет 
подобен следующему:

```rust,ignore
foo<'a, 'b>
// `foo` имеет параметры времён жизни `'a` и `'b`
```

В данном случае, время жизни `foo` не может 
превышать *ни `'a`, ни `'b`*.

Рассмотрим следующий пример, в котором используется явная аннотация времён жизни:

```rust,editable,ignore,mdbook-runnable
// `print_refs` takes two references to `i32` which have different
// lifetimes `'a` and `'b`. These two lifetimes must both be at
// least as long as the function `print_refs`.
fn print_refs<'a, 'b>(x: &'a i32, y: &'b i32) {
    println!("x is {} and y is {}", x, y);
}

// A function which takes no arguments, but has a lifetime parameter `'a`.
fn failed_borrow<'a>() {
    let _x = 12;

    // ERROR: `_x` does not live long enough
    //let y: &'a i32 = &_x;
    // Attempting to use the lifetime `'a` as an explicit type annotation 
    // inside the function will fail because the lifetime of `&_x` is shorter
    // than that of `y`. A short lifetime cannot be coerced into a longer one.
}

fn main() {
    // Create variables to be borrowed below.
    let (four, nine) = (4, 9);
    
    // Borrows (`&`) of both variables are passed into the function.
    print_refs(&four, &nine);
    // Any input which is borrowed must outlive the borrower. 
    // In other words, the lifetime of `four` and `nine` must 
    // be longer than that of `print_refs`.
    
    failed_borrow();
    // `failed_borrow` contains no references to force `'a` to be 
    // longer than the lifetime of the function, but `'a` is longer.
    // Because the lifetime is never constrained, it defaults to `'static`.
}
```

[^1]: [сокрытие](elision.md) позволяет скрыть аннотации времён жизни, но они всё же присутствуют.

### Смотрите также:

[Обобщения](../../generics.md) и [замыкания](../../fn/closures.md)

# Приведение (coercion)

A longer lifetime can be coerced into a shorter one
so that it works inside a scope it normally wouldn't work in.
This comes in the form of inferred coercion by the Rust compiler,
and also in the form of declaring a lifetime difference:

```rust,editable
// Здесь Rust выводит наиболее короткое время жизни.
// Затем обе ссылки приводятся к этому времени жизни.
fn multiply<'a>(first: &'a i32, second: &'a i32) -> i32 {
    first * second
}

// `<'a: 'b, 'b>` читается как "время жизни `'a` не меньше, чем время жизни `'b`".
// Здесь мы получаем  `&'a i32` и в результате приведения возвращаем `&'b i32`.
fn choose_first<'a: 'b, 'b>(first: &'a i32, _: &'b i32) -> &'b i32 {
    first
}

fn main() {
    let first = 2; // Более длинное время жизни
    
    {
        let second = 3; // Более короткое время жизни
        
        println!("Произведение равно {}", multiply(&first, &second));
        println!("{} первое", choose_first(&first, &second));
    };
}
```

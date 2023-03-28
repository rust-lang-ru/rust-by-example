# `panic`

Самый простой механизм обработки ошибок, с которым мы познакомимся – это `panic`. Он печатает сообщение с ошибкой, начинает процедуру раскрутки стека и, чаще всего, завершает программу. В данном примере мы явно вызываем `panic` в случае ошибки:

```rust,editable,ignore,mdbook-runnable
fn drink(beverage: &str) {
    // Вы не должны пить слишком много сладких напитков.
    if beverage == "lemonade" { panic!("AAAaaaaa!!!!"); }

    println!("Some refreshing {} is all I need.", beverage);
}

fn main() {
    drink("water");
    drink("lemonade");
}
```

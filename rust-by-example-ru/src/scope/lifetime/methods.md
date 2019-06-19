# Методы

Методы аннотируются аналогично функциям:

```rust,editable
struct Owner(i32);

impl Owner {
    // Время жизни аннотируется как в отдельной функции.
    fn add_one<'a>(&'a mut self) {
        self.0 += 1;
    }
    fn print<'a>(&'a self) {
        println!("`print`: {}", self.0);
    }
}

fn main() {
    let mut owner = Owner(18);

    owner.add_one();
    owner.print();
}
```

### Смотрите также:

[`Методы`][methods]

[methods]: fn/methods.html
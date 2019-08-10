# Реализация

Подобно функциям, реализации требуют выполнения некоторых условий, чтобы оставаться обобщёнными.

```rust
struct S; // Конкретный тип `S`
struct GenericVal<T>(T); // Обобщенный тип `GenericVal`

// Реализация GenericVal, где мы явно указываем типы данных параметров:
impl GenericVal<f32> {} // Указываем тип `f32`
impl GenericVal<S> {} // Указываем тип `S`, который мы определили выше

// `<T>` должен указываться перед типом, чтобы оставаться обобщённым
impl<T> GenericVal<T> {}
```

```rust,editable
struct Val {
    val: f64,
}

struct GenVal<T> {
    gen_val: T,
}

// Реализация Val
impl Val {
    fn value(&self) -> &f64 {
        &self.val
    }
}

// Реализация GenVal для обобщённого типа `T`
impl<T> GenVal<T> {
    fn value(&self) -> &T {
        &self.gen_val
    }
}

fn main() {
    let x = Val { val: 3.0 };
    let y = GenVal { gen_val: 3i32 };

    println!("{}, {}", x.value(), y.value());
}
```

### Смотрите также:

[Функции, возвращающие ссылки](../scope/lifetime/fn.md), [`impl`](../fn/methods.md) и [`struct`](../custom_types/structs.md)

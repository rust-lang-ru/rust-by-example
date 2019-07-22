# Проблема

`trait`, являющийся обобщённым для своего контейнера, есть требование к спецификации типа - пользователи `trait` *должны* специфицировать все обобщённые типы.

В примере ниже, `trait` `Contains` позволяет 
использовать обобщённые типы `A` и `B`.
Затем этот типаж реализуется для типа `Container`, в 
котором `A` и `B` специфицированы, как 
`i32`, чтобы их можно было использовать в функции 
`fn difference()`.

Потому что `Contains` имеет обобщение, мы должны 
явно указать *все* обобщённые типы для 
`fn difference()`. На практике, мы хотим выразить 
`A` и `B` через *входной 
параметр* `C`. Как вы можете увидеть в следующем 
разделе, ассоциированные типы предоставляют именно эту 
возможность.

```rust,editable
struct Container(i32, i32);

// A trait which checks if 2 items are stored inside of container.
// Also retrieves first or last value.
trait Contains<A, B> {
    fn contains(&self, _: &A, _: &B) -> bool; // Explicitly requires `A` and `B`.
    fn first(&self) -> i32; // Doesn't explicitly require `A` or `B`.
    fn last(&self) -> i32;  // Doesn't explicitly require `A` or `B`.
}

impl Contains<i32, i32> for Container {
    // True if the numbers stored are equal.
    fn contains(&self, number_1: &i32, number_2: &i32) -> bool {
        (&self.0 == number_1) && (&self.1 == number_2)
    }

    // Grab the first number.
    fn first(&self) -> i32 { self.0 }

    // Grab the last number.
    fn last(&self) -> i32 { self.1 }
}

// `C` contains `A` and `B`. In light of that, having to express `A` and
// `B` again is a nuisance.
fn difference<A, B, C>(container: &C) -> i32 where
    C: Contains<A, B> {
    container.last() - container.first()
}

fn main() {
    let number_1 = 3;
    let number_2 = 10;

    let container = Container(number_1, number_2);

    println!("Does container contain {} and {}: {}",
        &number_1, &number_2,
        container.contains(&number_1, &number_2));
    println!("First number: {}", container.first());
    println!("Last number: {}", container.last());

    println!("The difference is: {}", difference(&container));
}
```

### Смотрите также:

[`struct`](../../custom_types/structs.md) и [`trait`](../../trait.md)

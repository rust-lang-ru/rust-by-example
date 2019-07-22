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

// Типаж, который проверяет, сохранены ли 2 элемента в контейнере.
// Также он может вернуть первое или последнее значение.
trait Contains<A, B> {
    fn contains(&self, _: &A, _: &B) -> bool; // Явно требует `A` и `B`.
    fn first(&self) -> i32; // Не требует явного `A` или `B`.
    fn last(&self) -> i32;  // Не требует явного `A` или `B`.
}

impl Contains<i32, i32> for Container {
    // Истина, если сохранённые цифры равны.
    fn contains(&self, number_1: &i32, number_2: &i32) -> bool {
        (&self.0 == number_1) && (&self.1 == number_2)
    }

    // Берём первую цифру.
    fn first(&self) -> i32 { self.0 }

    // Берём последнюю цифру.
    fn last(&self) -> i32 { self.1 }
}

// `C` содержит `A` и `B`. В свете этого, необходимость снова явно указывать `A` и
// `B` огорчает.
fn difference<A, B, C>(container: &C) -> i32 where
    C: Contains<A, B> {
    container.last() - container.first()
}

fn main() {
    let number_1 = 3;
    let number_2 = 10;

    let container = Container(number_1, number_2);

    println!("Содержатся ли в контейнере {} и {}? {}",
        &number_1, &number_2,
        container.contains(&number_1, &number_2));
    println!("Первое число: {}", container.first());
    println!("Последнее число: {}", container.last());

    println!("Разница: {}", difference(&container));
}
```

### Смотрите также:

[`struct`](../../custom_types/structs.md) и [`trait`](../../trait.md)

# `Box`, стек и куча

Все значения в Rust по умолчанию аллоцируются на стеке. Значения могут быть *упакованы*
(аллоцированы в куче) при помощи создания `Box<T>`. `Box` - это умный указатель на аллоцированное в куче значение типа `T`. Когда `Box` покидает область видимости, вызывается его деструктор, который уничтожает внутренний объект, и занятая им память в куче освобождается.

Упакованные значения могут быть разыменованы с помощью операции `*`.
Эта операция убирает один уровень косвенности.

```rust,editable
use std::mem;

#[allow(dead_code)]
#[derive(Debug, Clone, Copy)]
struct Point {
    x: f64,
    y: f64,
}

#[allow(dead_code)]
struct Rectangle {
    p1: Point,
    p2: Point,
}

fn origin() -> Point {
    Point { x: 0.0, y: 0.0 }
}

fn boxed_origin() -> Box<Point> {
    // Аллоцировать эту точку в куче и вернуть указатель на неё
    Box::new(Point { x: 0.0, y: 0.0 })
}

fn main() {
    // (все аннотации типов избыточны)
    // Переменные, аллоцированные на стеке
    let point: Point = origin();
    let rectangle: Rectangle = Rectangle {
        p1: origin(),
        p2: Point { x: 3.0, y: 4.0 }
    };

    // Прямоугольник, аллоцированный в куче
    let boxed_rectangle: Box<Rectangle> = Box::new(Rectangle {
        p1: origin(),
        p2: origin()
    });

    // Результат функции может быть упакован
    let boxed_point: Box<Point> = Box::new(origin());

    // Двойная косвенность
    let box_in_a_box: Box<Box<Point>> = Box::new(boxed_origin());

    println!("Точка занимает {} байт на стеке",
             mem::size_of_val(&point));
    println!("Прямоугольник занимает {} байт на стеке",
             mem::size_of_val(&rectangle));

    // box size == pointer size
    println!("Упакованная точка занимает {} байт на стеке",
             mem::size_of_val(&boxed_point));
    println!("Упакованный прямоугольник занимает {} байт на стеке",
             mem::size_of_val(&boxed_rectangle));
    println!("Упакованная 'упаковка' занимает {} байт на стеке",
             mem::size_of_val(&box_in_a_box));

    // Копируем данные из `boxed_point` в `unboxed_point`
    let unboxed_point: Point = *boxed_point;
    println!("Распакованная точка занимает {} байт на стеке",
             mem::size_of_val(&unboxed_point));
}
```

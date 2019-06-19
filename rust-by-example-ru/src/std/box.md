# Упаковка, стек и куча

По умолчанию, все значения в Rust располагаются в стеке. Значения можно *упаковать*
(разместить в куче), создав упаковку `Box<T>`. Упаковка — умный указатель на значение
типа `T` в куче. Когда упаковка оказывается за пределами области видимости, вызывается
деструктор, содержащийся в ней объект уничтожается, а память в куче освобождается.

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
    // Разместить эту точку в куче и вернуть указатель на неё
    Box::new(Point { x: 0.0, y: 0.0 })
}

fn main() {
    // (все аннотации типа избыточны)
    // Выделенные на стеке значения
    let point: Point = origin();
    let rectangle: Rectangle = Rectangle {
        p1: origin(),
        p2: Point { x: 3.0, y: 4.0 }
    };

    // Выделенный в куче квадрат
    let boxed_rectangle: Box<Rectangle> = Box::new(Rectangle {
        p1: origin(),
        p2: origin()
    });

    // Результат функции может быть упакован
    let boxed_point: Box<Point> = Box::new(origin());

    // Два уровня косвенной адресации
    let box_in_a_box: Box<Box<Point>> = Box::new(boxed_origin());

    println!("Point занимает {} байт в стеке",
             mem::size_of_val(&point));
    println!("Rectangle занимает {} байт в стеке",
             mem::size_of_val(&rectangle));

    // размер упаковки = размер указателя
    println!("Boxed point занимает {} байт в стеке",
             mem::size_of_val(&boxed_point));
    println!("Boxed rectangle занимает {} байт в стеке",
             mem::size_of_val(&boxed_rectangle));
    println!("Boxed box занимает {} байт в стеке",
             mem::size_of_val(&box_in_a_box));

    // Копировать данные, что находятся в `boxed_point`, в `unboxed_point`
    let unboxed_point: Point = *boxed_point;
    println!("Unboxed point занимает {} байт в стеке",
             mem::size_of_val(&unboxed_point));
}
```
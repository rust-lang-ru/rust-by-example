# Структуры

Существует три типа структур, которые можно создать с помощью ключевого слова `struct`:

- Кортежная структура, которая, в общем, является именованным кортежем.
- Классическая [C структура](https://en.wikipedia.org/wiki/Struct_(C_programming_language)).
- Единичная структура, которая не имеет полей, но может быть полезна для обобщённых типов.

```rust,editable
#[derive(Debug)]
struct Person<'a> {
    name: &'a str,
    age: u8,
}

// A unit struct
struct Nil;

// A tuple struct
struct Pair(i32, f32);

// A struct with two fields
struct Point {
    x: f32,
    y: f32,
}

// Structs can be reused as fields of another struct
#[allow(dead_code)]
struct Rectangle {
    p1: Point,
    p2: Point,
}

fn main() {
    // Create struct with field init shorthand
    let name = "Peter";
    let age = 27;
    let peter = Person { name, age };

    // Print debug struct
    println!("{:?}", peter);


    // Instantiate a `Point`
    let point: Point = Point { x: 0.3, y: 0.4 };

    // Access the fields of the point
    println!("point coordinates: ({}, {})", point.x, point.y);

    // Make a new point by using struct update syntax to use the fields of our other one
    let new_point = Point { x: 0.1, ..point };
    // `new_point.y` will be the same as `point.y` because we used that field from `point`
    println!("second point: ({}, {})", new_point.x, new_point.y);

    // Destructure the point using a `let` binding
    let Point { x: my_x, y: my_y } = point;

    let _rectangle = Rectangle {
        // struct instantiation is an expression too
        p1: Point { x: my_y, y: my_x },
        p2: point,
    };

    // Instantiate a unit struct
    let _nil = Nil;

    // Instantiate a tuple struct
    let pair = Pair(1, 0.1);

    // Access the fields of a tuple struct
    println!("pair contains {:?} and {:?}", pair.0, pair.1);

    // Destructure a tuple struct
    let Pair(integer, decimal) = pair;

    println!("pair contains {:?} and {:?}", integer, decimal);
}
```

### Задание

1. Добавьте функцию `rect_area`, которая рассчитывает площадь прямоугольника (попробуйте использовать "деструктуризацию" (разбор на части)).
2. Добавьте функцию `square`, которая принимает в качестве аргументов `Point` и `f32`, а возвращает `Rectangle`, левый нижний угол которого соответствует `Point`, а ширина и высота соответствуют `f32`.

### Смотрите также:

[`атрибуты`](../attribute.md) и [деструктуризация](../flow_control/match/destructuring.md)

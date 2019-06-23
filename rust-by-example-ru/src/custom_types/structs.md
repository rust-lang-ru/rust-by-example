# Структуры

Существует три типа структур, которые можно создать с помощью ключевого слова `struct`:

- Кортежная структура, которая, в общем, является именованным кортежем.
- Классическую [C структуру](https://ru.wikipedia.org/wiki/%D0%A1%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0_(%D1%8F%D0%B7%D1%8B%D0%BA_%D0%A1%D0%B8))
- Единичную структуру, которая не имеет полей, но может быть полезна для обобщённых типов.

```rust,editable
#[derive(Debug)]
struct Person<'a> {
    name: &'a str,
    age: u8,
}

// Единичная структура
struct Nil;

// Кортежная структура
struct Pair(i32, f32);

// Структура с двумя полями
struct Point {
    x: f32,
    y: f32,
}

// Структуры могут быть использованы как поля другой структуры
#[allow(dead_code)]
struct Rectangle {
    p1: Point,
    p2: Point,
}

fn main() {
    // Создаём структуру с помощью короткой инициализации полей
    let name = "Peter";
    let age = 27;
    let peter = Person { name, age };

    // Дебаг вывод структуры
    println!("{:?}", peter);


    // Создаём структуру `Point`
    let point: Point = Point { x: 0.3, y: 0.4 };

    // Получаем доступ к полям структуры `Point`
    println!("Координаты точки: ({}, {})", point.x, point.y);

    // Make a new point by using struct update syntax to use the fields of our other one
    let new_point = Point { x: 0.1, ..point };
    // `new_point.y` will be the same as `point.y` because we used that field from `point`
    println!("second point: ({}, {})", new_point.x, new_point.y);

    //  Деструктурируем `Point` создавая связь с помощью `let`
    let Point { x: my_x, y: my_y } = point;

    let _rectangle = Rectangle {
        // инициализация структуры так же является выражением
        p1: Point { x: my_y, y: my_x },
        p2: point,
    };

    // Создаём связь с единичной структурой
    let _nil = Nil;

    // Создаём связь с кортежной структурой
    let pair = Pair(1, 0.1);

    // Access the fields of a tuple struct
    println!("pair contains {:?} and {:?}", pair.0, pair.1);

    // Деструктурируем кортежную структуру
    let Pair(integer, decimal) = pair;

    println!("Pair хранит в себе {:?} и {:?}", integer, decimal);
}
```

### Задание

1. Добавьте функцию `rect_area`, которая рассчитывает площадь прямоугольника (попробуйте использовать "деструктуризацию" (разбор на части)).
2. Добавьте функцию `square`, которая принимает в качестве аргументов `Point` и `f32`,а возвращает `Rectangle`, левый нижний угол которого соответствует `Point`,а ширина и высота соответствуют `f32`.

### Смотрите также:

[`атрибуты`](../attribute.md) и [деструктуризация](../flow_control/match/destructuring.md)

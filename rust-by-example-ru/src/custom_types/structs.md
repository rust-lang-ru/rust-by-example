# Структуры

Существует три типа структур, которые можно создать с помощью ключевого слова `struct`:

- Кортежная структура, которая на самом деле является именованным кортежем.
- Классическая [C-структура](https://en.wikipedia.org/wiki/Struct_(C_programming_language)).
- Единичная структура, которая не имеет полей, но может быть полезна для обобщённых типов.

```rust,editable
#[derive(Debug)]
struct Person {
    name: String,
    age: u8,
}

// unit-структура
struct Unit;

// Кортежная структура
struct Pair(i32, f32);

// Структура с двумя полями
struct Point {
    x: f32,
    y: f32,
}

// Структуры могут быть использованы в качестве полей другой структуры
#[allow(dead_code)]
struct Rectangle {
    // Прямоугольник может быть определён по расположению в пространстве
    // его верхнего левого и нижнего правого углов
    top_left: Point,
    bottom_right: Point,
}

fn main() {
    // Создадим структуру при помощи сокращённой инициализации полей
    let name = String::from("Peter");
    let age = 27;
    let peter = Person { name, age };

    // Распечатаем отладочную информацию о структуре
    println!("{:?}", peter);


    // Инициализаруем `Point`
    let point: Point = Point { x: 10.3, y: 0.4 };

    // Получаем доступ к полям структуры
    println!("координаты точки: ({}, {})", point.x, point.y);

    // Создадим новую точку, используя синтаксис обновления структуры и нашу
    // существующую точку
    let bottom_right = Point { x: 5.2, ..point };

    // `bottom_right.y` будет тем же самым, что и `point.y`, так как мы взяли
    // это поле из `point`
    println!("вторая точка: ({}, {})", bottom_right.x, bottom_right.y);

    // Деструктурируем структуру при помощи `let`
    let Point { x: left_edge, y: top_edge } = point;

    let _rectangle = Rectangle {
        // создание структуры также является выражением
        top_left: Point { x: left_edge, y: top_edge },
        bottom_right: bottom_right,
    };

    // Создадим unit-структуру
    let _unit = Unit;

    // Создадим кортежную структуру
    let pair = Pair(1, 0.1);

    // Доступ к полям кортежной структуры
    println!("pair содержит {:?} и {:?}", pair.0, pair.1);

    // Деструктурируем кортежную структуру
    let Pair(integer, decimal) = pair;

    println!("pair содержит {:?} и {:?}", integer, decimal);
}
```

### Задание

1. Добавьте функцию `rect_area`, которая рассчитывает площадь прямоугольника. Попробуйте использовать деструктуризацию — разбор на части.
2. Добавьте функцию `square`, которая принимает в качестве аргументов `Point` и `f32`, а возвращает `Rectangle`, левый нижний угол которого соответствует `Point`, а ширина и высота соответствуют `f32`.

### Смотрите также:

[Атрибуты] и [деструктуризация]


[Атрибуты]: ../attribute.md
[деструктуризация]: https://en.wikipedia.org/wiki/Struct_(C_programming_language)
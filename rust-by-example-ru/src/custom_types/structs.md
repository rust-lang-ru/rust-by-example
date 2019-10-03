# Структуры

Существует три типа структур, которые можно создать с помощью ключевого слова `struct`:

- Кортежная структура, которая, в общем, является именованным кортежем.
- Классическая [C структура]).
- Единичная структура, которая не имеет полей, но может быть полезна для обобщённых типов.

```rust,editable
#[derive(Debug)], [времена жизни] и [деструктуризация]


[C структура]: https://en.wikipedia.org/wiki/Struct_(C_programming_language
[derive(Debug]struct Person<'a> {    // `'a` определяет время жизни     name: &'a str,    age: u8,}// unit-структураstruct Nil;// Кортежная структураstruct Pair(i32, f32;// Структура с двумя полямиstruct Point {    x: f32,    y: f32,}// Структуры могут быть использованы в качестве полей другой структуры#[allow(dead_code]struct Rectangle {    // Прямиоугольник может быть определён по расположению в пространстве     // его верхнего левого и нижнего правого углов    top_left: Point,    bottom_right: Point,}fn main( {    // Создадим структуру при помощи сокращённой инициализации полей    let name = "Peter";    let age = 27;    let peter = Person { name, age };    // Распечатаем отладочную информацию о структуре    println!("{:?}", peter;    // Инициализаруем `Point`    let point: Point = Point { x: 10.3, y: 0.4 };    // Доступ к полям структуры    println!("координаты точки: ({}, {}", point.x, point.y;    // Созданим новую точку исполуя синтаксис обновления структуры и нашу    // существующую точку    let bottom_right = Point { x: 5.2, ..point };        // `bottom_right.y` будет тем же самым, что и `point.y`, так как мы взяли    // это поле из `point`    println!("вторая точка: ({}, {}", bottom_right.x, bottom_right.y;    // Деструктурируем структуру при помощи `let`    let Point { x: top_edge, y: left_edge } = point;    let _rectangle = Rectangle {        // создание структуры также является выражением        top_left: Point { x: left_edge, y: top_edge },        bottom_right: bottom_right,    };    // Создадим unit-структуру    let _nil = Nil;    // Создадим кортежную структуру    let pair = Pair(1, 0.1;    // Доступ к полям кортежной структуры    println!("pair содержит {:?} и {:?}", pair.0, pair.1;    // Деструктурируем кортежную структуру    let Pair(integer, decimal = pair;    println!("pair содержит {:?} и {:?}", integer, decimal;}```### Задание1. Добавьте функцию `rect_area`, которая рассчитывает площадь прямоугольника (попробуйте использовать "деструктуризацию" (разбор на части.2. Добавьте функцию `square`, которая принимает в качестве аргументов `Point` и `f32`, а возвращает `Rectangle`, левый нижний угол которого соответствует `Point`, а ширина и высота соответствуют `f32`.### Смотрите также:[Аттрибуты]: ../attribute.md
[времена жизни]: ../scope/lifetime.md
[деструктуризация]: ../flow_control/match/destructuring.md
```

### Задание

1. Add a function `rect_area` which calculates the area of a rectangle (tryusing nested destructuring).
2. Add a function `square` which takes a `Point` and a `f32` as arguments, and returns a `Rectangle` with its lower left corner on the point, and a width and height corresponding to the `f32`.

### Смотрите также:

[`attributes`](../attribute.md), [lifetime](../scope/lifetime.md) and [destructuring](../flow_control/match/destructuring.md)

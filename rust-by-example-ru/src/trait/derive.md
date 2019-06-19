# Атрибут Derive

Компилятор способен предоставить основные реализации для некоторых типажей
с помощью [атрибута][attribute] `#[derive]`. Эти типажи могут быть
реализованы вручную, если необходимо более сложное поведение.

Ниже приводится список выводимых типажей:
* Типажи сравнения:
  [`Eq`][eq], [`PartialEq`][partial-eq], [`Ord`][ord], [`PartialOrd`][partial-ord]
* [`Clone`][clone], для создания `T` из `&T` с помощью копии.
* [`Copy`][copy], чтобы создать тип семантикой копирования, вместо семантики перемещения.
* [`Hash`][hash], чтобы вычислить хеш из `&T`.
* [`Default`][default], чтобы создать пустой экземпляр типа данных.
* `Zero`, для создания нулевого экземпляра числового типа данных.
* [`Debug`][debug], чтобы отформатировать значение с помощью `{:?}`.
 
```rust,example
// `Centimeters`, кортежная структура, которую можно сравнить
#[derive(PartialEq, PartialOrd)]
struct Centimeters(f64);

// `Inches`, кортежная структура, которую можно напечатать
#[derive(Debug)]
struct Inches(i32);

impl Inches {
    fn to_centimeters(&self) -> Centimeters {
        let &Inches(inches) = self;

        Centimeters(inches as f64 * 2.54)
    }
}

// `Seconds`, кортежная структура без дополнительных атрибутов
struct Seconds(i32);

fn main() {
    let _one_second = Seconds(1);

    // Ошибка: `Seconds` не может быть напечатана; не реализован типаж `Debug`
    //println!("Одна секунда выглядит как: {:?}", _one_second);
    // ЗАДАНИЕ ^ Попробуйте раскомментировать эту строку

    // Ошибка: `Seconds` нельзя сравнить; не реализован типаж `PartialEq`
    //let _this_is_true = (_one_second == _one_second);
    // ЗАДАНИЕ ^ Попробуйте раскомментировать эту строку

    let foot = Inches(12);

    println!("Один фут равен {:?}", foot);

    let meter = Centimeters(100.0);

    let cmp =
        if foot.to_centimeters() < meter {
            "меньше"
        } else {
            "больше"
        };

    println!("Один фут {} одного метра.", cmp);
}
```

### Смотрите также:
[`derive`][derive]

[attribute]: attribute.html
[eq]: https://doc.rust-lang.org/std/cmp/trait.Eq.html
[partial-eq]: https://doc.rust-lang.org/std/cmp/trait.PartialEq.html
[ord]: https://doc.rust-lang.org/std/cmp/trait.Ord.html
[partial-ord]: https://doc.rust-lang.org/std/cmp/trait.PartialOrd.html
[clone]: https://doc.rust-lang.org/std/clone/trait.Clone.html
[copy]: https://doc.rust-lang.org/core/marker/trait.Copy.html
[hash]: https://doc.rust-lang.org/std/hash/trait.Hash.html
[default]: https://doc.rust-lang.org/std/default/trait.Default.html
[debug]: https://doc.rust-lang.org/std/fmt/trait.Debug.html
[derive]: https://doc.rust-lang.org/reference/attributes.html#derive

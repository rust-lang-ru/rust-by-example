# Пример: unit clarification

Полезный метод преобразования единиц измерения может быть 
получен путём реализации типажа `Add` с 
параметром фантомного типа. 
`trait``Add` рассмотрен ниже:

```rust,ignore
// Эта конструкция будет навязывать: `Self + RHS = Output`
// где RHS по умолчанию Self, если иное не указано в реализации.
pub trait Add<RHS = Self> {
    type Output;

    fn add(self, rhs: RHS) -> Self::Output;
}

// `Output` должен быть `T<U>` так что `T<U> + T<U> = T<U>`.
impl<U> Add for T<U> {
    type Output = T<U>;
    ...
}
```

Вся реализация:

```rust,editable
use std::ops::Add;
use std::marker::PhantomData;

/// Создаём пустые перечисления для определения типов единиц измерения.
#[derive(Debug, Clone, Copy)]
enum Inch {}
#[derive(Debug, Clone, Copy)]
enum Mm {}

/// `Length` - тип с параметром фантомного типа `Unit`,
/// и не обобщён для типа длины (который `f64`).
///
/// Для `f64` уже реализованы типажи `Clone` и `Copy`.
#[derive(Debug, Clone, Copy)]
struct Length<Unit>(f64, PhantomData<Unit>);

/// Типаж `Add` объявляет поведение оператора `+`.
impl<Unit> Add for Length<Unit> {
     type Output = Length<Unit>;

    // add() возвращает новую структуру `Length`, содержащую сумму.
    fn add(self, rhs: Length<Unit>) -> Length<Unit> {
        // `+` вызывает реализацию `Add` для `f64`.
        Length(self.0 + rhs.0, PhantomData)
    }
}

fn main() {
    // Объявим, что `one_foot` имеет парамет фантомного типа `Inch`.
    let one_foot:  Length<Inch> = Length(12.0, PhantomData);
    // `one_meter` имеет параметр фантомного типа `Mm`.
    let one_meter: Length<Mm>   = Length(1000.0, PhantomData);

    // `+` вызывает метод `add()`, который мы реализовали для `Length<Unit>`.
    //
    // Так как `Length` реализует `Copy`, `add()` не поглощает
    // `one_foot` и `one_meter`, а копирует их в `self` и `rhs`.
    let two_feet = one_foot + one_foot;
    let two_meters = one_meter + one_meter;

    // Сложение работает.
    println!("один фут + один фут = {:?} фута", two_feet.0);
    println!("один метр + один метр = {:?} метра", two_meters.0);

    // Бессмысленные операции потерпят неудачу, как и должно быть:
    // Ошибка времени компиляции: несоответствие типов.
    //let one_feter = one_foot + one_meter;
}
```

### Смотрите также:

[Заимствование (`&`)](../../scope/borrow.md), [ограничения (`X: Y`)](../../generics/bounds.md), [перечисления](../../custom_types/enum.md), [`impl & self`](../../fn/methods.md),
[перегрузка](../../trait/ops.md), [`ref`](../../scope/borrow/ref.md), [типажи (`X for Y`)](../../trait.md) и [кортежные структуры](../../custom_types/structs.md).

# PhantomData-параметры

Параметры фантомного типа - единственное, что не отображается во 
время выполнения, но проверяется статически (и только статически) 
во время компиляции.

Типы данных могут использовать дополнительные обобщённые типы 
в качестве параметров-маркеров или для выполнения проверки 
типов во время компиляции. Эти дополнительные параметры не 
сохраняют значения и не имеют поведения во время выполнения.

В следующем примере мы совместили [std::marker::PhantomData](https://doc.rust-lang.org/std/marker/struct.PhantomData.html) и концепцию параметров фантомных типов для создания кортежей разных типов.

```rust,editable
use std::marker::PhantomData;

// Фантомная кортежная структура, которая имеет обобщение `A` со скрытым параметром `B`.
#[derive(PartialEq)] // Разрешаем для данного типа сравнения.
struct PhantomTuple<A, B>(A,PhantomData<B>);

// Фантомная структура, которая имеет обобщение `A` со скрытым параметром `B`.
#[derive(PartialEq)] // Разрешаем для данного типа сравнения.
struct PhantomStruct<A, B> { first: A, phantom: PhantomData<B> }

// Заметьте: память выделена для обобщённого типа `A`, но не для `B`.
//           Следовательно, `B` не может быть использована в вычислениях.

fn main() {
    // Здесь `f32` и `f64` - скрытые параметры.
    // Тип PhantomTuple объявлен с `<char, f32>`.
    let _tuple1: PhantomTuple<char, f32> = PhantomTuple('Q', PhantomData);
    // Тип PhantomTuple объявлен с `<char, f64>`.
    let _tuple2: PhantomTuple<char, f64> = PhantomTuple('Q', PhantomData);

    // Тип определён как `<char, f32>`.
    let _struct1: PhantomStruct<char, f32> = PhantomStruct {
        first: 'Q',
        phantom: PhantomData,
    };
    // Тип определён как `<char, f64>`.
    let _struct2: PhantomStruct<char, f64> = PhantomStruct {
        first: 'Q',
        phantom: PhantomData,
    };
    
    // Ошибка времени компиляции! Типы не совпадают, так что сравнение не может быть произведено:
    //println!("_tuple1 == _tuple2 даёт в результате: {}",
    //          _tuple1 == _tuple2);
    
    // Ошибка времени компиляции! Типы не совпадают, так что сравнение не может быть произведено:
    //println!("_struct1 == _struct2 даёт в результате: {}",
    //          _struct1 == _struct2);
}
```

### Смотрите также:

[`derive`](../trait/derive.md), [`struct`](../custom_types/structs.md) и [кортежные структуры](../custom_types/structs.md)

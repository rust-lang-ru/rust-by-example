# `TryFrom` и `TryInto`

Как и [`From` и `Into`](conversion/from_into.html), [`TryFrom`](https://doc.rust-lang.org/std/convert/trait.TryFrom.html) и [`TryInto`](https://doc.rust-lang.org/std/convert/trait.TryInto.html) - 
обобщённые типажи для конвертации между типами. Но в отличии 
от `From`/`Into`, типажи 
`TryFrom`/`TryInto` используются для 
преобразований с ошибками и возвращают 
[`Result`](https://doc.rust-lang.org/std/result/enum.Result.html).

```rust
use std::convert::TryFrom;
use std::convert::TryInto;

#[derive(Debug, PartialEq)]
struct EvenNumber(i32);

impl TryFrom<i32> for EvenNumber {
    type Error = ();

    fn try_from(value: i32) -> Result<Self, Self::Error> {
        if value % 2 == 0 {
            Ok(EvenNumber(value))
        } else {
            Err(())
        }
    }
}

fn main() {
    // TryFrom

    assert_eq!(EvenNumber::try_from(8), Ok(EvenNumber(8)));
    assert_eq!(EvenNumber::try_from(5), Err(()));

    // TryInto

    let result: Result<EvenNumber, ()> = 8i32.try_into();
    assert_eq!(result, Ok(EvenNumber(8)));
    let result: Result<EvenNumber, ()> = 5i32.try_into();
    assert_eq!(result, Err(()));
}
```

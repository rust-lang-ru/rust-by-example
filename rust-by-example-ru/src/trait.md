# Типажи (трейты)

Типаж `(trait, трейт)` - это набор методов, определённых для неизвестного типа: `Self`. Они могут получать доступ к другим методам, которые были объявлены в том же типаже.

Типажи могут быть реализованы для любых типов данных. В примере ниже, мы определили группу методов `Animal`. Типаж `Animal` реализован для типа данных `Sheep`, что позволяет использовать методы из `Animal` внутри `Sheep`.

```rust,editable
struct Sheep { naked: bool, name: &'static str }

trait Animal {
    // Сигнатура присоединённой функции; `Self` ссылается на тип, реализующий типаж.
    fn new(name: &'static str) -> Self;

    // Сигнатуры методов; эти вернут строку.
    fn name(&self) -> &'static str;
    fn noise(&self) -> &'static str;

    // Типажи могут предоставлять для методов реализацию по умолчанию.
    fn talk(&self) {
        println!("{} says {}", self.name(), self.noise());
    }
}

impl Sheep {
    fn is_naked(&self) -> bool {
        self.naked
    }

    fn shear(&mut self) {
        if self.is_naked() {
            // Тип, реализующий типаж, может использовать другие методы этого же типа.
            println!("{} is already naked...", self.name());
        } else {
            println!("{} gets a haircut!", self.name);

            self.naked = true;
        }
    }
}

// Реализуем типаж `Animal` для структуры `Sheep`.
impl Animal for Sheep {
    // `Self` - это сам тип, реализующий типаж: `Sheep`.
    fn new(name: &'static str) -> Sheep {
        Sheep { name: name, naked: false }
    }

    fn name(&self) -> &'static str {
        self.name
    }

    fn noise(&self) -> &'static str {
        if self.is_naked() {
            "baaaaah?"
        } else {
            "baaaaah!"
        }
    }
    
    // Можно переопределить методы по умолчанию, заданные в типаже.
    fn talk(&self) {
        // Например, мы можем немного тихо помедитировать.
        println!("{} pauses briefly... {}", self.name, self.noise());
    }
}

fn main() {
    // В этом случае необходима аннотация типа.
    let mut dolly: Sheep = Animal::new("Dolly");
    // TODO ^ Попробуйте убрать аннотацию типа.

    dolly.talk();
    dolly.shear();
    dolly.talk();
}
```

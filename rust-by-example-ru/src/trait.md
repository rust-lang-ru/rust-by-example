# Типажи

`Типаж (trait)` - это набор методов, определённых для неизвестного типа:
`Self`. Они могут получать доступ к другим методам,
которые были объявлены в том же типаже.

Типажи могут быть реализованы для любых типов данных. В примере ниже,
мы определили группу методов `Animal`. Типаж `Animal` реализован для типа данных
`Sheep`, что позволяет использовать методы из `Animal` внутри `Sheep`.

```rust,editable
struct Sheep { naked: bool, name: &'static str }

trait Animal {
    // Сигнатура статического метода, `Self` ссылается на реализующий тип.
    fn new(name: &'static str) -> Self;

    // Сигнатура метода экземпляра; они возвращают строки.
    fn name(&self) -> &'static str;
    fn noise(&self) -> &'static str;

    // Типаж может содержать определение метода по умолчанию
    fn talk(&self) {
        println!("{} говорит {}", self.name(), self.noise());
    }
}

impl Sheep {
    fn is_naked(&self) -> bool {
        self.naked
    }

    fn shear(&mut self) {
        if self.is_naked() {
            // Методы типа могут использовать методы типажа, реализованного для этого типа.
            println!("{} уже без волос...", self.name());
        } else {
            println!("{} подстригается!", self.name);

            self.naked = true;
        }
    }
}

// Реализуем типаж `Animal` для `Sheep`.
impl Animal for Sheep {
    // `Self` реализующий тип: `Sheep`.
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

    // Методы по умолчанию могут быть переопределены.
    fn talk(&self) {
        // Например, мы добавили немного спокойного миросозерцания...
        println!("{} делает паузу... {}", self.name, self.noise());
    }
}

fn main() {
    // Аннотация типа в данном случае необходима.
    let mut dolly: Sheep = Animal::new("Dolly");
    // ЗАДАНИЕ ^ Попробуйте убрать аннотацию типа

    dolly.talk();
    dolly.shear();
    dolly.talk();
}
```

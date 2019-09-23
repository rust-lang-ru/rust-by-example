# Устранение неоднозначности в перекрывающихся трейтах

Тип может реализовывать много разных трейтов. Что если два трейта будут требовать метод с одним и тем же именем? например, много трейтов могут иметь метод `get()`, которые так же могут иметь разные возвращаемые типы!

Хорошие новости: благодаря тому, что каждая реализация трейта имеет собственный `impl`-блок, становится яснее для какого трейта мы написали метод `get`.

А что будет, когда придёт время *вызвать* эти методы? 
Чтобы устранить неоднозначность, мы можем использовать полное 
имя метода (Fully Qualified Syntax).

```rust,editable
trait UsernameWidget {
    // Получить из виджета имя пользователя
    fn get(&self) -> String;
}

trait AgeWidget {
    // Получить из виджета возраст
    fn get(&self) -> u8;
}

// Форма, реализующая оба трейта: и `UsernameWidget`, и `AgeWidget`
struct Form {
    username: String,
    age: u8,
}

impl UsernameWidget for Form {
    fn get(&self) -> String {
        self.username.clone()
    }
}

impl AgeWidget for Form {
    fn get(&self) -> u8 {
        self.age
    }
}

fn main() {
    let form = Form{
        username: "rustacean".to_owned(),
        age: 28,
    };

    // Если вы раскомментируете эту строку, вы получите ошибку, которая говорит
    // "multiple `get` found". Потому что это, в конце концов, несколько методов
    // с именем `get`.
    // println!("{}", form.get());

    let username = <Form as UsernameWidget>::get(&form);
    assert_eq!("rustacean".to_owned(), username);
    let age = <Form as AgeWidget>::get(&form);
    assert_eq!(28, age);
}
```

### Смотрите также:

[Глава "The Rust Programming Language" о полном имени методов (Fully Qualified syntax)](https://doc.rust-lang.org/book/ch19-03-advanced-traits.html#fully-qualified-syntax-for-disambiguation-calling-methods-with-the-same-name)

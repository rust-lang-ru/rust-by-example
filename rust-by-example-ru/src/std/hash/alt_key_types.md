# Альтернативные (пользовательские) типы ключей

Любой тип, реализующий типажи `Eq` и 
`Hash` могут являться ключами в 
`HashMap`. Туда входят:

- `bool` (хотя он будет не очень полезен, так как будет всего лишь два возможных ключа)
- `int`, `uint` и все их варианты
- `String` и `&str` (подсказка: вы можете сделать `HashMap` с ключами типа `String`, а вызывать `.get()` - с `&str`)

Заметьте, что `f32` и `f64` *не* 
реализуют `Hash`, из-за того, что [ошибки 
точности при работе с плавающей запятой](https://en.wikipedia.org/wiki/Floating_point#Accuracy_problems) могут привести к 
ужасным ошибкам при использовании их в качестве ключей для 
хэш-карт.

Все классы коллекций реализуют `Eq` и 
`Hash` если содержащийся в них тип также реализует 
`Eq` и `Hash`. Например, 
`Vec<T>` реализует `Hash`, если 
`T` реализует `Hash`.

Вы можете легко реализовать `Eq` и 
`Hash` для пользовательских типов добавив всего 
лишь одну строчку: `#[derive(PartialEq, Eq, Hash)]`

Компилятор сделает всё остальное. Если вы хотите больше 
контроля над деталями, вы можете сами реализовать 
`Eq` и/или `Hash`. Данное руководство 
не охватывает специфику реализации `Hash`.

Чтобы поиграть с использованием `struct` в 
`HashMap`, давайте попробуем реализовать очень 
простую систему авторизации пользователей:

```rust,editable
use std::collections::HashMap;

// `Eq` требует, чтобы для типа был также выведен `PartialEq`.
#[derive(PartialEq, Eq, Hash)]
struct Account<'a>{
    username: &'a str,
    password: &'a str,
}

struct AccountInfo<'a>{
    name: &'a str,
    email: &'a str,
}

type Accounts<'a> = HashMap<Account<'a>, AccountInfo<'a>>;

fn try_logon<'a>(accounts: &Accounts<'a>,
        username: &'a str, password: &'a str){
    println!("Имя пользователя: {}", username);
    println!("Пароль: {}", password);
    println!("Попытка входа...");

    let logon = Account {
        username,
        password,
    };

    match accounts.get(&logon) {
        Some(account_info) => {
            println!("Успешный вход!");
            println!("Имя: {}", account_info.name);
            println!("Email: {}", account_info.email);
        },
        _ => println!("Ошибка входа!"),
    }
}

fn main(){
    let mut accounts: Accounts = HashMap::new();

    let account = Account {
        username: "j.everyman",
        password: "password123",
    };

    let account_info = AccountInfo {
        name: "John Everyman",
        email: "j.everyman@email.com",
    };

    accounts.insert(account, account_info);

    try_logon(&accounts, "j.everyman", "psasword123");

    try_logon(&accounts, "j.everyman", "password123");
}
```

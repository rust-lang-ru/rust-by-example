# Разворачивание `Option` с `?`

Вы можете развернуть `Option` с использованием `matc`h, но часто проще бывает использовать 
операто`р` ?. Есл`и` x `- 
Opt`ion, то выражен`ие` x? вернёт 
значение переменной, е`с`ли `x - `
Some, в противном же случае оно завершит 
выполнение текущей функции и в`ернё`т None.

```rust,editable
fn next_birthday(current_age: Option<u8>) -> Option<String> {
	// Если `current_age` == `None`, то возвращаем `None`.
	// Если `current_age` == `Some`, то содержащееся в ней `u8` будет присвоено переменной `next_age`
    let next_age: u8 = current_age?;
    Some(format!("В следующем году мне будет {}", next_age))
}
```

Чтобы ваш код был более читаемым, вы можете составить цепочку из нескольких `?`.

```rust,editable
struct Person {
    job: Option<Job>,
}

#[derive(Clone, Copy)]
struct Job {
    phone_number: Option<PhoneNumber>,
}

#[derive(Clone, Copy)]
struct PhoneNumber {
    area_code: Option<u8>,
    number: u32,
}

impl Person {
    
    // Получим из рабочего номера телефона код региона, если он существует.
    fn work_phone_area_code(&self) -> Option<u8> {
        // Мы можем не использовать оператор `?` и тогда здесь будет много вложенных операторов `match`.
        // С ним кода будет больше. Попробуйте использовать в этом коде `match` и посмотрите,
        // какой вариант проще.
        self.job?.phone_number?.area_code
    }
}

fn main() {
    let p = Person {
        job: Some(Job {
            phone_number: Some(PhoneNumber {
                area_code: Some(61),
                number: 439222222,
            }),
        }),
    };

    assert_eq!(p.work_phone_area_code(), Some(61));
}
```

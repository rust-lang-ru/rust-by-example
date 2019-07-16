# Комбинаторы: `and_then`

`map()` описывался как использование цепочек 
функций для упрощения выражения `match`.
Однако использование `map()` с функцией, которая в 
качестве результата возвращает `Option<T>` 
приводит к вложенности `Option<Option<T>>`. Такая цепочка из множества вызовов в итоге может 
запутать. Вот тут и появляется другой комбинатор, зовущийся 
`and_then()`, известный в некоторых языках как 
`flatmap`.

`and_then()` запускает функцию, которая на вход получает обёрнутое значение, а возвращает результирующее 
значение. Если `Option` равен `None`, то 
он вернёт `None`.

В следующем примере, `cookable_v2()` возвращает  
`Option<Food>`. Используя `map()` 
вместо `and_then()` мы получим 
`Option<Option<Food>>`, который является 
не правильным типом для `eat()`.

```rust,editable
#![allow(dead_code)]

#[derive(Debug)] enum Food { CordonBleu, Steak, Sushi }
#[derive(Debug)] enum Day { Monday, Tuesday, Wednesday }

// У нас нет ингридиентов для приготовления Sushi.
fn have_ingredients(food: Food) -> Option<Food> {
    match food {
        Food::Sushi => None,
        _           => Some(food),
    }
}

// У нас есть рецепты для всего, за исключением Cordon Bleu.
fn have_recipe(food: Food) -> Option<Food> {
    match food {
        Food::CordonBleu => None,
        _                => Some(food),
    }
}

// Для приготовления блюда нам необходимы и рецепт, и ингредиент.
// Мы можем представить логику, как цепочку из`match`:
fn cookable_v1(food: Food) -> Option<Food> {
    match have_recipe(food) {
        None       => None,
        Some(food) => match have_ingredients(food) {
            None       => None,
            Some(food) => Some(food),
        },
    }
}

// Для удобства это может быть переписано с использованием более компактного `and_then()`:
fn cookable_v2(food: Food) -> Option<Food> {
    have_recipe(food).and_then(have_ingredients)
}

fn eat(food: Food, day: Day) {
    match cookable_v2(food) {
        Some(food) => println!("Yay! В {:?} мы будем есть {:?}.", day, food),
        None       => println!("О, нет. Мы не будем есть в {:?}?", day),
    }
}

fn main() {
    let (cordon_bleu, steak, sushi) = (Food::CordonBleu, Food::Steak, Food::Sushi);

    eat(cordon_bleu, Day::Monday);
    eat(steak, Day::Tuesday);
    eat(sushi, Day::Wednesday);
}
```

### Смотрите также:

[Замыкания](../../fn/closures.md), [`Option`](https://doc.rust-lang.org/std/option/enum.Option.html), и [`Option::and_then()`](https://doc.rust-lang.org/std/option/enum.Option.html#method.and_then)

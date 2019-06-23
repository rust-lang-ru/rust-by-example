# Перегрузка операторов

В Rust, множество операторов могут быть перегружены с помощью типажей. То есть, некоторые
операторы могут использоваться для выполнения различных задач на основе вводимых аргументов.
Это возможно, потому что операторы являются синтаксическим сахаром для вызова методов. Например,
оператор `+` в `a + b` вызывает метод `add` (как в `a.add(b)`).
Метод `add` является частью типажа `Add`.
Следовательно, оператор `+` могут использовать все, кто реализуют типаж `Add`.

Список типажей, таких как `Add`, которые перегружают операторы, доступен [здесь](https://doc.rust-lang.org/core/ops/).

```rust,editable
use std::ops;

struct Foo;
struct Bar;

#[derive(Debug)]
struct FooBar;

#[derive(Debug)]
struct BarFoo;

// Типаж `std::ops::Add` используется для указания функциональности `+`.
// Здесь мы объявим `Add<Bar>` - типаж сложения, со вторым
// операндом типа `Bar`.
// Следующий блок реализует операцию: Foo + Bar = FooBar
impl ops::Add<Bar> for Foo {
    type Output = FooBar;

    fn add(self, _rhs: Bar) -> FooBar {
        println!("> Вызвали Foo.add(Bar)");

        FooBar
    }
}

// Если мы поменяем местами типы, то получим реализацию некоммутативного сложения.
// Здесь мы объявим `Add<Foo>` - типаж сложения, со вторым
// операндом типа `Foo`.
// Этот блок реализует операцию: Bar + Foo = BarFoo
impl ops::Add<Foo> for Bar {
    type Output = BarFoo;

    fn add(self, _rhs: Foo) -> BarFoo {
        println!("> Вызвали Bar.add(Foo)");

        BarFoo
    }
}

fn main() {
    println!("Foo + Bar = {:?}", Foo + Bar);
    println!("Bar + Foo = {:?}", Bar + Foo);
}
```

### Смотрите также:

[Add](https://doc.rust-lang.org/core/ops/trait.Add.html), [Syntax Index](https://doc.rust-lang.org/book/second-edition/appendix-02-operators.html)

# `Rc`

Когда необходимо множественное владение, может использоваться 
`Rc` (счётчик ссылок). `Rc` отслеживает 
количество ссылок, означающих количество владельцев значения, 
сохранённого в `Rc`.

Количество ссылок на `Rc` увеличивается на 1 каждый 
раз, когда `Rc` клонируется, и уменьшается на 1, когда 
один из клонов выходит из области видимости и удаляется. Когда 
количество ссылок на `Rc` становится равным нулю, 
т.е. владельцев больше нет, и `Rc`, и значение 
удаляются.

При клонировании `Rc` никогда не делается глубокая 
копия. Клонирование лишь создаёт другой указатель на обёрнутое 
значение и увеличивает счётчик.

```rust,editable
use std::rc::Rc;

fn main() {
    let rc_examples = "Rc examples".to_string();
    {
        println!("--- rc_a is created ---");
        
        let rc_a: Rc<String> = Rc::new(rc_examples);
        println!("Reference Count of rc_a: {}", Rc::strong_count(&rc_a));
        
        {
            println!("--- rc_a is cloned to rc_b ---");
            
            let rc_b: Rc<String> = Rc::clone(&rc_a);
            println!("Reference Count of rc_b: {}", Rc::strong_count(&rc_b));
            println!("Reference Count of rc_a: {}", Rc::strong_count(&rc_a));
            
            // Two `Rc`s are equal if their inner values are equal
            println!("rc_a and rc_b are equal: {}", rc_a.eq(&rc_b));
            
            // We can use methods of a value directly
            println!("Length of the value inside rc_a: {}", rc_a.len());
            println!("Value of rc_b: {}", rc_b);
            
            println!("--- rc_b is dropped out of scope ---");
        }
        
        println!("Reference Count of rc_a: {}", Rc::strong_count(&rc_a));
        
        println!("--- rc_a is dropped out of scope ---");
    }
    
    // Error! `rc_examples` already moved into `rc_a`
    // And when `rc_a` is dropped, `rc_examples` is dropped together
    // println!("rc_examples: {}", rc_examples);
    // TODO ^ Try uncommenting this line
}
```

### Смотрите также:

[std::rc](https://doc.rust-lang.org/std/rc/index.html) и [Arc](https://doc.rust-lang.org/std/sync/struct.Arc.html).

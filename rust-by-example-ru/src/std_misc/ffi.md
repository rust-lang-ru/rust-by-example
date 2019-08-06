# Foreign Function Interface

Rust предоставляет интерфейс внешних функций (Foreign Function 
Interface, FFI) к библиотекам, написанным на языке С. Внешние 
функции должны быть объявлены внутри блока `extern` 
и аннотированы при помощи атрибута `#[link]`, который 
содержит имя внешней библиотеки.

```rust,ignore
use std::fmt;

// Этот extern-блок подключает библиотеку libm
#[link(name = "m")]
extern {
    // Это внешняя функция, которая считает квадратный корень
    // комплексного числа одинарной точности
    fn csqrtf(z: Complex) -> Complex;

    fn ccosf(z: Complex) -> Complex;
}

// Так как вызовы внешних функций считаются unsafe,
// принято писать над ними обёртки.
fn cos(z: Complex) -> Complex {
    unsafe { ccosf(z) }
}

fn main() {
    // z = -1 + 0i
    let z = Complex { re: -1., im: 0. };

    // вызов внешней функции - unsafe операция
    let z_sqrt = unsafe { csqrtf(z) };

    println!("квадратный корень от {:?} равен {:?}", z, z_sqrt);

    // вызов безопасного API в котором находится unsafe операция
    println!("cos({:?}) = {:?}", z, cos(z));
}

// Минимальная реализация комплексного числа одинарной точности
#[repr(C)]
#[derive(Clone, Copy)]
struct Complex {
    re: f32,
    im: f32,
}

impl fmt::Debug for Complex {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        if self.im < 0. {
            write!(f, "{}-{}i", self.re, -self.im)
        } else {
            write!(f, "{}+{}i", self.re, self.im)
        }
    }
}
```

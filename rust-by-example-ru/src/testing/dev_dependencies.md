# Зависимости для разработки

Иногда возникает необходимость иметь зависимости только для тестов (или примеров, или бенчмарков). Такие зависимости добавляются в `Cargo.toml` в раздел `[dev-dependencies]` . Эти зависимости не распространяются как зависимости на другие пакеты, которые зависят от этого пакета.

Одним из таких примеров является пакет [`pretty_assertions`](https://docs.rs/pretty_assertions/1.0.0/pretty_assertions/index.html), который расширяет стандартные макросы `assert_eq!` и `assert_ne!`, чтобы обеспечить цветной вывод отличий.<br> Файл `Cargo.toml` :

```toml
# Стандартное содержимое крейта здесь пропущено
[dev-dependencies]
pretty_assertions = "1"
```

Файл `src/lib.rs`:

```rust,ignore
pub fn add(a: i32, b: i32) -> i32 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;
    use pretty_assertions::assert_eq; // Крейт для использования только во время тестировании. Он не может быть использован вне кода тестов.

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
    }
}
```

## Смотрите также:

Документация [Cargo] по указанию зависимостей.


[Cargo]: http://doc.crates.io/specifying-dependencies.html
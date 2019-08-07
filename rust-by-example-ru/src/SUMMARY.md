# Оглавление

[Введение](index.md)

- [Привет, мир!](hello.md)

    - [Комментарии](hello/comment.md)
    - [Форматированный вывод](hello/print.md)
        - [Debug](hello/print/print_debug.md)
        - [Display](hello/print/print_display.md)
            - [Пример: Список](hello/print/print_display/testcase_list.md)
        - [Форматирование](hello/print/fmt.md)

- [Примитивы](primitives.md)

    - [Литералы и операторы](primitives/literals.md)
    - [Кортежи](primitives/tuples.md)
    - [Массив и срезы](primitives/array.md)

- [Пользовательские типы](custom_types.md)

    - [Структуры](custom_types/structs.md)
    - [Перечисления](custom_types/enum.md)
        - [Декларация `use`](custom_types/enum/enum_use.md)
        - [C-подобные перечисления](custom_types/enum/c_like.md)
        - [Пример: Связанный список](custom_types/enum/testcase_linked_list.md)
    - [Константы](custom_types/constants.md)

- [Связывание переменных](variable_bindings.md)

    - [Изменяемость](variable_bindings/mut.md)
    - [Область видимости и затенение](variable_bindings/scope.md)
    - [Предварительное объявление](variable_bindings/declare.md)

- [Типы](types.md)

    - [Приведение типов](types/cast.md)
    - [Литералы](types/literals.md)
    - [Вывод типов](types/inference.md)
    - [Псевдонимы](types/alias.md)

- [Преобразования](conversion.md)

    - [`From` и `Into`](conversion/from_into.md)
    - [В и из `String`](conversion/string.md)

- [Выражения](expression.md)

- [Управление потоком](flow_control.md)

    - [if/else](flow_control/if_else.md)
    - [loop](flow_control/loop.md)
        - [Вложенность и метки](flow_control/loop/nested.md)
        - [Возврат из циклов](flow_control/loop/return.md)
    - [while](flow_control/while.md)
    - [for и range](flow_control/for.md)
    - [match](flow_control/match.md)
        - [Деструктуризация](flow_control/match/destructuring.md)
            - [Кортежи](flow_control/match/destructuring/destructure_tuple.md)
            - [Перечисления](flow_control/match/destructuring/destructure_enum.md)
            - [Указатели и ссылки](flow_control/match/destructuring/destructure_pointers.md)
            - [Структуры](flow_control/match/destructuring/destructure_structures.md)
        - [Ограничители шаблонов](flow_control/match/guard.md)
        - [Связывание](flow_control/match/binding.md)
    - [if let](flow_control/if_let.md)
    - [while let](flow_control/while_let.md)

- [Функции](fn.md)

    - [Методы](fn/methods.md)
    - [Замыкания](fn/closures.md)
        - [Захват](fn/closures/capture.md)
        - [Как входные параметры](fn/closures/input_parameters.md)
        - [Анонимность типов](fn/closures/anonymity.md)
        - [Входные функции](fn/closures/input_functions.md)
        - [Как выходные параметры](fn/closures/output_parameters.md)
        - [Примеры из стандартной библиотеки](fn/closures/closure_examples.md)
            - [Iterator::any](fn/closures/closure_examples/iter_any.md)
            - [Iterator::find](fn/closures/closure_examples/iter_find.md)
    - [Функции высшего порядка](fn/hof.md)
    - [Расходящиеся функции](fn/diverging.md)

- [Модули](mod.md)

    - [Видимость](mod/visibility.md)
    - [Видимость структуры](mod/struct_visibility.md)
    - [Декларация `use`](mod/use.md)
    - [`super` и `self`](mod/super.md)
    - [Иерархия файлов](mod/split.md)

- [Контейнеры](crates.md)

    - [Библиотеки](crates/lib.md)
    - [`extern crate`](crates/link.md)

- [Cargo](cargo.md)

    - [Зависимости](cargo/deps.md)
    - [Соглашения](cargo/conventions.md)
    - [Тестирование](cargo/test.md)
    - [Скрипты сборки](cargo/build_scripts.md)

- [Атрибуты](attribute.md)

    - [`dead_code`](attribute/unused.md)
    - [Контейнеры](attribute/crate.md)
    - [`cfg`](attribute/cfg.md)
        - [Собственные условия](attribute/cfg/custom.md)

- [Обобщения](generics.md)

    - [Функции](generics/gen_fn.md)
    - [Реализация](generics/impl.md)
    - [Типажи](generics/gen_trait.md)
    - [Ограничения](generics/bounds.md)
        - [Пример: пустые ограничения](generics/bounds/testcase_empty.md)
    - [Множественные ограничения](generics/multi_bounds.md)
    - [Утверждения where](generics/where.md)
    - [New Type идиома](generics/new_types.md)
    - [Ассоциированные элементы](generics/assoc_items.md)
        - [Проблема](generics/assoc_items/the_problem.md)
        - [Ассоциированные типы](generics/assoc_items/types.md)
    - [PhantomData-параметры](generics/phantom.md)
        - [Пример: unit clarification](generics/phantom/testcase_units.md)

- [Правила области видимости](scope.md)

    - [RAII](scope/raii.md)
    - [Владение и перемещение](scope/move.md)
        - [Изменяемость](scope/move/mut.md)
    - [Заимствование](scope/borrow.md)
        - [Mutability](scope/borrow/mut.md)
        - [Замораживание](scope/borrow/freeze.md)
        - [Алиасинг](scope/borrow/alias.md)
        - [ref паттерн](scope/borrow/ref.md)
    - [Времена жизни](scope/lifetime.md)
        - [Явное аннотирование](scope/lifetime/explicit.md)
        - [Функции](scope/lifetime/fn.md)
        - [Методы](scope/lifetime/methods.md)
        - [Структуры](scope/lifetime/struct.md)
        - [Типажи](scope/lifetime/trait.md)
        - [Ограничения](scope/lifetime/lifetime_bounds.md)
        - [Приведение (coercion)](scope/lifetime/lifetime_coercion.md)
        - [Static](scope/lifetime/static_lifetime.md)
        - [Сокрытие](scope/lifetime/elision.md)

- [Типажи](trait.md)

    - [Атрибут `Derive`](trait/derive.md)
    - [Перегрузка операторов](trait/ops.md)
    - [Типаж `Drop`](trait/drop.md)
    - [Итераторы](trait/iter.md)
    - [Типаж `Clone`](trait/clone.md)

- [macro_rules!](macros.md)

    - [Синтаксис](macros/syntax.md)
        - [Указатели](macros/designators.md)
        - [Перегрузка](macros/overload.md)
        - [Повторение](macros/repeat.md)
    - [DRY (Не повторяйся)](macros/dry.md)
    - [DSL (Domain Specific Languages)](macros/dsl.md)
    - [Variadics](macros/variadics.md)

- [Обработка ошибок](error.md)

    - [`panic`](error/panic.md)
    - [`Option` & `unwrap`](error/option_unwrap.md)
        - [Комбинаторы: `map`](error/option_unwrap/map.md)
        - [Комбинаторы: `and_then`](error/option_unwrap/and_then.md)
    - [`Result`](error/result.md)
        - [`map` для `Result`](error/result/result_map.md)
        - [Псевдонимы для `Result`](error/result/result_alias.md)
        - [Преждевременный выход](error/result/early_returns.md)
        - [Введение `?`](error/result/enter_question_mark.md)
    - [Несколько типов ошибок](error/multiple_error_types.md)
        - [Получение `Result` из `Option`](error/multiple_error_types/option_result.md)
        - [Объявление типа ошибки](error/multiple_error_types/define_error_type.md)
        - [Упаковка ошибок (`Box`)](error/multiple_error_types/boxing_errors.md)
        - [Другие способы использования `?`](error/multiple_error_types/reenter_question_mark.md)
        - [Оборачивание ошибок](error/multiple_error_types/wrap_error.md)
    - [Итерирование по `Result`](error/iter_result.md)

- [Типы стандартной библиотеки](std.md)

    - [`Box`, стек и куча](std/box.md)
    - [Вектора](std/vec.md)
    - [Strings](std/str.md)
    - [`Option`](std/option.md)
    - [`Result`](std/result.md)
        - [`?`](std/result/question_mark.md)
    - [`panic!`](std/panic.md)
    - [HashMap](std/hash.md)
        - [Альтернативные (пользовательские) типы ключей](std/hash/alt_key_types.md)
        - [HashSet](std/hash/hashset.md)
    - [`Rc`](std/rc.md)

- [Разное в стандартной библиотеке](std_misc.md)

    - [Потоки](std_misc/threads.md)
        - [Пример: map-reduce](std_misc/threads/testcase_mapreduce.md)
    - [Каналы](std_misc/channels.md)
    - [Path](std_misc/path.md)
    - [Файловый ввод-вывод](std_misc/file.md)
        - [`open`](std_misc/file/open.md)
        - [`create`](std_misc/file/create.md)
        - [`read lines`](std_misc/file/read_lines.md)
    - [Дочерние процессы](std_misc/process.md)
        - [Pipes](std_misc/process/pipe.md)
        - [Ожидание](std_misc/process/wait.md)
    - [Работа с файловой системой](std_misc/fs.md)
    - [Аргументы программы](std_misc/arg.md)
        - [Парсинг аргументов](std_misc/arg/matching.md)
    - [Foreign Function Interface](std_misc/ffi.md)

- [Тестирование](testing.md)

    - [Unit-тестирование](testing/unit_testing.md)
    - [Тестирование документации](testing/doc_testing.md)
    - [Интеграционное тестирование](testing/integration_testing.md)
    - [dev-dependencies](testing/dev_dependencies.md)

- [Unsafe операции](unsafe.md)

- [Совместимость](compatibility.md)

    - [Сырые идентификаторы](compatibility/raw_identifiers.md)

- [Meta](meta.md)

    - [Документация](meta/doc.md)

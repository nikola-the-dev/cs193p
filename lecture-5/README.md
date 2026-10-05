# Layout

## Flexibility
* **inflexible** - like `Image` or `Text` where size fits their content
* **medium flexible** - `Text(...).minimumScaleFactor(...)` for font or `Image(...).resizable()`
* **mostly flexible** - like `Circle` that uses all availble space
* **fully flexible** - like `Rectangle` that uses any and all spcae offered

`.frame` or `.aspectRatio` can change a View's flexibility

`Spacer(minLength: CGFloat)` - it's view that can be put in stack and it takes all available space

`Divider()` - draws grey line

## Layout Priority

By default all elems inside stacks has priority `0` but there is modifier `.layoutPriority(...)` with the help of which you can change priority, so the elems with highest priority calculates spaces first

# `LazyHStack` and `LazyVStack`

It will not draw stacks enterilly only when it's necessarry and by the scrolling. Probably it will be used inside `ScrollView`

`LazyHGrid` and `LazyVGrid` - similar to stacks but it sizes elems based on info given to the `Lazy*Grid` (`columns` or `rows` depending on it horizontal or vertical one)

# `Grid`
Table where each row is containde `GridRow`. Manages alignment options across cells by using modifier like `.grid*()`

# Other elems

* `ScrollView`
* `ViewThatFits`
* `Form` and `List` and `OutlineGroup` and `DisclosureGroup`

All of these are responds to `Layout` protocol and can be implements `sizeThatFits`, `placeSubviews` and others

# `ZStack`

There are 2 similar modifiers:
* `.overlay(...)` - elem will be stacked on top of it's parent, but parent is main and parent defines size
* `.background(...)` - elem will be stacked on bottom of it's parent


# Data Flow

* `read-only` - it's `let`
* data owned by a View - `@State` (always do these vars `private`)
* data i/o - comes from outside and we can *might modify it*
* data out - function which delivers data out of `View` (i.e. `ViewBuilders`)
* data in function - `EnvironmentValues`
* action function - like `Button`

##`EnvironmentValues` 

Struct that keeps vars like: 

* dark/light mode
* accessibility settings
* whether app active or not
* horizontal/vertical device spacing vavilable
* locale
* `UndoManager`
* `font` / `minimumScaleFactor` / `dynamicTypeSize` / `lineSpacing`

but these values do not access directly: `@Environment`

```
struct MyView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
      Image(systemName: "moon")
        .foregroundStyle(colorScheme == .dark ? .yellow : .blue)
    }
}
```

There is also possible to add your own value to this struct:

```
extension EnvironmentValues {
    @Entry var words = Words.shared
}
```

Also there is possible to set some `View`'s environment by using modifier:

```
MyView()
    .environment(\.colorScheme, .dark)
``` 

## Sharing data between views

`@Binding` vars:

```
struct ViewA: View {
    @State private var myData: Int = 42
    var body: some View {
        ViewB(foo: $myData)
    }
}
struct ViewB: View {
    @Binding var foo: Int
}
```

`$myData` - **$** means binding to `myData`

In `ViewB` we can change `foo` to `27` and it also changes in `ViewA`'s variable `myData` 

You can pass binding value to another binding by using same `$`-sign

Actually `@Binding` creates two vars (for example for `$foo` value):
* `_foo` is a hidden one of `Binding<Type>` (you can access in an `init`)
* `boundData` - computed value of variable's `Type` (`Int` / `String` / whatever)

`@Binding` is **never** `private` because it's no sense if it will be `private`

Also there is a possible to create `@Binding` with some constant value (especially for `#Preview`):

```
ViewB(foo: Binding<Int>.constant(5))
```

or shortance:

```
ViewB(foo: .constant(5))
```

## Give/Get something funcs

By using closures:

```
struct MyView: View {
    let giveSmth: (Int) -> Void
    let getSmth: () -> Int
}
```

`giveSmth`-like widely used for passing some `Button` hit for example

`getSmth`-like is more rare

## `@Observable`

It's like `@Binding` but for classes, it has refernce semantics

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



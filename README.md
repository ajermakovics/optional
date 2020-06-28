# Optional

Optional type in Wren programming language https://wren.io

An optional can contain a single value or be empty.

## Examples

```
var maybe = Optional.of("abc") // Optional<String>("abc")
maybe.isPresent() // true
maybe.each { |value| System.print(value) } // prints "abc"

var maybe2 = maybe.map { |str| str + "123" } // Optional<String>("abc123")

var none = Optional.empty() // Optional<Empty>()
System.print(none.getOr("defaultValue")) // "defaultValue"

// pick one of three optionals - first which is not empty
var maybe3 = maybeThis | orThis | maybe2 // Optional<String>("abc123")

var res = Optional.of(request.param).filter { |v| v.count > 0 }.map { |v| v.trim() } // request param without spaces

var combined = Optional.of(1) + Optional.of(2) // Optional(3)

var reqParam = combined.flatMap {|value| Optional.of(value + 100) }  // Optional(103)
System.print(reqParam.contains(103)) // true

```

## Usage

```
import "./optional/optional" for Optional
```

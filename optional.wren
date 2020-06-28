/*
An optional can contain a single value or be empty.
*/
class Optional {

  /* Create an optional
  initVal: a value, null or a function that returns a value
   */
  static of(initVal) {
    if (initVal is Fn) {
      return Optional.of(initVal.call())
    }

    if (initVal) {
      return Some.new(initVal)
    } else {
      return Optional.empty()
    }
  }

  /* Create an empty optional */
  static empty() {
    return None.new()
  }

  |(other) {
    return or(other)
  }

  isEmpty {
    return !isPresent()
  }
}

/* Class representing Optional with a value **/
class Some is Optional {

  construct new(initialValue) {
    _value = initialValue
  }

  value { _value }

  isPresent() { 
    return _value != null
  }

  get() {
    return _value
  }

  getOr(defaultValue) {
    return _value ? _value : defaultValue
  }

  /* >> */
  map(mapFn) {
    return Optional.of(mapFn.call(_value))
  }

  /* >>= */
  flatMap(flatMapFn) {
    return flatMapFn.call(_value)
  }

  filter(predicate) {
    if(predicate.call(_value)) {
      return this
    } else {
      return Optional.empty()
    }
  }

  toString {
    var valType = _value ? "<" + _value.type.name + ">" : ""
    var valStr = _value ? _value.toString : "null"
    return "Optional" + valType + "(" + valStr + ")"
  }

  toList {
    return _value ? [_value] : []
  }

  each(consumerFn) {
    consumerFn.call(_value)
    return this
  }

  flatten() {
    return (_value is Optional) ? _value : this
  }

  /** other: a value, other Optional or function to get new value **/
  or(other) {
    return this
  }

  contains(someValue) {
    if (someValue is Fn) {
      return someValue.call(_value)
    }
    return _value == someValue
  }

  ==(other) {
    if (other.isEmpty) {
      return false
    }
    return value == other.value
  }

  +(other) {
    if (other.isEmpty) {
      return this
    }
    return Optional.of(value + other.value)
  }

  count {
    return _value ? 1 : 0
  }
}

/* Class representingn an empty Optional - without a value **/
class None is Optional {

    construct new() {
    }

    isPresent() { 
      return false
    }

    getOr(defaultValue) {
      return defaultValue
    }

    map(mapFn) {
      return this
    }

    flatMap(flatMapFn) {
      return this
    }

    flatten() {
      return this
    }

    filter(predicate) {
      return this
    }

    toString {
      return "Optional<Empty>()"
    }

    each(consumer) {
      return this
    }

    toList {
      return []
    }

    count {
      return 0
    }

    or(other) {
      if (other is Optional) {
        return other
      } else if (other is Fn) {
        return Optional.of(other.call())
      } else {
        return Optional.of(other)
      }
    }

    contains(someValue) {
      return false
    }

    ==(other) {
      return other.isEmpty
    }

    +(other) {
      return other.isEmpty ? this : other
    }
}

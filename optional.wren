
class Optional {

  static of(initVal) {
    if(initVal) {
      return Some.new(initVal)
    } else {
      return None.new()
    }
  }

  static empty() {
    return None.new()
  }

  or(other) {
    var otherOpt
    if (other is Optional) {
      otherOpt = other
    } else if(other is Fn) {
      otherOpt = Optional.of(other.call())
    } else {
      otherOpt = Optional.of(other)
    }

    return isPresent() ? this : otherOpt
  }
}

class Some is Optional {
  construct new(initialValue) {
    _value = initialValue
  }

  isPresent() { 
    return _value != null
  }

  get() {
    return _value
  }

  map(mapFn) {
    return Optional.of(mapFn.call(_value))
  }

  flatMap(flatMapFn) {
    return flatMapFn.call(_value)
  }

  filter(filterFn) {
    if(filterFn.call(_value)) {
      return this
    } else {
      return Optional.empty()
    }
  }

  toString {
    var valType = _value.type.name
    return "Some{" + _value.toString + "=" + valType + "}"
  }

  forEach(consumerFn) {
    if(isPresent()) {
      consumerFn.call(_value)
    }
    return this
  }

  flatten() {
    return (_value is Optional) ? _value : this
  }
}

class None is Optional {
    construct new() {
    }

    isPresent() { 
      return false
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

    filter(filterFn) {
      return this
    }

    toString {
      return "None{}"
    }

    forEach(consumer) {
      return this
    }
}

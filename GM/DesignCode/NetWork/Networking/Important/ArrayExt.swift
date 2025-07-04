import Foundation

public extension Array where Element: Equatable {
  var unique: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      guard !uniqueValues.contains(item) else { return }
      uniqueValues.append(item)
    }
    return uniqueValues
  }
  
  subscript(safe index: Index) -> Element? {
    get { return self.indices ~= index ? self[index] : nil }
    set {
      if self.indices ~= index {
        self[index] = newValue!
      } else {
        while !(self.indices ~= index) {
          self.append(newValue!)
        }
      }
    }
  }
  
  func appending(value: Element) -> Self {
    var copy = self
    copy.append(value)
    return copy
  }
}

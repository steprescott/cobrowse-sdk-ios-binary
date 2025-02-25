
extension Array where Element == String {
    
    var protocols: [`Protocol`] {
        self.map { .init(named: $0) }
    }
    
    var set: Set<String> {
        Set(self)
    }
}

extension Array where Element == `Protocol` {

    var set: Set<`Protocol`> {
        Set(self)
    }
}

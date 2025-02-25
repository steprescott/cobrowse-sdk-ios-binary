
import Foundation

struct `Protocol`: Equatable, Hashable, Comparable {
    
    let type: String

    init(named type: String) {
        self.type = type
    }
    
    static func < (lhs: Protocol, rhs: Protocol) -> Bool {
        lhs.type < rhs.type
    }
}

extension Set where Element == `Protocol` {
    var types: [String] {
        map { $0.type }
    }
}



import SwiftSyntax

extension InheritedTypeListSyntax {

    func contains(_ protocol: `Protocol`) -> Bool {
        containsAny(Set(arrayLiteral: `protocol`))
    }
    
    func containsAny(_ protocols: Set<`Protocol`>) -> Bool {
        for type in self {
            let typeName = type.type.trimmedDescription
            if protocols.contains(where: { $0.type == typeName }) {
                return true
            }
        }
        return false
    }
}

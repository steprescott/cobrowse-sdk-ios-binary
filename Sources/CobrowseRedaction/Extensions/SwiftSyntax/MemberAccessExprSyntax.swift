
import SwiftSyntax

extension MemberAccessExprSyntax {
    
    var name: String {
        return declName.baseName.trimmedDescription
    }
    
    func isNamed(_ name: String) -> Bool {
        return self.name == name
    }
}

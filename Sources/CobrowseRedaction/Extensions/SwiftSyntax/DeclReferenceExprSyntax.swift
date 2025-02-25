
import SwiftSyntax

extension DeclReferenceExprSyntax {
    
    var name: String {
        baseName.trimmedDescription
    }
}

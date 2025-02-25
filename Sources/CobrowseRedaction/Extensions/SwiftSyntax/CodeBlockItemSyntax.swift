
import SwiftSyntax

extension CodeBlockItemSyntax {
    
    var structName: String? {
        self.firstParent(of: StructDeclSyntax.self)?.name.trimmedDescription
    }
}

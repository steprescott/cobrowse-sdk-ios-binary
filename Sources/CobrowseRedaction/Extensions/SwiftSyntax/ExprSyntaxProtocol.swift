
import SwiftSyntax

extension ExprSyntaxProtocol where Self == MemberAccessExprSyntax {
    
    static func memberAccessExpression(named name: String, using base: FunctionCallExprSyntax) -> MemberAccessExprSyntax {
        
        let newlines = base.leadingTrivia.pieces.first { $0.isNewline }
        let spaces = base.leadingTrivia.pieces.first { $0.isSpaceOrTab } ?? .spaces(0)
        
        let addNewLines = base.trailingClosure != nil
        let addSpaces = newlines != nil && base.trailingClosure == nil
        let trailingTrivia = Trivia(pieces: [newlines ?? .newlines(addNewLines ? 1 : 0), spaces, (addSpaces ? .spaces(4) : .spaces(0))])
        
        return .init(
            base: base.with(\.trailingTrivia, trailingTrivia),
            declName: .init(baseName: .identifier(name))
        )
    }
}

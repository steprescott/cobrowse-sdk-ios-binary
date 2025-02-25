
import SwiftSyntax
import SwiftSyntaxBuilder

extension String {
    
    var stringLiteralExpression: StringLiteralExprSyntax {
        
        StringLiteralExprSyntax(
            openingQuote: .stringQuoteToken(),
            segments: StringLiteralSegmentListSyntax {
                .init(content: .identifier(self))
            },
            closingQuote: .stringQuoteToken()
        )
    }
}

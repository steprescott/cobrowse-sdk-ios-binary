
import SwiftSyntax

private let cobrowseComputeRedactionStateViewModifierName = "cobrowseComputeRedactionState"

extension FunctionCallExprSyntax {

    func withCobrowseComputeRedactionState() -> FunctionCallExprSyntax {

        return FunctionCallExprSyntax(
            calledExpression: .memberAccessExpression(
                named: cobrowseComputeRedactionStateViewModifierName,
                using: self
            ),
            leftParen: .leftParenToken(),
            arguments: LabeledExprListSyntax {
                
            },
            rightParen: .rightParenToken(),
            trailingTrivia: .space
        )
    }
    
    var hasCobrowseComputeRedactionStateViewModifier: Bool {
        cobrowseComputeRedactionStateViewModifier() != nil
    }
    
    func cobrowseComputeRedactionStateViewModifier() -> MemberAccessExprSyntax? {
        viewModifier(named: cobrowseComputeRedactionStateViewModifierName, in: self)
    }
    
    func viewModifier(named name: String, in node: FunctionCallExprSyntax?) -> MemberAccessExprSyntax? {
        
        guard
            let node = node,
            let memberAccessExpr = node.calledExpression.as(MemberAccessExprSyntax.self)
        else { return nil }
        
        if memberAccessExpr.declName.trimmedDescription == name {
            return memberAccessExpr
        }
        
        if let baseFunctionCallExpr = memberAccessExpr.base?.as(FunctionCallExprSyntax.self) {
            return viewModifier(named: name, in: baseFunctionCallExpr)
        }
        
        return nil
    }
}

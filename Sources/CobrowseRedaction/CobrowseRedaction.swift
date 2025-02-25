import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct CobrowseRedactionPlugin: CompilerPlugin {
    var providingMacros: [Macro.Type] = [CobrowseRedaction.self]
}

public struct CobrowseRedaction: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Find the body property in the View
        guard let structDecl = declaration.as(StructDeclSyntax.self) else {
            throw CustomError.message("@CobrowseRedaction can only be applied to struct declarations")
        }
        
        // Find the body property
        guard let bodyProperty = structDecl.memberBlock.members.first(where: { member in
            guard let varDecl = member.decl.as(VariableDeclSyntax.self),
                  let binding = varDecl.bindings.first,
                  let pattern = binding.pattern.as(IdentifierPatternSyntax.self) else {
                return false
            }
            return pattern.identifier.text == "body"
        }),
        let varDecl = bodyProperty.decl.as(VariableDeclSyntax.self),
        let binding = varDecl.bindings.first,
        let accessorBlock = binding.accessorBlock else {
            throw CustomError.message("Could not find a body property with a computed property")
        }
        
        // Keep track of the original function calls and their updated versions
        var functionCallReplacements: [(FunctionCallExprSyntax, FunctionCallExprSyntax)] = []
        
        let functionCalls = accessorBlock.allChildren(of: FunctionCallExprSyntax.self)
        
        for functionCall in functionCalls {
            
            guard functionCall.firstParent(of: MemberAccessExprSyntax.self) == nil
                else { continue }
            
            let updated = functionCall.withCobrowseComputeRedactionState()
            functionCallReplacements.append((functionCall, updated))
        }
        
        // Create the new redactedBody property as a string first
        let originalText = varDecl.description
        var newText = originalText
        
        // Replace "var body" with "var redactedBody"
        newText = newText.replacingOccurrences(of: "var body", with: "var redactedBody")
        
        // Replace each function call with its updated version
        for (original, updated) in functionCallReplacements {
            newText = newText.replacingOccurrences(of: original.description, with: updated.description)
        }

        print(newText)
        return [DeclSyntax(stringLiteral: newText)]
    }
}

enum CustomError: Error {
    case message(String)
}

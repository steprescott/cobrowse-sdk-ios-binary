
import SwiftSyntax

extension GenericRequirementListSyntax {
    
    func containsProtocolConformance(from protocols: Set<`Protocol`>) -> Bool {
        
        for requirement in self {
            if let conformanceRequirement = requirement.requirement.as(ConformanceRequirementSyntax.self) {
                let protocolName = conformanceRequirement.rightType.trimmedDescription
                if protocols.contains(where: { $0.type == protocolName }) {
                    return true
                }
            }
        }
        
        return false
    }
}

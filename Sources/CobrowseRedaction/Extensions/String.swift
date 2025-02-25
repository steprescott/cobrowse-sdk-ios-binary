
import Foundation

#if hasFeature(RetroactiveAttribute)
extension String: @retroactive Error { }
#else
extension String: Error { }
#endif

extension String {
    
    var cleaned: String {
        let knownPrefixes = [
            "SwiftUI.",
            "SwiftUICore."
        ]
        
        var result = self

        if result.hasPrefix("\""), result.hasSuffix("\"") {
            result = String(result.dropFirst().dropLast())
        }
        
        for prefix in knownPrefixes {
            if result.hasPrefix(prefix) {
                result = String(result.dropFirst(prefix.count))
                break
            }
        }
        
        return result
    }
}

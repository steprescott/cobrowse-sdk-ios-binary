
import SwiftSyntax

extension SyntaxProtocol {

    func firstParent<T: SyntaxProtocol>(of type: T.Type) -> T? {
        return findParents(of: T.self, findAll: false).first
    }

    func firstChild<T: SyntaxProtocol>(of type: T.Type) -> T? {
        return findChildren(of: T.self, findAll: false).first
    }
    
    func lastParent<T: SyntaxProtocol>(of type: T.Type) -> T? {
        return findParents(of: T.self, findAll: true).last
    }

    func lastChild<T: SyntaxProtocol>(of type: T.Type) -> T? {
        return findChildren(of: T.self, findAll: true).last
    }

    func allParents<T: SyntaxProtocol>(of type: T.Type) -> [T] {
        return findParents(of: T.self, findAll: true)
    }

    func allChildren<T: SyntaxProtocol>(of type: T.Type) -> [T] {
        return findChildren(of: T.self, findAll: true)
    }
    
    private func findParents<T: SyntaxProtocol>(of type: T.Type, findAll: Bool) -> [T] {
        
        var parents: [T] = []
        var currentParent = self.parent

        while let parent = currentParent {
            
            if let typedParent = parent.as(T.self) {
                parents.append(typedParent)
                if !findAll { break }
            }
            
            currentParent = parent.parent
        }

        return parents
    }

    private func findChildren<T: SyntaxProtocol>(of type: T.Type, findAll: Bool) -> [T] {
        
        var matchingChildren: [T] = []

        for child in children(viewMode: .sourceAccurate) {
            
            if let typedChild = child.as(T.self) {
                matchingChildren.append(typedChild)
                if !findAll { return matchingChildren }
            }
            
            matchingChildren.append(contentsOf: child.findChildren(of: T.self, findAll: findAll))
            
            if !findAll && !matchingChildren.isEmpty {
                return matchingChildren
            }
        }

        return matchingChildren
    }
}


import Foundation

extension URL {
    
    func createDirectory() throws {
        try FileManager.default.createDirectory(
            at: self,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }
    
    func deleteContents() throws {
        let fileManager = FileManager.default
        
        let contents = try fileManager.contentsOfDirectory(at: self, 
                                                           includingPropertiesForKeys: nil)
        
        for item in contents {
            try fileManager.removeItem(at: item)
        }
    }
}

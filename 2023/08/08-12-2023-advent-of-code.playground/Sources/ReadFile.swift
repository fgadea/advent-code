import Foundation

public class ReadFile {
    public init() {}
    
    public func read(file: String) -> [String] {
        guard let path = Bundle.main.url(forResource: file, withExtension: "txt") else {
            return []
        }
        
        let content = try? String(contentsOf: path)
        let lines = content?.split(separator:"\n") ?? []
        let linesFormatted = lines.compactMap({String($0)})
        if linesFormatted.count > 0 {
            return linesFormatted
        }
        
        return []
    }
}

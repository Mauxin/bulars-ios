import Foundation
import Firebase

//actualy this class is unused

private enum RegexTypes: String {
    case regex1 = "[A-Z][a-z]{3,10}"
    case regex2 = "[A-Z]{3,10}"
    case regex3 = "[a-z]{3,10}"
}

public class TextFilter {
    
    public init () {}
    
    var textFiltred = ""
    
    public static func possibleName(string: String) throws -> [String] {
        
        if let regex = try? NSRegularExpression(pattern: RegexTypes.regex1.rawValue) {
            
            return regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count)).map {
                guard let range = Range($0.range, in: string) else {
                    return ""
                }
                
                return String(string[range])
            }
        }
        
        return []
    }
    
}

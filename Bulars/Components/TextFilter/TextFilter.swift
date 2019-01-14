import Foundation
import Firebase

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
    
    /*func filter(image: UIImage) {
        
        let vision = Vision.vision()
        let textDetector = vision.textDetector()
        let visionImage = VisionImage(image: image)
        
        textDetector.detect(in: visionImage) {features, error in
            guard error == nil, let features = features, !features.isEmpty else {
                return
            }
            
            var finaltext: String = ""
            var biggestText: VisionText? = nil
            
            for feature in features {
                if feature.frame.height > biggestText?.frame.height ?? 0 {
                    biggestText = feature
                }
            }
            
            do { let filterResult = try self.possibleName(string: biggestText?.text ?? "Erro")
                finaltext = ""
                
                finaltext = filterResult[0]
                
                self.textFiltred = finaltext.lowercased()
            } catch {print(error)}
        }
    }*/
    
    /*public func getTextFiltred(image: UIImage) -> String {
        self.filter(image: image)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {}
        return self.textFiltred
    }*/
}

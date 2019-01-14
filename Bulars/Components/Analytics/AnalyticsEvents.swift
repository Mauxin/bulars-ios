import Firebase

class AnalyticsEvents {
    static func clickEvent(content: String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterContent : content as NSObject
            ])
    }
    
    static func searchingEvent(term: String, type: String) {
        Analytics.logEvent(AnalyticsEventSearch, parameters: [
            AnalyticsParameterSearchTerm : term as NSObject,
            AnalyticsParameterContent : type as NSObject
            ])
    }
}

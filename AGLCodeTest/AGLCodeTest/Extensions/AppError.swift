import Foundation

struct AppError: Error {
    
    var locString: String
    var reason: String?
    var code: Int
}

extension AppError: LocalizedError {
    //LocalizedError
    var errorDescription: String? {
        return locString
    }
}

extension Error {
    var errorCode: Int {
        return (self as! AppError).code
    }
    var failureReason: String? {
        return (self as! AppError).reason
    }
}

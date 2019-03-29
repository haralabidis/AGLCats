import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    //Used in unit tests as a way to verify if resume was called
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}

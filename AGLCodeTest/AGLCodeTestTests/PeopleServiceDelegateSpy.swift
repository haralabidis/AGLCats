import Foundation
import XCTest

@testable import AGLCodeTest

class PeopleServiceDelegateSpy: PeopleServiceDelegate {

    var retrievePeopleDataAsyncResult: Bool? = .none
    var retrievePeopleDataAsyncError: Error? = nil
    
    var asyncExpectation: XCTestExpectation?
    
    func didRetrievePeopleData(success: Bool) {
        guard let expectation = asyncExpectation else {
            XCTFail("PeopleServiceDelegateSpy was not setup correctly. Missing XCTExpectation reference")
            return
        }
        retrievePeopleDataAsyncResult = success
        expectation.fulfill()
    }
    
    func didFailToRetrievePeopleData(error: Error) {
        guard let expectation = asyncExpectation else {
            XCTFail("PeopleServiceDelegateSpy was not setup correctly. Missing XCTExpectation reference")
            return
        }
        retrievePeopleDataAsyncError = error
        expectation.fulfill()
    }
    
}

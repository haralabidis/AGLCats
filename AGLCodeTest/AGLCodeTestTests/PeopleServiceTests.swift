import XCTest
@testable import AGLCodeTest

class PeopleServiceTests: XCTestCase {
    
    var peopleService: PeopleService!
    let session = MockURLSession()
    let jsonDecoder = JSONDecoder()
    let url = URL(string: "https://mockurl")
    
    override func setUp() {
        super.setUp()
        peopleService = PeopleService(url: url!, session: session, jsonDecoder: jsonDecoder)
    }
    
    override func tearDown() {
        super.tearDown()
        peopleService = nil
    }
    
    //-----------------------------
    // MARK: URLSession Tests
    //-----------------------------
    
    func test_retrievePeopleData() {
        peopleService.retrievePeopleData()
        XCTAssert(session.lastURL == url)
    }
    
    func test_resume_called() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        peopleService.retrievePeopleData()
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_call_to_API_completes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error?
        
        // when
        let dataTask = session.dataTask(with: url!) { data, response, error in
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
    }
    
    //-----------------------------
    // MARK: Delegate Tests
    //-----------------------------
    
    func test_delegate_method_is_called_async() {

        generateStubData()
        
        let peopleService = PeopleService(url: url!, session: session, jsonDecoder: jsonDecoder)
        let peopleServiceDelegateSpy = PeopleServiceDelegateSpy()
        peopleService.delegate = peopleServiceDelegateSpy
        
        let promise = expectation(description: "PeopleService calls the delegate as the result of an async method completion")
        peopleServiceDelegateSpy.asyncExpectation = promise
        
        peopleService.retrievePeopleData()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
           guard let result = peopleServiceDelegateSpy.retrievePeopleDataAsyncResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            
            XCTAssertTrue(result)
        }
    }
    
    //------------------------------------
    // MARK: Generate stub response data
    //------------------------------------
    
    public func generateStubData() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MockData", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            session.nextData = data
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
}

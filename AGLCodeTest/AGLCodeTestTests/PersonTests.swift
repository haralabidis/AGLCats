import XCTest
@testable import AGLCodeTest

class PersonTests: XCTestCase {
    var people: People?
    let jsonDecoder = JSONDecoder()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {
        //given
        //Generate dat from stub
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "MockData", withExtension: "json") else {
            XCTFail("Missing file: MockData")
            return
        }
        let data = try Data(contentsOf: url)
        //when
        // Test JSON mapping
        do {
            people = try self.jsonDecoder.decode(People.self, from: data)
        } catch (let error) {
            print(error.localizedDescription)
            XCTFail("Failed to map json")
        }
        guard let people = people else {
            XCTFail("No data is available")
            return
        }
        // then
        XCTAssertEqual(people[0].name, "Bob")
        XCTAssertEqual(people[0].age, 23)
    }

}

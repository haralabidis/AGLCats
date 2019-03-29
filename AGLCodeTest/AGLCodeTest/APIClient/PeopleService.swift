import Foundation

protocol PeopleServiceDelegate {
    func didRetrievePeopleData(success: Bool)
    func didFailToRetrievePeopleData(error: Error)
}

class PeopleService: NSObject {
    
    var delegate: PeopleServiceDelegate?
    
    private let session: URLSessionProtocol
    private let url: URL
    private let jsonDecoder: JSONDecoder
    
    init(url: URL, session: URLSessionProtocol, jsonDecoder: JSONDecoder) {
        self.url = url
        self.session = session
        self.jsonDecoder = jsonDecoder
    }
    
    func retrievePeopleData() {
        let task = session.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                self.delegate?.didFailToRetrievePeopleData(error: error!)
                return
            }
            guard let data = data else {
                let error = AppError(locString: "No Data", reason: "Service did not return data", code: 0)
                self.delegate?.didFailToRetrievePeopleData(error: error)
                return
            }
            do {
                let people = try self.jsonDecoder.decode(People.self, from: data)
                PeopleData.shared.updateData(people: people)
                self.delegate?.didRetrievePeopleData(success: true)
            } catch let error {
                self.delegate?.didFailToRetrievePeopleData(error: error)
                return
            }
        }
        task.resume()
    }
    
    
}

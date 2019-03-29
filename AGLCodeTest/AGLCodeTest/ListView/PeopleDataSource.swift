import Foundation
import UIKit

protocol PeopleDatasourceDelegate {
    func didUpdatePeopleData()
    func didFailToUpdatePeopleData(error: Error)
}

class PeopleDataSource: NSObject, UITableViewDataSource, PeopleServiceDelegate {

    var delegate: PeopleDatasourceDelegate?
    var peopleData: [PeopleViewModel] = []
    var peopleService: PeopleService?
    
    let session = URLSession.shared
    let jsonDecoder = JSONDecoder()
    let url = URL(string: "http://agl-developer-test.azurewebsites.net/people.json")
    
    override init() {
        super.init()
        guard let url = url else { return }
        peopleService = PeopleService(url: url, session: session, jsonDecoder: jsonDecoder)
        peopleService?.delegate = self
    }
    
    //---------------------------------------
    // MARK: - TableviewDataSource Delegate
    //---------------------------------------
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return peopleData[section].ownerGender.rawValue
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return peopleData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleData[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatNameTableViewCell", for: indexPath) as! CatNameTableViewCell
        let catName = peopleData[indexPath.section].names[indexPath.row]
        cell.configureWithCatName(catName: catName)
        
        return cell
    }
    
    //---------------------------------------
    // MARK: - Data retrieval
    //---------------------------------------
    
    func retrievePeopleData() {
        if PeopleData.shared.data.count == 0 {
            peopleService?.retrievePeopleData()
        } else {
            self.peopleData = PeopleData.shared.data
            self.delegate?.didUpdatePeopleData()
        }
    }
    
    func reloadData() {
        peopleService?.retrievePeopleData()
    }
    
    //------------------------------------
    // MARK: - PeopleService Delegate
    //------------------------------------
    
    func didRetrievePeopleData(success: Bool) {
        self.peopleData = PeopleData.shared.data
        self.delegate?.didUpdatePeopleData()
    }
    
    func didFailToRetrievePeopleData(error: Error) {
        self.delegate?.didFailToUpdatePeopleData(error: error)
    }
    

}

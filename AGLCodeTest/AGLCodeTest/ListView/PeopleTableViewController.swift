import UIKit

class PeopleTableViewController: UITableViewController, PeopleDatasourceDelegate {
    
    @IBOutlet var noDataView: UIView!
    
    private let peopleDataSource = PeopleDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControll()
        peopleDataSource.delegate = self
        tableView.dataSource = peopleDataSource
        tableView.delegate = self
        refreshPeopleData()
    }
    
    //---------------------------------------
    // MARK: - Pull to refresh
    //---------------------------------------
    
    func setupRefreshControll() {
        guard let refreshControl = refreshControl else {return}
        refreshControl.addTarget(self, action: #selector(refreshPeopleData(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching people Data ...", attributes: [NSAttributedString.Key.font : UIFont.init(name: "Helvetica Neue", size: 15) as Any])
    }
    
    @objc private func refreshPeopleData(_ sender: Any) {
        refreshPeopleData()
    }
    
    //---------------------------------------
    // MARK: - TableviewDataSource Delegate
    //---------------------------------------
    
    func didUpdatePeopleData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if (self.refreshControl?.isRefreshing)! {
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    func didFailToUpdatePeopleData(error: Error) {
        DispatchQueue.main.async {
            self.tableView.backgroundView = self.noDataView
        }
    }

    @objc func refreshPeopleData() {
        peopleDataSource.retrievePeopleData()
    }
    
}


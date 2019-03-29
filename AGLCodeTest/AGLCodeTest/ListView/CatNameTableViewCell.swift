import UIKit

class CatNameTableViewCell: UITableViewCell {

    @IBOutlet weak var catNameLabel: UILabel!
    
    func configureWithCatName(catName:String) {
        self.catNameLabel.text = catName
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func clearCell() {
        self.catNameLabel.text = nil
    }
    
}

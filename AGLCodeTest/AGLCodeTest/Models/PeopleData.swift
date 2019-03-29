import Foundation

class PeopleData {
    static let shared = PeopleData()
    
    public var data: [PeopleViewModel] = []
    
    public func updateData(people: People) {
        var maleOwnerCatNames: [String] = []
        var femaleOwnerCatNames: [String] = []
        
        for petOwner in people {
            if let pets = petOwner.pets {
                let catNames = pets.filter {$0.type == PetType.cat}.compactMap({return $0.name})
                if petOwner.gender == Gender.Male {
                    maleOwnerCatNames.append(contentsOf: catNames)
                } else {
                    femaleOwnerCatNames.append(contentsOf: catNames)
                }
            }
        }
        let catsWithMaleOwners: PeopleViewModel = PeopleViewModel(names: maleOwnerCatNames.sorted(by: { $0 < $1 }), ownerGender: Gender.Male)
        let catsWithFeMaleOwners: PeopleViewModel = PeopleViewModel(names: femaleOwnerCatNames.sorted(by: { $0 < $1 }), ownerGender: Gender.Female)
        data.append(catsWithMaleOwners)
        data.append(catsWithFeMaleOwners)
    }
}




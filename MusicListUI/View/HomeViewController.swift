import UIKit

final class HomeViewController: ArtistBaseViewController {    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.artistRetrieveList(self)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
//    func retrieveArtistListHome() {
//        if let savedData = UserDefaults.standard.data(forKey: "ArtistList") {
//            let decoder = JSONDecoder()
//            if let decodedResults = try? decoder.decode([ViewModel].self, from: savedData) {
//                artistViewModels = decodedResults
//            } else {
//                print("Failed to decode results")
//            }
//        }
//    }
}


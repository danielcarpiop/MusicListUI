import UIKit

final class HomeViewController: ArtistBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDefaultsChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveArtistList()
    }
    
    @objc private func handleUserDefaultsChange() {
        retrieveArtistList()
    }
    
    func retrieveArtistList() {
        if let savedData = UserDefaults.standard.data(forKey: "ArtistList") {
            let decoder = JSONDecoder()
            if let decodedResults = try? decoder.decode([ViewModel].self, from: savedData) {
                artistViewModels = decodedResults
            } else {
                print("Failed to decode results")
            }
        }
    }
}


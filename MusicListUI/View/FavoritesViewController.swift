import UIKit

final class FavoritesViewController: ArtistBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserDefaultsChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.retrieveArtistList()
    }
    
    @objc private func handleUserDefaultsChange() {
        self.retrieveArtistList()
    }
    
    func retrieveArtistList() {
        if let savedData = UserDefaults.standard.data(forKey: "ArtistList") {
            let decoder = JSONDecoder()
            if let decodedResults = try? decoder.decode([ViewModel].self, from: savedData) {
                passDataToBase(viewModels: decodedResults)
            } else {
                print("Failed to decode results")
            }
        }
    }
    
    private func passDataToBase(viewModels: [ViewModel]) {
        let filteredModel = Set(viewModels)
        if let favoriteIDs = UserDefaults.standard.array(forKey: "SongID") as? [String] {
            artistViewModels = filteredModel.filter { favoriteIDs.contains($0.id) }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

import UIKit

final class FavoritesViewController: ArtistBaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.artistRetrieveList(self)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

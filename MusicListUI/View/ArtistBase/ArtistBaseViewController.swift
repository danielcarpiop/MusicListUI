import UIKit

class ArtistBaseViewController: UIViewController {
    let tableView = UITableView()
    let headerTable = HeaderInfoView()
    var artistViewModels: [ViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArtistGlobalInfoCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.purple
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(headerTable)
        headerTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerTable.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ArtistBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ArtistGlobalInfoCell else {
            fatalError("Unable to dequeue ArtistGlobalInfoCell")
        }
        let viewModel = artistViewModels[indexPath.row]
        cell.configure(title: viewModel.name, subtitle: viewModel.releaseDate, imgURL: viewModel.imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedViewModel = artistViewModels[indexPath.row]
        let detailViewController = ArtistDetailIViewController(viewModel: selectedViewModel, viewControllerCaller: self)
        detailViewController.modalPresentationStyle = .overFullScreen
        detailViewController.modalTransitionStyle = .crossDissolve
        detailViewController.delegate = self
        present(detailViewController, animated: false)
    }
}

extension ArtistBaseViewController: ArtistDetailDelegate {
    func artistDetailReload(_ viewController: ArtistDetailIViewController, viewControllerCaller: UIViewController) {
        artistRetrieveList(viewControllerCaller)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func artistRetrieveList(_ from: UIViewController) {
        switch from {
        case is HomeViewController:
            artistViewModels = LocalStorage.shared.retrieve(forKey: "ArtistList", as: [ViewModel].self) ?? []
        case is FavoritesViewController:
            artistViewModels = LocalStorage.shared.retrieve(forKey: "FavoritesList", as: [ViewModel].self) ?? []
        default:
            break
        }
    }
    
//    func retrieveArtistList(forKey key: String) {
//        if let savedData = UserDefaults.standard.data(forKey: "ArtistList") {
//            let decoder = JSONDecoder()
//            if let decodedResults = try? decoder.decode([ViewModel].self, from: savedData) {
//                artistViewModels = decodedResults
//            } else {
//                print("Failed to decode results")
//            }
//        }
//    }
    
//    private func passDataToBase(viewModels: [ViewModel]) {
//        let filteredModel = Set(viewModels)
//        if let favoriteIDs = UserDefaults.standard.array(forKey: "SongID") as? [String] {
//            artistViewModels = filteredModel.filter { favoriteIDs.contains($0.id) }
//        }
//    }
}

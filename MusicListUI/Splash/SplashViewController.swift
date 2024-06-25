import UIKit

final class SplashViewController: UIViewController {
    private let splashController = SplashPresenter()
    
    private lazy var viewContainer: UIImageView = {
        let image = UIImageView()
        image.image = .itunesLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSplash()
        splashController.getArtistList()
    }
    
    private func prepareSplash() {
        view.backgroundColor = .white
        view.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.widthAnchor.constraint(equalToConstant: 150),
            viewContainer.heightAnchor.constraint(equalToConstant: 150),
            viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

import UIKit

protocol SplashPresenterProtocol: AnyObject {
    func getArtistList()
}

final class SplashPresenter: SplashPresenterProtocol {
    private let useCase = ArtistListUseCase(service: ArtistListApi())
    
    func getArtistList() {
        Task {
            await fetchArtistList()
        }
    }
    
    private func fetchArtistList() async {
        do {
            async let artistListSE = useCase.getList(countryCode: .SE)
            async let artistListUS = useCase.getList(countryCode: .US)
            async let artistListCL = useCase.getList(countryCode: .CL)
            
            let (resultSE, resultUS, resultCL) = try await (artistListSE, artistListUS, artistListCL)
            
            let results = [resultSE, resultUS, resultCL].flatMap { $0 }
            
            let encoder = JSONEncoder()
                if let encodedData = try? encoder.encode(results) {
                    UserDefaults.standard.set(encodedData, forKey: "ArtistList")
                } else {
                    print("Failed to encode results")
                }
            
            handleSuccess(results: results)
            
        } catch {
            handleError(error: error)
        }
    }
    
    
    private func handleSuccess(results: [ViewModel]) {
        DispatchQueue.main.async {
            let mainViewController = TabBarController()
            
            let newNavigationController = UINavigationController(rootViewController: mainViewController)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = newNavigationController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    private func handleError(error: Error){
        print("Failed to fetch artist lists: \(error)")
    }
    
    
}

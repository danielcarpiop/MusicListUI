import Foundation

enum RequestError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
}

protocol ArtistListService {
    func getList(countryCode: CountryCode) async throws -> Model
}

final class ArtistListApi: ArtistListService {
    private let urlFactory = URLFactory()
    private let urlSession = URLSession.shared
    
    func getList(countryCode: CountryCode) async throws -> Model {
        let url = try urlFactory.generateURL(with: countryCode)
        
        let (data, response) = try await urlSession.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RequestError.invalidResponse
        }
        
        let model = try JSONDecoder().decode(Model.self, from: data)
        return model
    }
}

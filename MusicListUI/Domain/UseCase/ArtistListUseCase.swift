import Foundation

final class ArtistListUseCase {
    private let service: ArtistListService
    
    init(service: ArtistListService) {
        self.service = service
    }
    
    func getList(countryCode: CountryCode) async throws -> [ViewModel] {
        let model = try await service.getList(countryCode: countryCode)
        let viewModels = mapModelToViewModel(model: model)
        return viewModels
    }
}

private func mapModelToViewModel(model: Model) -> [ViewModel] {
    return model.feed.entry.map {
        return ViewModel(
            name: $0.title.label,
            releaseDate: $0.imReleaseDate?.attributes.label ?? "",
            rights: $0.rights.label,
            imageUrl: $0.imImage.filter { $0.attributes.height == "170"}[0].label,
            audioUrl: $0.link.filter { $0.attributes.href.hasSuffix(".m4a") }[0].attributes.href,
            id: $0.id.attributes.imId
        )
    }
}

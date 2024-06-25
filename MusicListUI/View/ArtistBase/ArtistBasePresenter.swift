//
//  ArtistBasePresenter.swift
//  MusicListUI
//
//  Created by Daniel Carpio on 25-06-24.
//

import Foundation

protocol ArtistBasePresenterProtocol: AnyObject {
    func retrieveArtistList() -> [ViewModel]
}

class ArtistBasePresenter: ArtistBasePresenterProtocol {
    func retrieveArtistList() -> [ViewModel] {
        if let savedData = UserDefaults.standard.data(forKey: "ArtistList") {
            let decoder = JSONDecoder()
            if let decodedResults = try? decoder.decode([ViewModel].self, from: savedData) {
                return decodedResults
            } else {
                print("Failed to decode results")
            }
        }
        return []
    }
}

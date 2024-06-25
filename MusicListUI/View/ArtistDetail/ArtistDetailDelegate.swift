//
//  ArtistDetailDelegate.swift
//  MusicListUI
//
//  Created by Daniel Carpio on 25-06-24.
//

import UIKit

protocol ArtistDetailDelegate: AnyObject {
    func artistDetailReload(_ viewController: ArtistDetailIViewController, viewControllerCaller: UIViewController)
}

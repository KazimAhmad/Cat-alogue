//
//  Session.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation

class Constants {
    static var imageAppLogo = "logo"
    static var imagePaw = "paw"
    static var imageBackground = "background"
}

enum ViewState {
    case loading
    case info
    case error(Error)
    case search
}

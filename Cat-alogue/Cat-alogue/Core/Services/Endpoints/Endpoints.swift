//
//  Session.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//

import Foundation

//MARK: the end points for app as enum to play around with the different version numbers and base urls

var vesion = "v1/" // or some cases a version number as v1, v2 etc

public enum Endpoints {
    case images
    
    var path: String {
        switch self {
            case .images:
            return baseURLString + "images/search"
        }
    }
}

//MARK: can define according to the environments
let baseURLString = "https://api.thecatapi.com/"


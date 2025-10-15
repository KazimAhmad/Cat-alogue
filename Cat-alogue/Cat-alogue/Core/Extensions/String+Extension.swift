//
//  Session.swift
//  Cat-alogue
//
//  Created by Kazim Ahmad on 15/10/2025.
//


import Foundation

extension String {
    var isEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    var addingPercentEncodingForURLFormValue: String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._* ")
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)?.replacingOccurrences(of: " ", with: "+")
    }
}

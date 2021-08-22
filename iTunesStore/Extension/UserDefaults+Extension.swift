//
//  UserDefaults+Extension.swift
//  iTunesStore
//
//  Created by John Ellie Go on 8/22/21.
//

import Foundation

enum UserDefaultsKey: String {
    case didOpenDetailView
}

extension UserDefaults {
    func didOpenDetailView(value: Bool) {
        setValue(value, forKey: UserDefaultsKey.didOpenDetailView.rawValue)
    }
    
    var didOpenDetailView: Bool {
        bool(forKey: UserDefaultsKey.didOpenDetailView.rawValue)
    }
}

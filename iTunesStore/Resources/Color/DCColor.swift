//
//  DCColor.swift
//  iTunesStore
//
//  Created by John Ellie Go on 21/8/21.
//

import UIKit
import SwiftUI

/// Add a color to the DCColors with a matching name to the enum case.
enum DCColor: String, CaseIterable {
    case smallListContentFootnote               //0x3c3c43 0.6
    case mediumListContentFootnote              //0x3c3c43 0.6
    case darkestText                            //0x000000 1.0

    var color: Color {
        Color(rawValue)
    }
}

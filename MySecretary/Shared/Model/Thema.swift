//
//  Thema.swift
//  MySecretary
//
//  Created by jang gukjin on 2022/01/10.
//

import Foundation
import SwiftUI
import UIKit

enum Thema {
    case system
    case white
    case black
    
    func getRawValue() -> ColorSet {
        switch self {
        case .system:
            return ColorSet(background: Color(UIColor.systemBackground), font: Color(UIColor.label))
        case .white:
            return ColorSet(background: .white, font: .black)
        case .black:
            return ColorSet(background: .black, font: .white)
        }
    }
}

//
//  CustomFont.swift
//  Flazhed
//
//  Created by IOS22 on 31/12/20.
//

import Foundation
import UIKit

extension UIFont {
    enum CustomFont: String {
        
        case bold = "Averta-Bold"
        case regular = "Averta-Regular"
     
        case Inter_Regular = "Inter-Regular"
        case Inter_Thin = "Inter-Thin"
        case Inter_Bold = "Inter-Bold"
        case Inter_SemiBold = "Inter-SemiBold"
        
        case Roboto_Regular = "Roboto-Regular"
        case Roboto_Medium = "Roboto-Medium"
        case Roboto_Bold = "Roboto-Bold"


        func fontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: rawValue, size: size)!
        }
    }
}


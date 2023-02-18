//
//  UIStoryboard+Extension.swift
//  Flazhed
//
//  Created by IOS22 on 19/01/21.
//
import Foundation
import UIKit

enum Storyboard : String {
    case Main
    case Tabbar
    
}

extension UIStoryboard {
    class func storyboard(storyboard : Storyboard ,bundle : Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
}

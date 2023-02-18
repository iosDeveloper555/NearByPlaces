//
//  HighlightedButton.swift
//  NearByPlaces
//
//  Created by Amarendra on 13/01/23.
//

import Foundation
import UIKit

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .clear : APPCOLOR
        }
    }
}

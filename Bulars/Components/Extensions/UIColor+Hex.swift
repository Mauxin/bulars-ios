//
//  UIColor+Hex.swift
//  Bulars
//
//  Created by Murilo Dias on 21/09/18.
//  Copyright © 2018 Murilo Dias. All rights reserved.
//

import UIKit

class HexColor {
    
    static func from(hexValue:UInt32) -> UIColor {
        let red = CGFloat((hexValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hexValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hexValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}

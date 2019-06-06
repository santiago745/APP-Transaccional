//
//  ButtonPrimary.swift
//  AmwayFollowApp
//
//  Created by periferia on 2/8/19.
//  Copyright © 2019 periferia. All rights reserved.
//

import UIKit

class ButtonPrimary: UIButton {
    
    override func draw(_ rect: CGRect) {
        // Drawing code

        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size16))
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.backgroundColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
        //Radius
        self.layer.cornerRadius = self.frame.height / 2
        //Padding
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        //margin
        
    }
}
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

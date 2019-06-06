//
//  ButtonSecondary.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/27/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ButtonSecondary: UIButton {
    
   override func draw(_ rect: CGRect) {
        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size16))
        self.setTitleColor(UIColor(hex: "\(AFAFonts.greenskandia)ff"), for: .normal)
    
        self.layer.backgroundColor = (UIColor.white).cgColor
        //Radius
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor

        //Padding
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        //margin
    }
}

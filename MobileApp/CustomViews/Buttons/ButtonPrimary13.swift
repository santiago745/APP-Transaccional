//
//  ButtonPrimary13.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/31/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ButtonPrimary13: UIButton {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size13))
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.backgroundColor =  UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
        //Radius
        self.layer.cornerRadius = self.frame.height / 2
        //Padding
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        //margin
        
    }

}

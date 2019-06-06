//
//  ButtonFinished.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/28/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ButtonFinished: UIButton {

    override func draw(_ rect: CGRect) {
        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size40))
        self.setTitleColor(UIColor(hex: "\(AFAFonts.greenskandia)ff"), for: .normal)
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
        
    }

}

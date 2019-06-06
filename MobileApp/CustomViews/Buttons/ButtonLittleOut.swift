//
//  LittleButtonOut.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/27/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ButtonLittleOut: UIButton {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size12))
        self.setTitleColor(UIColor(hex: "\(AFAFonts.grayskandia)ff"), for: .normal)
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
       
        
    }

}

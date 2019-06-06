//
//  ParragraphFontGreen10.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/27/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ParragraphFontGreen10: UILabel {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size10))
        self.textColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")
        
    }
}

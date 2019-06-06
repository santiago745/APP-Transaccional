//
//  SubtitleFont16.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/29/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class SubtitleFont16: UILabel {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size16))
        self.textColor = UIColor(hex: "\(AFAFonts.grayskandia)ff")
        
    }

}

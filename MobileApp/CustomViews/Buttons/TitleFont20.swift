//
//  TitleFont20.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/30/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class TitleFont20: UILabel {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleBold)", size: CGFloat(AFAFonts.size20))
        self.textColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")
        
    }

}

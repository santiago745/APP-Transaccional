//
//  ParragraphFont14.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/31/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class ParragraphFont14: UILabel {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size14))
        self.textColor = UIColor(hex: "\(AFAFonts.grayskandia)ff")
        
    }
    
}

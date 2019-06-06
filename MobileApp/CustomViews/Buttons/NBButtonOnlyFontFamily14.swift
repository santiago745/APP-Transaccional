//
//  NBButtonOnlyFontFamily14.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/29/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class NBButtonOnlyFontFamily14: UIButton {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.titleLabel?.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size14))
        self.layoutMargins.left = 2
        self.layoutMargins.right = 2
    }
}

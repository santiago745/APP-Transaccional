//
//  TextViewOnlyFontFamily12.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/28/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class TextViewOnlyFontFamily12: UITextView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size12))
        
        
    }

}

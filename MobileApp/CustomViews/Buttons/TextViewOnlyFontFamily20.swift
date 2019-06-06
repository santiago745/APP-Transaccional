//
//  TextViewOnlyFontFamily20.swift
//  MobileApp
//
//  Created by PeriferiaIT on 5/29/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import UIKit

class TextViewOnlyFontFamily20: UITextView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        self.font = UIFont(name: "\(AFAFonts.firstFamily)-\(AFAFonts.styleRegular)", size: CGFloat(AFAFonts.size20))
        
        
    }

}

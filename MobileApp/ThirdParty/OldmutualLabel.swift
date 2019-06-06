//
//  OldmutualLabel.swift
//  MobileApp
//
//  Created by Periferia on 29/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
class OldmutualLabel: UILabel
{
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = (UIColor.green).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
    }
    func inicializar(controller: UIViewController)
    {
        
    }
}

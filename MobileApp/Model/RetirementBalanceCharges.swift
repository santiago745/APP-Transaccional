//
//  RetirementBalanceCharges.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementBalanceCharges: NSObject {
    
    var Charges = ""
    
    
    init (dic:NSDictionary)
    {
        Charges = ValueJsonString(dic: dic, key: "Charges")
        
    }
    
}

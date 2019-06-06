//
//  RetirementBalanceChargesObject.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementBalanceChargesObject: NSObject {
    
    var Description = ""
    var Key:Int?
    var Value = 0.0
    
    
    
    init (dic:NSDictionary)
    {
        Description = ValueJsonString(dic: dic, key: "Description")
        Key = ValueJsonInt(dic: dic, key: "Key")
        Value = ValueJsonDouble(dic: dic, key: "Value")
        
    }
    
}

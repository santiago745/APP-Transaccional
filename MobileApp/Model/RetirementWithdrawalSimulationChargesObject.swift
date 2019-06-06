//
//  RetirementWithdrawalsObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementWithdrawalSimulationChargesObject: NSObject {
    
    var Name = ""
    var Value = 0.0
    
    
    
    init (dic:NSDictionary)
    {
        
        Name = ValueJsonString(dic: dic, key: "Name")
        Value = ValueJsonDouble(dic: dic, key: "Value")
            
    }
}

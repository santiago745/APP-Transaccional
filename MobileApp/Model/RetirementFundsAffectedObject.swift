//
//  RetirementFundsAffectedObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementFundsAffectedObject: NSObject {
    
    var Id = ""
    var Name = ""
    var ShortName = ""
    var Balance = ""
    var CanSell = ""
    var UnitBalance = ""
    var UnitValue = ""
    var Percentage = ""
    
    
    init (dic:NSDictionary)
    {
        Id = ValueJsonString(dic: dic, key: "")
        Name = ValueJsonString(dic: dic, key: "Name")
        ShortName = ValueJsonString(dic: dic, key: "ShortName")
        Balance = ValueJsonString(dic: dic, key: "Balance")
        CanSell = ValueJsonString(dic: dic, key: "CanSell")
        UnitBalance = ValueJsonString(dic: dic, key: "UnitBalance")
        UnitValue = ValueJsonString(dic: dic, key: "UnitValue")
        Percentage = ValueJsonString(dic: dic, key: "Percentage")
        
    }
    
}

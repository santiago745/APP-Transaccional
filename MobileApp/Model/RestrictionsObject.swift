//
//  RestrictionsObject.swift
//  MobileApp
//
//  Created by David Polania on 12/4/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RestrictionsObject{
    var ChannelID = 0
    var IsConfigured = false
    var Withdrawls = 0
    var ValueRestrictions = [ValueRestrictionsObject]()
    var RangeRestrictions = ""
    
    init(Data:NSDictionary) {
        self.ChannelID = ValueJsonInt(dic: Data, key: "ChannelId")
        self.IsConfigured = ValueJsonBool(dic: Data, key: "IsConfigured")
        self.Withdrawls = ValueJsonInt(dic: Data, key: "Withdrawals")
        if let DataRestrictions = ValueJsonArray(dic: Data, key: "ValueRestrictions"){
            for  Data  in DataRestrictions {
                ValueRestrictions.append(ValueRestrictionsObject(Data:Data as! NSDictionary))
            }
        }
        self.RangeRestrictions = ValueJsonString(dic: Data, key: "RangeRestrictions")
    }
}

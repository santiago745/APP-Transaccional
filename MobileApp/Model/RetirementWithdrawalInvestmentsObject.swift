//
//  RetirementWithdrawalsObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementWithdrawalInvestmentsObject: NSObject {
    
    var BenefitMessage = 0
    var BenefitRemainingTime = ""
    var BenefitValue = 0
    var EffectiveDate = ""
    var OriginalCapital = 0
    var Penalty = 0
    var Retention = 0
    var Return = 0.0
    var TaxRemainingTime = ""
    var TaxValue = 0
    var WithdrewCapital = 0.0
    
    
    
    init (dic:NSDictionary)
    {
        
        BenefitMessage = ValueJsonInt(dic: dic, key: "BenefitMessage")
        BenefitRemainingTime = ValueJsonString(dic: dic, key: "BenefitRemainingTime")
        BenefitValue = ValueJsonInt(dic: dic, key: "BenefitValue")
        EffectiveDate = ValueJsonString(dic: dic, key: "EffectiveDate")
        OriginalCapital = ValueJsonInt(dic: dic, key: "OriginalCapital")
        Penalty = ValueJsonInt(dic: dic, key: "Penalty")
        Retention = ValueJsonInt(dic: dic, key: "Retention")
        TaxRemainingTime = ValueJsonString(dic: dic, key: "TaxRemainingTime")
        TaxValue = ValueJsonInt(dic: dic, key: "TaxValue")
        WithdrewCapital = ValueJsonDouble(dic: dic, key: "WithdrewCapital")
        
    }
}

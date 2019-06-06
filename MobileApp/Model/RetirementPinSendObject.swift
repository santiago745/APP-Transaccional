//
//  RetirementWithdrawalsObject.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementPinSendObject: NSObject {
    
    var AdditionalInfo = ""
    var ConfirmationNumber = ""
    var ProccessDate = ""
    var Success = false
    var TransferDate = ""
    
    
    
    init (dic:NSDictionary)
    {
        
        AdditionalInfo = ValueJsonString(dic: dic, key: "AdditionalInfo")
        ConfirmationNumber = ValueJsonString(dic: dic, key: "ConfirmationNumber")
        ProccessDate = ValueJsonString(dic: dic, key: "ProccessDate")
        Success = ValueJsonBool(dic: dic, key: "Success")
        TransferDate = ValueJsonString(dic: dic, key: "TransferDate")
            
        }
        
        
}

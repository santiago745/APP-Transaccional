//
//  RestaurePasswordPinResponseObject.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 27/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
let StringComparacionPin = "Successful"
public class RestaurePasswordPinResponseObject
{
    var Response = false
    var Description = ""
    
    
    init (dic:NSDictionary)
    {
        Response = ValueJsonBool(dic: dic, key: "Response")
        Description = ValueJsonString(dic: dic, key: "Description")
        
    }
}


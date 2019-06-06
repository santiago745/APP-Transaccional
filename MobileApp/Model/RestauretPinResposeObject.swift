//
//  RestauretPinResposeObject.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 27/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
let StringComparacion = "Successful"
public class RestauretPinResposeObject
{
    var PinResult = ""
    var Description = ""
    var Estado = ""
    
    
    init (dic:NSDictionary)
    {
        PinResult = ValueJsonString(dic: dic, key: "PinResult")
        Description = ValueJsonString(dic: dic, key: "Description")
 
    }
}

//
//  FieldsObject.swift
//  agregarlistas
//
//  Created by Periferia on 19/11/17.
//  Copyright © 2017 PeriferiaxzvNextU. All rights reserved.
//

import Foundation
import UIKit

class RetirementFieldsObject:NSObject
{
    var Key = ""
    var Caption = ""
    var Value = ""
    var DataType = 0
    
    init(dic: NSDictionary)
    {
        Key = ValueJsonString(dic: dic, key: "Key")
        Caption = ValueJsonString(dic: dic, key: "Caption")
        Value = ValueJsonString(dic: dic, key: "Value")
        DataType = ValueJsonInt(dic: dic, key: "DataType")
    }
    
    
}


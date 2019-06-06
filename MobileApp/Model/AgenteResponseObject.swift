//
//  AgenteResponseObject.swift
//  MobileApp
//
//  Created by Pedro Daza on 30/05/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var LOCALARRAYAGENTES = [AgenteResponseObject]()
var LOCALCEDULA = ""
var LOCALTIPOCEDULA = ""
public class AgenteResponseObject: NSObject
{
    var Name = ""
    var Email = ""
    var CellPhone = ""
    
    var Phone = ""
    var AgencyName = ""
    var AgencyAddress = ""
    
    var Photo = ""

    
    
    init (dic:NSDictionary)
    {
        Name = ValueJsonString(dic: dic, key: "Name")
        Email = ValueJsonString(dic: dic, key: "Email")
        CellPhone = ValueJsonString(dic: dic, key: "CellPhone")
        
        Phone = ValueJsonString(dic: dic, key: "Phone")
        AgencyName = ValueJsonString(dic: dic, key: "AgencyName")
        AgencyAddress = ValueJsonString(dic: dic, key: "AgencyAddress")
        
        Photo = ValueJsonString(dic: dic, key: "Photo")
        
    }
}


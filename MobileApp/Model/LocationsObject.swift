//
//  LocationsObject.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 14/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import UIKit

var LOCATIONS = [Locations]()
class Locations :NSObject
{
    var City = ""
    var Address = ""
    var Phone = ""
    var Pbx = ""
    var Fax = ""
    var Schedule = ""
    var Coordinate = ""
    
    
    init (dic:NSDictionary)
    {
        City = ValueJsonString(dic: dic, key: "City")
        Address = ValueJsonString(dic: dic, key: "Address")
        Phone = ValueJsonString(dic: dic, key: "Phone")
        Pbx = ValueJsonString(dic: dic, key: "Pbx")
        Fax = ValueJsonString(dic: dic, key: "Fax")
        Schedule = ValueJsonString(dic: dic, key: "Schedule")
        Coordinate = ValueJsonString(dic: dic, key: "Coordinate")
        
    }
    
}

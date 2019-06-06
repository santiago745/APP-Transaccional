//
//  ValueRestrictionsObject.swift
//  MobileApp
//
//  Created by David Polania on 12/4/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
class ValueRestrictionsObject {
    var Id = 0
    var Name = ""
    var Value = 0.0
    
    init(Data:NSDictionary) {
        self.Id = ValueJsonInt(dic: Data, key: "Id")
        self.Name = ValueJsonString(dic: Data, key: "Name")
        self.Value = ValueJsonDouble(dic: Data, key: "Value")
    }
    init(){
        //Vacion
    }
}

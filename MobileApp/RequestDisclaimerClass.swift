//
//  RequestDisclaimerClass.swift
//  MobileApp
//
//  Created by David Polania on 2/15/19.
//  Copyright © 2019 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RequestDisclaimerClass: NSObject{
    class func requestDisclaimerClass(controller:UIViewController,Ok:@escaping ((String)->Void))
    {
        
        let ws = Ws()
        ws.getString(view: controller, Ok: {Res in
            Ok(Res)
        }, Error: { err in
            
        },
           todoEndpointt: BASEURL + "/Messages?key=DisclaimerAppMobile17")
        
    }
}

//
//  PostRestrictionsClass.swift
//  MobileApp
//
//  Created by David Polania on 12/4/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import  UIKit

func GetRestrictionsClass(controller:UIViewController,Ok:@escaping ((RestrictionsObject) -> Void))
{
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RestrictionsObject(Data: ObjResponse)
        
        
        Ok(Tetirement)
        
    },Error: {errer in
        
        
    },
        
        todoEndpointt: BASEURL + "/Restrictions?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)"
    )
    
}


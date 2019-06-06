//
//  GetRetirementAcountClass.swift
//  MobileApp
//
//  Created by Periferia on 20/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import  UIKit

func getContenedorAcount(controller:UIViewController, contractNumber:String, productCode:String,planCode:String, Ok:@escaping ((RetirementAcountObject) -> Void))
{
    var contractnumber = contractNumber
    var productcode = productCode
    var plancode = planCode
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementAcountObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    },
       //todoEndpointt: BASEURL + "/Contracts?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)"
      todoEndpointt: BASEURL + "/BankAccounts?contractNumber=\(contractnumber)&productCode=\(productcode)&planCode=\(plancode)"
    )
}

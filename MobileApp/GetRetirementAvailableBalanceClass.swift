//
//  GetRetirementAvailableBalanceClass.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import  UIKit

func getContenedorBalance(controller:UIViewController,product : String,numcontracts:String, Ok:@escaping ((RetirementAvailableBalanceObject) -> Void))
{
    let product = product
    let numcontracts = numcontracts
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementAvailableBalanceObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }, //todoEndpointt: BASEURL + "/Contracts?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)")
        //todoEndpointt:"https://190.216.128.52/OM.MobileApi.Public/api/Withdrawals?docNumber=1024553465&docType=C&product=MFUND&contract=100003150636&surrenderType=0")
      todoEndpointt:BASEURL + "/Withdrawals?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&product=\(product)&contract=\(numcontracts)&surrenderType=0")
    
}

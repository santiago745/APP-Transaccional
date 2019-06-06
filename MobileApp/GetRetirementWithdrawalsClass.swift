//
//  GetRetirementWithdrawalsClass.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//


import Foundation
import  UIKit

func getContenedorWithdrawals(controller:UIViewController,product : String,numcontracts:String,available:Int,withdrawalAmount:Double,planProduct:String,isFullSurrender:Int, Ok:@escaping ((RetirementWithdrawalsObject) -> Void))
{
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementWithdrawalsObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }, //todoEndpointt: BASEURL + "/Contracts?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)")
       todoEndpointt: BASEURL + "/Withdrawals?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&available=\(available)&withdrawalAmount=\(withdrawalAmount)&contract=\(numcontracts)&product=\(product)&planProduct=\(planProduct)&surrenderType=\(isFullSurrender)")
        //todoEndpointt:BASEURL + "/Withdrawals?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&product=\(product)&contract=\(numcontracts)&surrenderType=0")
    
}

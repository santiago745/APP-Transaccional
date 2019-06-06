//
//  GetRetirementWithdrawalsClass.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//


import Foundation
import  UIKit

func PostRetirementAnswerUser(controller:UIViewController,numcontracts:String,surveyAnswer:String,product:String,surveyType:String,Ok:@escaping ((RetirementAnswerUserObject) -> Void))
{
    
    
    let ParamsBody:NSDictionary = [:]
    
    let ws = Ws()
    ws.postUrlParamsNoBody(view: controller, Ok: {ObjResponse in
        
        
        let Tetirement = RetirementAnswerUserObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
        
    },Error: {errer in
  
        
    },
      //      todoEndpointt: BASEURL + "api/Withdrawals?surveyType=\(surveyType)&surveyAnswer=\(surveyAnswer)&docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&product=\(product)&contract=\(numcontracts)&channelNumber=1.2.3.4",
        
        todoEndpointt: BASEURL + "/Withdrawals?surveyType=\(surveyType)&surveyAnswer=\(surveyAnswer)&docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&product=\(product)&contract=\(numcontracts)&channelNumber=4",
        
        //    todoEndpointt: BASEURL + "/Withdrawals?docNumber=\(LOCALCEDULA)&docType=\(LOCALTIPOCEDULA)&available=\(available)&withdrawalAmount=\(withdrawalAmount)&contract=\(numcontracts)&product=\(product)&planProduct=\(planProduct)&surrenderType=\(isFullSurrender)",
        
        params: ParamsBody
    )
    
}

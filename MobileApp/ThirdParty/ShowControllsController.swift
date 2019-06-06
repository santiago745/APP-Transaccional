//
//  ShowControllsController.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 31/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

public class ShowControllsController : NSObject
{
    func showFuction(view: UIViewController) -> SpinnerController
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        view.navigationController?.present(vcspinner, animated: true)
        
        return vcspinner;
    }
    
    func hideFuction(view: SpinnerController)
    {
        if view != nil
        {

            do {
                try view.hideSpinner()
                // use anyObj here
            } catch {
                //Error( "\(error)")
                return
                    print("json error: \(error)")
            }

        }
    }
    
    
    func SetGuiaDeCanalesController(view: UIViewController)
    {
        AGENTESCONTAINERVIEW = view 
    }
}

//
//  CallControllers.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 30/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

public class CallControllers: NSObject
{
    func PushCertificacionOffline(view: UIViewController)
    {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CertificacionesOfflineController") as! CertificacionesOfflineController

        view.navigationController?.pushViewController(vc, animated: true)
    }
    
    func PushCertificacionOfflineIpad(view: UIViewController)
    {
        let storyboard = UIStoryboard(name: "AuthenticationIpad", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CertificacionesOfflineController") as! CertificacionesOfflineController
        
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
}

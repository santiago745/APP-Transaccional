//
//  ChangePasswordController.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 4/04/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift



class ChangePasswordControllerWhithPin : UIViewController
{
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbTextTitle: UITextView!
    
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var btAceptar: UIButton!
    
    
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        super.viewDidLoad()
        lbTitle.text = "Cambio de Clave"
        lbTextTitle.text = "Apreciado usuario por favor ingrese su nueva contraseña, recuerde que debe tener al menos 8 caracteres combinando mayúsculas y minúsculas, debe ser alfanumérico incluyendo caracteres especiales y no debe tener caracteres repetidos continuos (ej: aaa, 111)."
        
        IQKeyboardManager.sharedManager().enable = true
    
       // self.navigationItem.title = "Restablecer contraseña";
        self.navigationItem.title = "Restablecer Contraseña";
    
   
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RestauretPaswordPinController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func  dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.etPassword.resignFirstResponder()
        self.etConfirmPassword.resignFirstResponder()
        self.lbTitle.resignFirstResponder()
        IQKeyboardManager.sharedManager().enable = false
        dismissKeyboard()
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func triCancel(_ sender: UIButton) {
        
        
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangePasswordControllerWhithPin.dismissKeyboard))
        
        dismiss(animated: true, completion: nil)
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func triAceptar(_ sender: UIButton) {
        

        if (etPassword!.text! != "" && etConfirmPassword!.text! != "")
        {
            if(etPassword!.text! == etConfirmPassword!.text!)
            {
                let res = RequestSwiftObjC()
                res.POSTForgetPasswordPin(view: self, Password: etPassword!, DeviceNumber: appUniqueIdentifier())
            }
            else
            {
                ShowAlertError(view: self, Mensaje: "Apreciado cliente Asegúrese que las contraseñas ingresadas coincidan e inténtelo de nuevo")
            }
        }
        else
        {
            ShowAlertError(view: self, Mensaje: "Debe llenar todos los campos")
        }
    }
    
    func appUniqueIdentifier() -> String {
        
        var appUniqueIdentifier = "";
        if appUniqueIdentifier == ""{
            var defaults = UserDefaults.standard
            if !(defaults.object(forKey: "ApplicationUniqueIdentifier") != nil) {
                appUniqueIdentifier = UUID().uuidString
                defaults.set(appUniqueIdentifier, forKey: "ApplicationUniqueIdentifier")
                UserDefaults.standard.synchronize()
            }
            else {
                appUniqueIdentifier = defaults.object(forKey: "ApplicationUniqueIdentifier") as! String
            }
        }
        return appUniqueIdentifier
    }
    

}

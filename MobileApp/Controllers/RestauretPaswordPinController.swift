//
//  RestauretPaswordPinController.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 23/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
public class RestauretPaswordPinController : UIViewController, UITextFieldDelegate
    
    
{
    @IBOutlet weak var btPedirPin: UIButton!
    @IBOutlet weak var btContinuar: UIButton!
    @IBOutlet weak var etPin: UITextField!
    
    var rest:RestauretPinResposeObject?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "hola", style: .plain, target: nil, action: nil)
        
       // navigationItem.title = nil
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RestauretPaswordPinController.dismissKeyboard))
        
        etPin.delegate = self
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        btPedirPin.layer.cornerRadius = 5
        btPedirPin.layer.borderWidth = 1
        view.addGestureRecognizer(tap)
        
        etPin.addTarget(self, action:#selector(RestauretPaswordPinController.yourWeightValueChanged), for:.editingChanged);
        

        
        //let backItem = UIBarButtonItem()
        //backItem.title = "Something Else"
        //navigationItem.backBarButtonItem = backItem
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
  
    
    
    override public func viewDidAppear(_ animated: Bool) {
        if rest != nil
        {
            if rest!.PinResult != StringComparacion
            {
            var refreshAlert = UIAlertController(title: "Informacion", message: rest!.Description, preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (action: UIAlertAction!) in
                
                
                 _ = self.navigationController?.popViewController(animated: true)
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func triPedirPin(_ sender: UIButton) {
        
        RequestSwiftObjC().GETForgetPasswordPinConMensaje(view: self)
        
        
    }
    
    @IBAction func triContinuar(_ sender: UIButton) {
        
        let resquest = RequestSwiftObjC()
        resquest.POSTForgetPasswordPin(view: self, Pin: etPin!.text!)
        
        view.endEditing(true)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true

    }
    
    @IBAction func triChangeValuePin(_ sender: UITextField) {
        
        if (etPin.text!.characters.count) >= 5
        {
            let resquest = RequestSwiftObjC()
            resquest.POSTForgetPasswordPin(view: self, Pin: etPin!.text!)

            etPin.text = ""
            view.endEditing(true)
        }

    }
    
    @objc func yourWeightValueChanged()
    {
        if (etPin.text!.characters.count) >= 6
        {
            let resquest = RequestSwiftObjC()
            resquest.POSTForgetPasswordPin(view: self, Pin: etPin!.text!)
            
            etPin.text = ""
            view.endEditing(true)
            
        }
    }
    
}

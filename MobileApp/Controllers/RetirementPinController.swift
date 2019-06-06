//
//  RetirementPinController.swift
//  MobileApp
//
//  Created by Periferia on 5/12/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var RETIREMENTPINCONTROLLER:RetirementPinController?
class RetirementPinController: UIViewController,UITextFieldDelegate
{
    //Link each UITextField
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var txNum2: UITextField!
    
    @IBOutlet weak var txNum3: UITextField!
    
    @IBOutlet weak var txNum4: UITextField!
    @IBOutlet weak var txNum5: UITextField!
    
    @IBOutlet weak var txNum6: UITextField!
    
    @IBOutlet weak var svGeneral: UIScrollView!
    
    var numPin1 = 0
    var numPin2 = 0
    var numPin3 = 0
    var numPin4 = 0
    var numPin5 = 0
    var numPin6 = 0
    var confirmationNumber = ""
    var proccessDate = ""
    var transferDate = ""
    var montoTotalRecursosPin = ""
    let defaults = UserDefaults.standard
    
    var pinTotal = ""
    
 
        override func viewDidLoad()
        {
        
            super.viewDidLoad()
            
            self.navigationItem.title = "Retiro"
            parent?.navigationItem.title = "Retiro"
            RETIREMENTPINCONTROLLER = self
            svGeneral.contentSize.height = 1000
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RetirementPinController.dismissKeyboard))
            
            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false
            
            view.addGestureRecognizer(tap)
            
            if(RETIREMENTVALUECONTROLLER?.txMonto == 0.0){
                montoTotalRecursosPin = "0"
            }else{
                
                montoTotalRecursosPin = String(RETIREMENTVALUECONTROLLER!.txMonto)
            }
            /*
            GetRetirementPIN(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
                
             /*   let alert = UIAlertController(title: "Apreciado Cliente", message: rest.PinResult, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "Solicitar Pin", style: .default)
                {
                    (action:UIAlertAction!) in
                }
                
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                */
                
            })
            */
            // Do this for each UITextField
            
            textField1.delegate = self
            txNum2.delegate = self
            txNum3.delegate = self
            txNum4.delegate = self
            txNum5.delegate = self
            txNum6.delegate = self
            
            textField1.tag = 0 //Increment accordingly
            textField1.becomeFirstResponder
            ()
            textField1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txNum2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txNum3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txNum4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txNum5.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            txNum6.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            

            
        }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        
        textField1.resignFirstResponder()
        if (textField == textField1){
            if(textField1.text != ""){
            txNum2.becomeFirstResponder()
            }
        }
        else if (textField == txNum2){
            if(txNum2.text != ""){
            txNum3.becomeFirstResponder()
                }
        }
        else if (textField == txNum3){
                if(txNum3.text != ""){
            txNum4.becomeFirstResponder()
                    }
        }
        else if (textField == txNum4){
                    if(txNum4.text != ""){
            txNum5.becomeFirstResponder()
                        }
        }
        else if (textField == txNum5){
                        if(txNum5.text != ""){
            txNum6.becomeFirstResponder()
                        }
        }
        else if (textField == txNum6){
                           
   //         textField1.becomeFirstResponder()
        }
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        
        if (textField1.text != "" && txNum2.text != "" && txNum3.text != "" && txNum4.text != "" && txNum5.text != "" && txNum6.text != "" ){
            
        pinTotal = "\(textField1.text!)\(txNum2.text!)\(txNum3.text!)\( txNum4.text!)\(txNum5.text!)\(txNum6.text!)"
            
      //  pinTotal = "\(textField1.text)\(txNum2.text)\(numPin3)\(numPin4)\(numPin5)\(numPin6)"
            
            PostRetirementPINSend(controller: self,
                                  
            numcontracts:0,
            withdrawalType: (RETIREMENTVALUECONTROLLER?.retirementwithdrawalType)!,
            ChannelNumber:deviceID,
            UserId:LOCALCEDULA,
            CommentsBody:"TEST",
            ContractNumberBody:(RETIREMENTVALUECONTROLLER?.numeroContratoLocal)!,
            DestinationTypeBody:1,
            FlagsBody:0,
            PlanCodeBody:(RETIREMENTVALUECONTROLLER?.planCodeLocal)!,ProductCodeBody:(RETIREMENTVALUECONTROLLER?.productCodeLocal)!,
            ValueBody: montoTotalRecursosPin, AccountNumberBody:(RETIREMENTSUMMARYCONTROLLER?.bankaccountsarrayRecibir.Number)!,
            AccountTypeBody: (RETIREMENTSUMMARYCONTROLLER?.bankaccountsarrayRecibir.TypeAcount)!,
            BankIdBody: (RETIREMENTSUMMARYCONTROLLER?.bankaccountsarrayRecibir.BankId)!,
            BankNameBody: (RETIREMENTSUMMARYCONTROLLER?.bankaccountsarrayRecibir.BankName)!,
        PIN: pinTotal, Ok: {rest in
            
            
            
        
            
            if (rest.Success){
                //David Polania
                //Ajuste Bug 0003397 Mantiz
                
                let string = rest.TransferDate
                
                let dateFormatter = DateFormatter()
                let tempLocale = dateFormatter.locale
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                let date = dateFormatter.date(from: string)!
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateFormatter.locale = tempLocale
                let dateString = dateFormatter.string(from: date)
                
                //Final
                
                self.confirmationNumber = rest.ConfirmationNumber
                self.proccessDate = rest.ProccessDate
                self.transferDate = dateString
                
                self.textField1.text = ""
                self.txNum2.text = ""
                self.txNum3.text = ""
                self.txNum4.text = ""
                self.txNum5.text = ""
                self.txNum6.text = ""
                self.textField1.becomeFirstResponder()
                
                self.performSegue(withIdentifier: "GoSolicitudExitosa", sender: self)
                var NoRetiro = self.defaults.integer(forKey: "MesEnCurso") + 1
                self.defaults.set(NoRetiro, forKey: "NoRetiro")
                
                
            }else{
            
            let alert = UIAlertController(title: "Apreciado Cliente", message: rest.AdditionalInfo, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "ok", style: .default)
            {
                (action:UIAlertAction!) in
                //David Polania
                //Nota: se hace comentario para evitar que retroceda al viewController anterior
                // Bug 3281 error mantiz
                //self.navigationController!.popViewController(animated: true)
                self.textField1.text = ""
                self.txNum2.text = ""
                self.txNum3.text = ""
                self.txNum4.text = ""
                self.txNum5.text = ""
                self.txNum6.text = ""
                self.textField1.becomeFirstResponder()
            }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            }})
            
            }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 1 // Bool
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func triEnviarPin(_ sender: UIButton) {
        
        GetRetirementPIN(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
            
            /*
             let alert = UIAlertController(title: "Apreciado Cliente", message: rest.PinResult, preferredStyle: .alert)
             
             let OKAction = UIAlertAction(title: "Solicitar Pin", style: .default)
             {
             (action:UIAlertAction!) in
             }
             
             alert.addAction(OKAction)
             self.present(alert, animated: true, completion: nil)
             */
            
        })
       
        /*
        numPin1 = Int(textField1.text!)!
        numPin2 = Int(txNum2.text!)!
        numPin3 = Int(txNum3.text!)!
        numPin4 = Int(txNum4.text!)!
        numPin5 = Int(txNum5.text!)!
        numPin6 = Int(txNum6.text!)!
        
        pinTotal = "\(numPin1)\(numPin2)\(numPin3)\(numPin4)\(numPin5)\(numPin6)"
        
        let alert = UIAlertController(title: "Apreciado Cliente", message: pinTotal, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Solicitar Pin", style: .default)
        {
            (action:UIAlertAction!) in
        }
        
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
 */
        
    }
    
    @IBAction func triSolicitarPin(_ sender: UIButton) {
        
        GetRetirementPIN(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
            
            /*
            let alert = UIAlertController(title: "Apreciado Cliente", message: rest.PinResult, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Solicitar Pin", style: .default)
            {
                (action:UIAlertAction!) in
            }
            
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            */
            
        })
        
    }

    

}

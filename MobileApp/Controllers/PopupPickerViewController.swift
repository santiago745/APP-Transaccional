//
//  PopupPickerViewController.swift
//  MobileApp
//
//  Created by Pedro Alonso Daza B on 8/04/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class PopupPickerViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var btCerrar: UIButton!
    var muteForPickerData = ["minute(s)","hour(s)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopupPickerViewController.dismissKeyboard))
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.pickerView.resignFirstResponder()
        dismissKeyboard()
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
          self.pickerView.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    
    //Calls this function when the tap is recognized.
    @objc func  dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func ShowPicker(Arre:[String])
    {
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopupPickerViewController.dismissKeyboard))
        self.view.endEditing(true)
        self.Result = Arre[0]
        muteForPickerData = Arre
        pickerView.reloadAllComponents()
    }
    
    @IBAction func triCancel(_ sender: UIButton) {
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PopupPickerViewController.dismissKeyboard))
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
        
    }
    
    var ReturnObject:((_ result:String)->Void)?
    @IBAction func triAceptar(_ sender: UIButton) {
        
        dismiss(animated: true, completion: {
            self.ReturnObject?(self.Result)
            
        })
    }
    
    var Result = ""
    @IBAction func triCerrar(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return muteForPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return muteForPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Result = muteForPickerData[row]
        
    }
}

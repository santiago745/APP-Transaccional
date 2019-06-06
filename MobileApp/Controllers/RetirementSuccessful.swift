//
//  RetirementSuccessful.swift
//  MobileApp
//
//  Created by Periferia on 2/02/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import UIKit
import Firebase

class RetirementSuccessful: UIViewController {
    @IBOutlet weak var lbNumContrato: UILabel!

    @IBOutlet weak var lbTitleContract: UILabel!
    @IBOutlet weak var lbNumConfirmar: UILabel!
    @IBOutlet weak var lbDestino: UILabel!
    @IBOutlet weak var lbDiaEntrega: UILabel!
    @IBOutlet weak var lbMonto: UILabel!
    @IBOutlet weak var vwInfoRetiro: UIView!
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let numcontract = (RETIREMENTVALUECONTROLLER?.numeroContratoLocal)!
        
        lbTitleContract.text = "Contrato \(numcontract)"
        
        vwInfoRetiro.layer.borderWidth = 1
        vwInfoRetiro.layer.cornerRadius = 10
        vwInfoRetiro.layer.masksToBounds = true
        
        
        lbNumContrato.text = RETIREMENTVALUECONTROLLER?.numeroContratoLocal
        if(RETIREMENTVALUECONTROLLER?.txMonto == 0.0){
            lbMonto.text = "Totalidad de los recursos"
        }else{
            lbMonto.text = formatCurrency(value: (RETIREMENTVALUECONTROLLER?.txMonto)!) 
        }
        lbNumConfirmar.text = RETIREMENTPINCONTROLLER?.confirmationNumber
        lbDiaEntrega.text = RETIREMENTPINCONTROLLER?.transferDate
        lbDestino.text = RETIREMENTSUMMARYCONTROLLER?.bankaccountsarrayRecibir.BankName

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func triShare(_ sender: UIButton) {
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "6" as NSObject,
            AnalyticsParameterItemName: "Icono_Compartir" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        //Create the UIImage
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //Save it to the camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func triSalir(_ sender: UIButton) {
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "7" as NSObject,
            AnalyticsParameterItemName: "botón_Salir_al_finalizar_el_registro_del_retiro" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        
        
        self.performSegue(withIdentifier: "goPopUpEncuesta", sender: self)
        
  //      let vc = self.storyboard?.instantiateViewController(withIdentifier: "surveryController") as! RetirementSurveryController
  //      vc.modalPresentationStyle = .overFullScreen
  //      vc.modalTransitionStyle = .crossDissolve
  //      self.present(vc, animated: true, completion: nil)
    }
}

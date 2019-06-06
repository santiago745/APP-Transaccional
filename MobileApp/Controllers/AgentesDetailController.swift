//
//  AgentesDetailController.swift
//  MobileApp
//
//  Created by Pedro Daza on 30/05/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

let NMostarAgente = "NMostarAgente"
var AGENTE: AgenteResponseObject?
class AgentesDetailController: UIViewController, MFMailComposeViewControllerDelegate
{
    @IBOutlet weak var imFoto: UIImageView!
    @IBOutlet weak var lbNombreAgente: UILabel!
    @IBOutlet weak var lbNombreAgencia: UILabel!
    
    @IBOutlet weak var btTelefono: UIButton!
    
    @IBOutlet weak var btCelular: UIButton!
    
    @IBOutlet weak var btCorreoElectronico: UIButton!
    
    @IBOutlet weak var btHide: UIButton!
    @IBOutlet weak var lbDireccion: UILabel!
    
    @IBOutlet weak var vNavBar: UIView!
    var agente: AgenteResponseObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            lbNombreAgente.text = agente!.Name
            lbNombreAgencia.text = agente!.AgencyName
            
            btTelefono.setTitle(agente!.Phone, for: .normal)
            btCelular.setTitle(agente!.CellPhone, for: .normal)
            
            btCorreoElectronico.setTitle(agente!.Email, for: .normal)
            lbDireccion.text = agente!.AgencyAddress
            
            vNavBar.isHidden = false
        }
        else
        {
            NotificationCenter.default.addObserver(self, selector: #selector(AgentesDetailController.mostrarAgente), name: NSNotification.Name(rawValue: NMostarAgente), object: nil)
            vNavBar.isHidden = true
        }
  
        
        
        self.navigationItem.title = "Mis Agentes Comerciales";
    }
    @objc func mostrarAgente()
    {
        agente = AGENTE!
        lbNombreAgente.text = AGENTE!.Name
        lbNombreAgencia.text = AGENTE!.AgencyName
        
        btTelefono.setTitle(AGENTE!.Phone, for: .normal)
        btCelular.setTitle(AGENTE!.CellPhone, for: .normal)
        
        btCorreoElectronico.setTitle(AGENTE!.Email, for: .normal)
        lbDireccion.text = AGENTE!.AgencyAddress
    }
    @IBAction func triHide(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func triCall(_ sender: UIButton) {
        if let intTel = agente?.CellPhone
        {

            if let telInt = Int("\(intTel)")
            {
                UIApplication.shared.openURL(NSURL(string: "tel://\(telInt)")! as URL)
            }
        }
    }
    
    @IBAction func triSendMail(_ sender: UIButton) {

        if let EmailAgente = agente?.Email
        {
            
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = AGENTESCONTAINERVIEW as! MFMailComposeViewControllerDelegate
                // Configure the fields of the interface.
                composeVC.setToRecipients([EmailAgente])
                composeVC.setSubject("")
                composeVC.setMessageBody("", isHTML: false)
                // Present the view controller modally.
                AGENTESCONTAINERVIEW!.present(composeVC, animated: true, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
                
                 //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NSendEmail"), object: nil)
                
                break
            // It's an iPhone
            case .pad:
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = AGENTESCONTAINERVIEW as! MFMailComposeViewControllerDelegate
                // Configure the fields of the interface.
                composeVC.setToRecipients([EmailAgente])
                composeVC.setSubject("")
                composeVC.setMessageBody("", isHTML: false)
                // Present the view controller modally.
                AGENTESCONTAINERVIEW!.present(composeVC, animated: true, completion: nil)
                break
            default:
                
                break
            // It's an iPad
                // Uh, oh! What could it be?
            }
            
            
        }
        
    }
}

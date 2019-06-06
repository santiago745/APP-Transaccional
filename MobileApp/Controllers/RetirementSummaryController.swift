//
//  RetirementSummary.swift
//  MobileApp
//
//  Created by Periferia on 29/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var RETIREMENTSUMMARYCONTROLLER : RetirementSummaryController?
class RetirementSummaryController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var vwRecycler: UIView!
    @IBOutlet weak var vwConstraints: NSLayoutConstraint!
    @IBOutlet weak var viewdetailretirement: UIView!
    
    @IBOutlet weak var lbMontoSummary: UITextField!
    
    @IBOutlet weak var btCancelar: UIButton!
    @IBOutlet weak var lbMontoSummaryClose: UITextField!
    
    @IBOutlet weak var lbctaType: UILabel!
    @IBOutlet weak var lbnumcontract: UILabel!
    @IBOutlet weak var txMonto: UITextField!
    @IBOutlet weak var lbnamebank: UILabel!
    @IBOutlet weak var lbnumcta: UILabel!
    @IBOutlet weak var lbcity: UILabel!
    @IBOutlet weak var lbbtdia2: UILabel!
    @IBOutlet weak var lbbt2dia: UILabel!
    @IBOutlet weak var vwbankaccount: UIView!
    @IBOutlet weak var vwdia1: UIView!
    @IBOutlet weak var vwdias2: UIView!
    @IBOutlet weak var stdia2: UIStackView!
    @IBOutlet weak var stdia1: UIStackView!
    @IBOutlet weak var lbbtdia1express: UILabel!
    @IBOutlet weak var lbbtdia1: UILabel!
    var infoPopupPortafolio = [RetirementFundsAffectedObject]()
    var messageretirementtotal = ""    
    @IBOutlet weak var ctDia2: NSLayoutConstraint!
    @IBOutlet weak var ctDia1: NSLayoutConstraint!
    @IBOutlet weak var contraViewdetail: NSLayoutConstraint!
    
    @IBOutlet weak var lbNameThird: UILabel!
    @IBOutlet weak var contraintNameThird: NSLayoutConstraint!
    @IBOutlet weak var lbCharges: UILabel!
    @IBOutlet weak var lbnumInvestments: UILabel!
    
    var infoChargesTotal = [RetirementWithdrawalSimulationChargesObject]()
    var infoNuminvestements = [RetirementWithdrawalInvestmentsObject]()
    var montoTotalRecursos = 0.0
    
    var keyrecyclerdetail = 0
    var bankaccountsarrayRecibir = RetirementBaknAccountsObject(dic: ["":""])
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        
        return UIColor(
            
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            
            alpha: CGFloat(1.0)
            
        )
        
    }
    
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
        vwRecycler.isHidden = true
        viewdetailretirement.isHidden = true
        
        vwdia1.layer.borderWidth = 0
        vwdia1.layer.cornerRadius = 10
        vwdia1.layer.backgroundColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
        vwdia1.layer.masksToBounds = true
        
        
        vwdias2.layer.borderWidth = 0
        vwdias2.layer.cornerRadius = 10
        vwdias2.layer.backgroundColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
        vwdias2.layer.masksToBounds = true
        
        vwbankaccount.layer.borderWidth = 1
        vwbankaccount.layer.cornerRadius = 10
        vwbankaccount.layer.borderColor = UIColorFromRGB(rgbValue: 0xAAAAAA).cgColor
        vwbankaccount.layer.masksToBounds = true
        btCancelar.layer.borderWidth = 1
        btCancelar.layer.masksToBounds = true
        
        let availbleBalancetotalformat = formatCurrency(value: (RETIREMENTVALUECONTROLLER?.availbleBalancetotal)!)
        
        lbMontoSummary.text = availbleBalancetotalformat
        lbMontoSummaryClose.text = availbleBalancetotalformat
        
        
        RETIREMENTSUMMARYCONTROLLER = self
        
        lbbtdia1.text = "1 dia hábil"
        lbbtdia2.text = "2 dia hábil"
        lbbtdia1express.text = "(Retiro express)"
        lbbt2dia.text = "(Retiro parcial)"
        
        if(RETIREMENTVALUECONTROLLER?.txMonto == 0.0){
            txMonto.text = "Totalidad de los recursos"
            montoTotalRecursos = (RETIREMENTVALUECONTROLLER?.availbleBalancetotal)!
        }else{
            
            let txMontoFormat = formatCurrency(value: (RETIREMENTVALUECONTROLLER?.txMonto)!)
            txMonto.text = txMontoFormat
            //txMonto.text = String(format: "$%,3.02f", RETIREMENTVALUECONTROLLER?.txMonto ?? 0.0)//txMontoFormat
            /*let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
            txMonto.text = formatter.string(from: RETIREMENTVALUECONTROLLER?.txMonto as! NSNumber) */// $123"
            montoTotalRecursos = (RETIREMENTVALUECONTROLLER?.txMonto)!
        }
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        
        if(RETIREMENTVALUECONTROLLER?.messageAfter.isEqual(""))!{
            PostRetirementSimulation(controller: self,
                                     numcontracts:0,
                                     ChannelNumber:deviceID,
                                     UserId:LOCALCEDULA,
                                     CommentsBody:"",
                                     ContractNumberBody:(RETIREMENTVALUECONTROLLER?.numeroContratoLocal)!,
                                     DestinationTypeBody:1,
                                     FlagsBody:0,
                                     PlanCodeBody:(RETIREMENTVALUECONTROLLER?.planCodeLocal)!,ProductCodeBody:(RETIREMENTVALUECONTROLLER?.productCodeLocal)!,
                                     ValueBody: montoTotalRecursos,
                                     AccountNumberBody: bankaccountsarrayRecibir.Number,
                                     AccountTypeBody: bankaccountsarrayRecibir.TypeAcount,
                                     BankIdBody: bankaccountsarrayRecibir.BankId,
                                     BankNameBody: bankaccountsarrayRecibir.BankName,
                                     Ok: {rest in
                                        
                                        for chargesdip in rest.Charges{
                                            self.infoChargesTotal.append(chargesdip)
                                        }
                                        
                                        for investementsdip in rest.Investments{
                                            self.infoNuminvestements.append(investementsdip)
                                        }
                                        
                                      //  self.lbCharges.attributedText = NSAttributedString(string: String(rest.ChargesTotal), attributes:[NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
                                        
                                        self.lbCharges.text = self.formatCurrency(value: rest.ChargesTotal)
                                        self.lbnumInvestments.attributedText = NSAttributedString(string: String(rest.Investments.count), attributes:
                                            [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
                                        
                                        //self.lbCharges.text = String(rest.ChargesTotal)
                                        //self.lbnumInvestments.text = String(rest.Investments.count)
                                        /*
                                        let alert = UIAlertController(title: "Apreciado Cliente", message: String(rest.ChargesTotal), preferredStyle: .alert)
                                        
                                        let OKAction = UIAlertAction(title: "OK", style: .default)
                                        {
                                            (action:UIAlertAction!) in
                                            
                                            //(action:UIAlertAction!) in  self.navigationController!.popViewController(animated: true)
                                        }
                                        alert.addAction(OKAction)
                                        self.present(alert, animated: true, completion: nil)
                                        */
                                        
            })
        }
 
        
        
        if (!((RETIREMENTVALUECONTROLLER?.contractsarrayRecibir.Number.isEmpty)!)){
            
            lbnumcontract.text = "Contrato \((RETIREMENTVALUECONTROLLER?.contractsarrayRecibir.Number)!)"
        }else{
            lbnumcontract.text = "Contrato \(NUMERODECONTRATO)"
        }
        
        if(RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible == 1){
            
            lbbtdia1.textColor = UIColor.white
            // lbbtdia2.textColor = UIColor.white
            lbbtdia1express.textColor = UIColor.white
            // lbbt2dia.textColor = UIColor.white
            //vwdia1.backgroundColor = UIColorFromRGB(rgbValue:0x42AD00)
        }else if(RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible == 0){
            //     lbbtdia1.textColor = UIColor.white
            lbbtdia2.textColor = UIColor.white
            //    lbbtdia1express.textColor = UIColor.white
            lbbt2dia.textColor = UIColor.white
            //vwdias2.backgroundColor = UIColorFromRGB(rgbValue:0x42AD00)
            
        }
        //
        

        
        if(Int(RETIREMENTVALUECONTROLLER?.lyBt2dias.constant ?? 0) <= 0){
            ctDia2.constant = 0
            vwdias2.isHidden = true
            
        }
        
        if (Int(RETIREMENTVALUECONTROLLER?.lyBt1dia.constant ?? 0) <= 0){
            ctDia1.constant = 0
            vwdia1.isHidden = true
        }
        
        
        if(bankaccountsarrayRecibir.OwnerTypeId == 0){
            contraintNameThird.constant = 10
            lbNameThird.text = ""
            
        }else{
            contraintNameThird.constant = 19
            lbNameThird.text = bankaccountsarrayRecibir.OwnerName
        }
        
        lbnamebank.text = bankaccountsarrayRecibir.BankName
        lbnumcta.text = bankaccountsarrayRecibir.Number
        lbcity.text = bankaccountsarrayRecibir.CityName
        lbctaType.text = bankaccountsarrayRecibir.TypeName
        
    }
    
    @IBAction func tribackbank(_ sender: UIButton) {
        
        self.navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func tridetailrecy(_ sender: UIButton) {
        if (keyrecyclerdetail == 0){
            
            contraViewdetail.constant = 100
            keyrecyclerdetail = 1
            viewdetailretirement.isHidden = false
        }
        else{
            contraViewdetail.constant = 100
            keyrecyclerdetail = 0
            viewdetailretirement.isHidden = true
        }
    }
    
    @IBAction func triCargoRetiro(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpRetirementSumary") as! RetirementSummaryPopup
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func triPopUp2(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpRetirementSumary2") as! RetirementSummaryPopup2
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func triOpenRecycler(_ sender: UIButton) {
        
        vwConstraints.constant = 700
        vwRecycler.isHidden = false
        
    }
    
    @IBAction func triCloseRecycler(_ sender: UIButton) {
        vwConstraints.constant = 0
        vwRecycler.isHidden = true
        
    }
    
    
    @IBAction func triGoPin(_ sender: UIButton) {
        
        var message13 = ""
        
        if(RETIREMNTMESSANGECONTROLL?.Messages13 == nil){
            message13 = (RETIREMNTMESSANGE2CONTROLL?.Messages13)!
        }else{
            message13 = (RETIREMNTMESSANGECONTROLL?.Messages13)!
        }
        
        let alert = UIAlertController(title: "Apreciado Cliente", message: message13, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Solicitar Pin", style: .default)
        {
        
            (action:UIAlertAction!) in
            
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
            
            self.performSegue(withIdentifier: "goControllerPin", sender: self)
            
            
            
        }
        let CancelAction = UIAlertAction(title: "Cancelar", style: .default)
        {
            (action:UIAlertAction!) in
            
            
            
        }
        alert.addAction(CancelAction)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func triBackMonto(_ sender: UIButton) {
        
        RETIREMENTVALUECONTROLLER?.reiniciarIngeso = true
        self.navigationController!.popViewController(animated: false)
        RETIREMENTVALUECONTROLLER?.navigationController!.popViewController(animated: false)
      //  self.performSegue(withIdentifier: "gobackMonto", sender: self)
        //RETIREMENTVALUECONTROLLER?.viewDidLoad()
        
    }
    
    @IBAction func triGoBackDia(_ sender: UIButton) {
        
        RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible = 1
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true)
        
        getContenedorWithdrawals(controller: self, product: RETIREMENTVALUECONTROLLER!.productCodeLocal, numcontracts: RETIREMENTVALUECONTROLLER!.numeroContratoLocal, available: RETIREMENTVALUECONTROLLER!.availableGeneral , withdrawalAmount: RETIREMENTVALUECONTROLLER!.txMonto , planProduct: (RETIREMENTVALUECONTROLLER?.planCodeLocal)!, isFullSurrender: 1, Ok: {rest in
            
            self.infoPopupPortafolio = rest.FundDistribution
            
            self.messageretirementtotal = rest.Message
            
            vcspinner.hideSpinner()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "popupportafolio") as! PopupPortafolioController
            
            vc.modalPresentationStyle = .overFullScreen
            
            vc.modalTransitionStyle = .crossDissolve
            vc.ElegirDEstinoFunc = {
                self.navigationController!.popViewController(animated: true)
            }
            self.present(vc, animated: true, completion: nil)
        })
        
    }
    @IBAction func triGoBackDia2(_ sender: UIButton) {
        RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible = 0
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true)
        
        getContenedorWithdrawals(controller: self, product: RETIREMENTVALUECONTROLLER!.productCodeLocal, numcontracts: RETIREMENTVALUECONTROLLER!.numeroContratoLocal, available: RETIREMENTVALUECONTROLLER!.availableGeneral , withdrawalAmount: RETIREMENTVALUECONTROLLER!.txMonto , planProduct: (RETIREMENTVALUECONTROLLER?.planCodeLocal)!, isFullSurrender: 1, Ok: {rest in
            
            self.infoPopupPortafolio = rest.FundDistribution
            
            self.messageretirementtotal = rest.Message
            
            vcspinner.hideSpinner()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "popupportafolio") as! PopupPortafolioController
            
            vc.modalPresentationStyle = .overFullScreen
            
            vc.modalTransitionStyle = .crossDissolve
            vc.ElegirDEstinoFunc = {
                self.navigationController!.popViewController(animated: true)
            }
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    @IBAction func triCancelarRetiro(_ sender: UIButton) {
    
        _ = navigationController?.popToRootViewController(animated: true)
    }
}

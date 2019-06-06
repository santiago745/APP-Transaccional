//  RetirementValueController.swift
//  MobileApp
//
//  Created by Periferia on 20/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import Firebase
var RETIREMENTVALUECONTROLLER:RetirementValueController?
class RetirementValueController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var vwdia1: UIView!
    @IBOutlet weak var vwdia2: UIView!
    @IBOutlet weak var lbNumcontract: UILabel!
    @IBOutlet weak var lbAvailbleBalance: UITextField!
    @IBOutlet weak var txIngreseMonto: UITextField!
    @IBOutlet weak var lbTextdiaentrega: UILabel!
    @IBOutlet weak var bt1dia: UIButton!
    @IBOutlet weak var bt2dias: UIButton!
    @IBOutlet weak var btinfodiaentrega: UIButton!
    @IBOutlet weak var lbinfoDiaEntrega: UILabel!
    @IBOutlet weak var lbCerrarmontototal: UITextField!
    @IBOutlet weak var btcerrarrecy: UIButton!
    @IBOutlet weak var vwCerrarlabel: UIView!
    @IBOutlet weak var btConfirmar: UIButton!
    @IBOutlet weak var swRetiroTotal: UISwitch!
    @IBOutlet weak var lbRetiroTotal: UILabel!
    
    @IBOutlet weak var lbRetiroExpress: UILabel!
    @IBOutlet weak var lbName1dia: UILabel!
    @IBOutlet weak var lbName2dias: UILabel!
    @IBOutlet weak var lbRetiroParcial: UILabel!
    @IBOutlet weak var lyBt1dia: NSLayoutConstraint!
    @IBOutlet weak var lyBt2dias: NSLayoutConstraint!
    var infoPopupPortafolio = [RetirementFundsAffectedObject]()
    var messageretirementtotal = ""
    var btdayarray = ""
    var retirementwithdrawalType = ""
    var availbleBalancetotal:Double = 0.0
    var keymsg2 = 1
    let defaults = UserDefaults.standard
    var contractAcount = ""
    var keyBtConfimar = "0"
    var keyBtDiaDisponible = 0
    var VisibilityBoton1 = false
    var VisibilityBoton2 = false
    var availableGeneral = 0
    var valorMinKey16 = 0.0
    var valorMinKey15 = 0.0
    var valorMinKey27 = 0.0
    var valorMinKey25 = 0.0
    var messageAfter = ""
    var validationKey16 = true
    var validationKey15 = true
    var validationKey27 = true
    var validationKey25 = true
    var validationKey16v = true
    var validationKey15v = true
    var validationKey27v = true
    var validationKey25v = true
    var validationKeyGlobal = true
    var validationbtKey25 = false
    var numeroContratoLocal = ""
    var productCodeLocal = ""
    var planCodeLocal = ""
    var txMonto = 0.0
    var contractsarrayRecibir = RetirementContractsObject(dic: ["":""])
    var availablebalance = [RetirementBalanceChargesObject]()
    var availablebalanceAll = [RetirementBalanceChargesObject]()
    var infBankAccounts = RetirementAcountObject(dic:["":""])
    var reiniciarIngeso = true
    var Withdrawls = 0
    var ValueId5 = 0.0
    var ValueId6 = 0.0
    
    var Chargesobj = [RetirementBalanceChargesObject]()
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        self.navigationItem.title = "Ingrese el monto"
        bt1dia.isHidden = true
        bt2dias.isHidden = true
        lbTextdiaentrega.isHidden = true
        btinfodiaentrega.isHidden = true
        btConfirmar.isHidden = false
        self.lyBt1dia.constant = 0
        self.lyBt2dias.constant = 0
        
        if(self.planCodeLocal.isEqual("CAH1")){
            self.swRetiroTotal.isHidden = true
            self.lbRetiroTotal.isHidden = true
            
        }else{
            swRetiroTotal.isHidden = false
            lbRetiroTotal.isHidden = false
        }
        
        let sNumerop = "\(txIngreseMonto.text!)"
        
        let sNum = CambioFormatoLetras(SCifra: sNumerop, MaxLong: "0", MinLong: "0")
        
        txIngreseMonto.text = sNum
        
    }
    
    
    //Metodo para validar el monto y el numero de retiros
    func validarRetirosyMonto(){
        GetRestrictionsClass(controller: self, Ok: {res in
            self.Withdrawls = res.Withdrawls
            for item in res.ValueRestrictions{
                if item.Id == 5 {
                    self.ValueId5 = item.Value
                }
                if item.Id == 6 {
                    self.ValueId6 =  item.Value
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ingrese el monto"
        self.parent?.navigationItem.title = "Ingrese el monto"
        
        //Author: Jorge Vidal
        //Removemos toda la lista antes de llenarla
        self.availablebalance.removeAll()
        //----Fin
        
    //    self.navigationController?.navigationBar.topItem?.titleView = title: "Ingrese el monto"
        
        // Validar monto y numero de retiros permitidos
        validarRetirosyMonto()
      
        
        self.navigationController?.navigationBar.backItem?.title = " "
        lbName1dia.text = "1 dia hábil"
        lbName2dias.text = "2 dia hábil"
        lbRetiroExpress.text = "(Retiro express)"
        lbRetiroParcial.text = "(Retiro parcial)"
        contraininfodiadisponible.constant = 0
        
        
        if (contractsarrayRecibir.Number.isEmpty){
            numeroContratoLocal = NUMERODECONTRATO // contractsarrayRecibir.Number
            productCodeLocal = PRODUCTOCODECONTRATO //contractsarrayRecibir.ProductCode
            planCodeLocal = PLANCODECONTRATO //contractsarrayRecibir.PlanCode
        }else{
            numeroContratoLocal = contractsarrayRecibir.Number
            productCodeLocal = contractsarrayRecibir.ProductCode
            planCodeLocal = contractsarrayRecibir.PlanCode
        }
        txIngreseMonto.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        vwdia1.layer.borderWidth = 0
        vwdia1.layer.cornerRadius = 10
        vwdia1.layer.backgroundColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
        
        
        
        vwdia2.layer.borderWidth = 0
        vwdia2.layer.cornerRadius = 10
        vwdia2.layer.backgroundColor = UIColor(hex: "\(AFAFonts.greenskandia)ff")?.cgColor
       
        
        self.txIngreseMonto.delegate = self
        
        btcerrarrecy.isHidden = true
        vwCerrarlabel.isHidden = true
        bt1dia.isHidden = true
        bt2dias.isHidden = true
        lbTextdiaentrega.isHidden = true
        btinfodiaentrega.isHidden = true
        swRetiroTotal.isHidden = true
        lbRetiroTotal.isHidden = true
        btConfirmar.isHidden = false
        self.lyBt1dia.constant = 0
        self.lyBt2dias.constant = 0
        
        
        while (defaults.integer(forKey: "otherUser")) > 0 {
            var nuMessage = 1
            keymsg2 = defaults.integer(forKey: String(nuMessage))
            
            if ( keymsg2 == Int(LOCALCEDULA)){
                constraintsmsg2.constant = 0
                self.vcMsg2.isHidden = true
                break
            }
            if ((defaults.integer(forKey: "otherUser")) == nuMessage){
                break
            }
            nuMessage = nuMessage+1

        }
        

        
        
        lbNumcontract.text = "Contrato \(numeroContratoLocal)"
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true)
        getContenedorAcount(controller: self, contractNumber: numeroContratoLocal, productCode: productCodeLocal, planCode: planCodeLocal, Ok: {rest in
            
            
            self.contractAcount = rest.NotAccountsMessage
            self.infBankAccounts = rest
            
            
            if (!(self.contractAcount.isEqual(""))){
                
                let alert = UIAlertController(title: "Apreciado Cliente", message:self.contractAcount, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default)
                {
                    (action:UIAlertAction!) in
                    
                    self.navigationController!.popViewController(animated: true)
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                vcspinner.hideSpinner()   
            }
            //El oski
            //servicio get el cual obtiene balance
            
            getContenedorBalance(controller: self, product: self.productCodeLocal, numcontracts: self.numeroContratoLocal, Ok: {rest in
                
                self.availableGeneral = Int(rest.Value)
                //El oski
                //este for recorre todo el arreglo obteniendo el key y filtra
                for balancekey in rest.Charges{
                    
                    if (balancekey.Key! <= 16){
                        self.availablebalance.append(balancekey)
                    }
                    if(self.validationKey16v){
                        if (balancekey.Key == 16){
                            self.valorMinKey16 = balancekey.Value
                            self.validationKey16v = false
                            self.validationKey16 = true
                        }else{
                            self.validationKey16 = false
                        }
                    }
                    if(self.validationKey15v){
                        if(balancekey.Key == 15){
                            self.valorMinKey15 = balancekey.Value
                            self.validationKey15v = false
                            self.validationKey15 = true
                        }else{
                            self.validationKey15 = false
                        }}
                    if(self.validationKey25v){
                        if(balancekey.Key == 25){
                            self.valorMinKey25 = balancekey.Value
                            self.validationKey25v = false
                            self.validationKey25 = true
                        }else{
                            self.validationKey25 = false
                        }}
                    if(self.validationKey27v){
                        if(balancekey.Key == 27){
                            self.valorMinKey27 = balancekey.Value
                            self.validationKey27v = false
                            self.validationKey27 = true
                        }else{
                            self.validationKey27 = false
                        }
                    }
                    self.availablebalanceAll.append(balancekey)
                    
                }
                //El oski
                //este for recorre el arreglo por si alguno de estos key estan
                self.Chargesobj = rest.Charges
                
                self.messageAfter = rest.Message!
                
                if(!(self.messageAfter.isEqual(""))){
                    let alert = UIAlertController(title: "Apreciado Cliente", message:rest.Message, preferredStyle: .alert)
                    
                    let OKAction = UIAlertAction(title: "OK", style: .default)
                    {
                        (action:UIAlertAction!) in
                        
                        if(self.availbleBalancetotal == 0.0){
                        
                            do {
                                
                                self.navigationController!.popViewController(animated: true)
                                
                            }catch let error as NSError{
                                
                            }
                            
                            }
                        
                       //  self.navigationController!.popViewController(animated: true)
                        
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true, completion: nil)
                }
                self.availbleBalancetotal = rest.Value
                
                let availbleBalancetotalFormat = self.formatCurrency(value: self.availbleBalancetotal)
                
                self.lbAvailbleBalance.text = availbleBalancetotalFormat
                self.lbCerrarmontototal.text = availbleBalancetotalFormat
                
                let currentDate = NSDate()
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "M"
                let convertedDate = dateFormatter.string(from: currentDate as Date)
                
                let mes = self.defaults.integer(forKey: "MesEnCurso")
                
                if( mes <  Int(convertedDate)! || (mes == 1 || mes == 0))
                {
                    self.defaults.set(Int(convertedDate), forKey: "MesEnCurso")
                    self.defaults.set(0, forKey: "NoRetiro")
                }
                
                //   self.tbBalance.reloadData()
                //self.base = rest
                //   self.balancetotal = rest.Value
                RETIREMENTAVAILBLEBALANCECONTROLLER?.tbBalance.reloadData()
                vcspinner.hideSpinner()
            })
            
        })
        
        
        
        
        RETIREMENTVALUECONTROLLER = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationItem.title = "Ingrese el monto"
        parent?.navigationItem.title = "Ingrese el monto"
        
        if reiniciarIngeso {
            txIngreseMonto.text = ""
            txIngreseMonto.isEnabled = true
            keyBtConfimar = "0"
            bt1dia.isHidden = true
            bt2dias.isHidden = true
            swRetiroTotal.isHidden = false
            lbTextdiaentrega.isHidden = true
            lbRetiroTotal.isHidden = false
            btinfodiaentrega.isHidden = true
            btConfirmar.isHidden = false
            self.lyBt1dia.constant = 0
            self.lyBt2dias.constant = 0
            if Chargesobj != nil{
                for balance in self.Chargesobj{
                    
                    var arraydata = [1, 2, 3, 5, 11]
                    var bMostrar = false
                    for x in arraydata
                    {
                        if balance.Key == x
                        {
                            bMostrar = true
                            break
                        }
                    }
                    
                    if bMostrar
                    {
                        self.swRetiroTotal.isHidden = true
                        self.lbRetiroTotal.isHidden = true
                        break
                    }
                    
                }
                if(self.planCodeLocal.isEqual("CAH1")){
                    self.swRetiroTotal.isHidden = true
                    self.lbRetiroTotal.isHidden = true
                    
                }else{
                    self.swRetiroTotal.isHidden = false
                    self.lbRetiroTotal.isHidden = false
                }
                reiniciarIngeso = false
            }
        }else{
            self.navigationItem.title = "Retiro"
            parent?.navigationItem.title = "Retiro"
            self.bt1dia.isHidden = false
            self.bt2dias.isHidden = false
            self.lbTextdiaentrega.isHidden = false
            self.btinfodiaentrega.isHidden = false
            self.btConfirmar.isHidden = false
          //  self.lyBt1dia.constant = 150
           // self.lyBt2dias.constant = 150
            reiniciarIngeso = false
        }
    }
    @IBOutlet weak var vcMsg2: UIView!
    @IBOutlet weak var vcBalance: UIView!
    
    @IBOutlet var constraintsbalance: NSLayoutConstraint!
    @IBOutlet weak var constraintsmsg2: NSLayoutConstraint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func triMsg2(_ sender: UIButton) {
        constraintsmsg2.constant = 0
        self.vcMsg2.isHidden = true
        keymsg2 = Int(LOCALCEDULA)!

        var otherUser = defaults.integer(forKey: "otherUser")
        otherUser = otherUser+1
        defaults.set(keymsg2, forKey: String(otherUser))
        defaults.set(otherUser, forKey: "otherUser")
        
    }
    @IBAction func triRecyBalance(_ sender: UIButton) {
        self.view.endEditing(true)
        constraintsbalance.constant = 700
        vwCerrarlabel.isHidden = false
        btcerrarrecy.isHidden = false
        if (keycontreint == 2){
            contraininfodiadisponible.constant = 0
            keycontreint = 1
        }
        
    }
    
    @IBAction func triCerrrRecyBlance(_ sender: UIButton) {
        constraintsbalance.constant = 0
        vwCerrarlabel.isHidden = true
        btcerrarrecy.isHidden = true
    }
    
    @IBAction func triretirototal(_ sender: UISwitch) {
        if(sender.isOn){
            self.navigationItem.title = "Ingrese el monto"
            parent?.navigationItem.title = "Ingrese el monto"
            txIngreseMonto.text = "Totalidad de los Recursos"
            txIngreseMonto.isEnabled = false
            keyBtConfimar = "1"
            
            bt1dia.isHidden = true
            bt2dias.isHidden = true
            lbTextdiaentrega.isHidden = true
            btinfodiaentrega.isHidden = true
            btConfirmar.isHidden = false
            self.lyBt1dia.constant = 0
            self.lyBt2dias.constant = 0
            
            
        }else{
            txIngreseMonto.text = ""
            txIngreseMonto.isEnabled = true
            keyBtConfimar = "0"
        }
        
    }
    @IBAction func triConfirmar(_ sender: UIButton)
    {
        // Validar monto y numero de retiros permitidos
        // validarRetirosyMonto()
        
        self.navigationItem.title = "Retiro"
        parent?.navigationItem.title = "Retiro"
        
        self.swRetiroTotal.isHidden = true
        self.lbRetiroTotal.isHidden = true
        self.validationKeyGlobal = true
        self.validationbtKey25 = false
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "5" as NSObject,
            AnalyticsParameterItemName: "botón_confirmar" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        if(keyBtConfimar.isEqual("1")){
            
            
            if (self.availbleBalancetotal.rounded() > self.ValueId5 && self.ValueId5 != 0) {
                var message15  = ""
                
                if(RETIREMNTMESSANGECONTROLL?.Messages15 == nil) {
                    message15 = (RETIREMNTMESSANGE2CONTROLL?.Messages15)!
                }else{
                    message15 = (RETIREMNTMESSANGECONTROLL?.Messages15)!
                }
                
                let alert = UIAlertController(title: "Apreciado Cliente", message:message15, preferredStyle: .alert)
                
                let OKActionn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                {
                    (action:UIAlertAction!) in
                    self.swRetiroTotal.isHidden = false
                    self.lbRetiroTotal.isHidden = false
                }
                
                alert.addAction(OKActionn)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            if (Int(ValueId6) >= self.Withdrawls && self.Withdrawls != 0) {
                var message16  = ""
                
                if(RETIREMNTMESSANGECONTROLL?.Messages16 == nil) {
                    message16 = (RETIREMNTMESSANGE2CONTROLL?.Messages16)!
                }else{
                    message16 = (RETIREMNTMESSANGECONTROLL?.Messages16)!
                }
                
                let alert = UIAlertController(title: "Apreciado Cliente", message:message16, preferredStyle: .alert)
                
                let OKActionn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                {
                    (action:UIAlertAction!) in
                    self.swRetiroTotal.isHidden = false
                    self.lbRetiroTotal.isHidden = false
                }
                
                alert.addAction(OKActionn)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            txMonto = 0.0;
            retirementwithdrawalType = "2"
            Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
                AnalyticsParameterItemID: "4" as NSObject,
                AnalyticsParameterItemName: "botón_Elegir_Destino_cuando_sea_para_Retiro_Total" as NSObject,
                AnalyticsParameterContentType: "cont" as NSObject
                ])
            
            var message4  = ""
            
            if(RETIREMNTMESSANGECONTROLL?.Messages4 == nil){
                message4 = (RETIREMNTMESSANGE2CONTROLL?.Messages4)!
            }else{
              message4 = (RETIREMNTMESSANGECONTROLL?.Messages4)!
            }
            
            let alert = UIAlertController(title: "Apreciado Cliente", message:message4, preferredStyle: .alert)
            
            
            let OKAction = UIAlertAction(title: "Elegir Destino", style: .default)
            {
                
                (action:UIAlertAction!) in
                
                self.lyBt1dia.constant = 0
                self.lyBt2dias.constant = -1
                self.performSegue(withIdentifier: "baknAccount", sender: self)
                
                
            }
            let OKActionn = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default)
            {
                (action:UIAlertAction!) in
                self.swRetiroTotal.isHidden = false
                self.lbRetiroTotal.isHidden = false
            }
            
            alert.addAction(OKActionn)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            
            if (!((txIngreseMonto.text?.isEmpty)!)) {
                var txMontol = txIngreseMonto.text
                txMontol = txIngreseMonto.text?.replacingOccurrences(of: ".", with: "")
                txMontol = txMontol?.replacingOccurrences(of: "$", with: "")
                
                txMonto = Double(txMontol!)!
            }
            if (txMonto > 0){
                
                if (txMonto > self.ValueId5 && self.ValueId5 != 0) {
                    var message15  = ""
                    
                    if(RETIREMNTMESSANGECONTROLL?.Messages15 == nil) {
                        message15 = (RETIREMNTMESSANGE2CONTROLL?.Messages15)!
                    }else{
                        message15 = (RETIREMNTMESSANGECONTROLL?.Messages15)!
                    }
                    
                    let alert = UIAlertController(title: "Apreciado Cliente", message:message15, preferredStyle: .alert)
                    
                    let OKActionn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    {
                        (action:UIAlertAction!) in
                        self.swRetiroTotal.isHidden = false
                        self.lbRetiroTotal.isHidden = false
                    }
                    
                    alert.addAction(OKActionn)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                var NoRetiro = self.defaults.integer(forKey: "MesEnCurso")
                if (Int(ValueId6) >= self.Withdrawls && self.Withdrawls != 0) {
                    var message16  = ""
                    
                    if(RETIREMNTMESSANGECONTROLL?.Messages16 == nil) {
                        message16 = (RETIREMNTMESSANGE2CONTROLL?.Messages16)!
                    }else{
                        message16 = (RETIREMNTMESSANGECONTROLL?.Messages16)!
                    }
                    
                    let alert = UIAlertController(title: "Apreciado Cliente", message:message16, preferredStyle: .alert)
                    
                    let OKActionn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    {
                        (action:UIAlertAction!) in
                        self.swRetiroTotal.isHidden = false
                        self.lbRetiroTotal.isHidden = false
                    }
                    
                    alert.addAction(OKActionn)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                //Oskar Daza
                //Verifica si key 16 es mayor al monto ingresado
                if(txMonto > availbleBalancetotal){
                    
                    var message9  = ""
                    
                    if(RETIREMNTMESSANGECONTROLL?.Messages9 == nil) {
                        message9 = (RETIREMNTMESSANGE2CONTROLL?.Messages9)!
                    }else{
                        message9 = (RETIREMNTMESSANGECONTROLL?.Messages9)!
                    }
                    
                    let alert = UIAlertController(title: "Apreciado Cliente", message:message9, preferredStyle: .alert)
                    
                    let OKActionn = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default)
                    {
                        (action:UIAlertAction!) in
                        self.swRetiroTotal.isHidden = false
                        self.lbRetiroTotal.isHidden = false
                    }
                    
                    alert.addAction(OKActionn)
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                    
                 if (validationKey16){
                    if(valorMinKey16 > txMonto){
                        
                        var message10  = ""
                        
                        if(RETIREMNTMESSANGECONTROLL?.Messages10 == nil){
                            message10 = (RETIREMNTMESSANGE2CONTROLL?.Messages10)!
                        }else{
                            message10 = (RETIREMNTMESSANGECONTROLL?.Messages10)!
                        }
                        self.validationKeyGlobal = false
                        let alert = UIAlertController(title: "Apreciado Cliente", message:message10, preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        {
                            (action:UIAlertAction!) in
                            self.swRetiroTotal.isHidden = false
                            self.lbRetiroTotal.isHidden = false
                            //(action:UIAlertAction!) in  self.navigationController!.popViewController(animated: true)
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }}
                    
                    //Oskar Daza
                    //Verifica si el la resta del disponoble  y rel monto tiene que ser menor al key 15
                if(validationKey15){
                    
                    if((availbleBalancetotal - txMonto) < valorMinKey15){
                        
                        var message11  = ""
                        
                        if(RETIREMNTMESSANGECONTROLL?.Messages11 == nil){
                            message11 = (RETIREMNTMESSANGE2CONTROLL?.Messages11)!
                        }else{
                            message11 = (RETIREMNTMESSANGECONTROLL?.Messages11)!
                        }
                        
                        self.validationKeyGlobal = false
                        let alert = UIAlertController(title: "Apreciado Cliente", message: message11, preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default)
                        {
                            (action:UIAlertAction!) in
                            self.swRetiroTotal.isHidden = false
                            self.lbRetiroTotal.isHidden = false
                            //(action:UIAlertAction!) in  self.navigationController!.popViewController(animated: true)
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        return
                    }
                }
                
                if(self.planCodeLocal.isEqual("CAH1")){
                    self.bt1dia.isHidden = true
                    self.bt2dias.isHidden = true
                    self.lbTextdiaentrega.isHidden = true
                    self.btinfodiaentrega.isHidden = true
                    self.btConfirmar.isHidden = true
                    self.swRetiroTotal.isHidden = true
                    self.lbRetiroTotal.isHidden = true
                    
                    self.lyBt1dia.constant = -1
                    self.lyBt2dias.constant = 0
                      self.tri1day(bt1dia)
                    
                    return
                }
                    //Oskar Daza
                    //Monto ingresado menor que el key 27
                if(validationKey27){
                    
                    if (txMonto > valorMinKey27 ){
                        
                        var message8  = ""
                        
                        if(RETIREMNTMESSANGECONTROLL?.Messages8 == nil){
                            message8 = (RETIREMNTMESSANGE2CONTROLL?.Messages8)!
                        }else{
                            message8 = (RETIREMNTMESSANGECONTROLL?.Messages8)!
                        }
                        
                        let alert = UIAlertController(title: "Apreciado Cliente", message:message8, preferredStyle: .alert)
                        
                        let YesAction = UIAlertAction(title: "Aceptar", style: .default)
                        {
                            (action:UIAlertAction!) in
                            
                            PostRetirementAnswerUser(controller: self, numcontracts: self.numeroContratoLocal, surveyAnswer: "1", product: self.productCodeLocal, surveyType: "0", Ok: {rest in
                            })
                            self.validationKeyGlobal = false
                            self.bt1dia.isHidden = false
                            self.bt2dias.isHidden = false
                            self.lbTextdiaentrega.isHidden = false
                            self.btinfodiaentrega.isHidden = false
                            self.btConfirmar.isHidden = true


                            
                            //self.lyBt1dia.constant = 150
                            //self.lyBt2dias.constant = 150
                            
                            if (self.validationKey25){
                                
                                if(self.txMonto > self.valorMinKey25){
                                    self.validationKeyGlobal = false
                                    self.validationbtKey25 = true
                                    self.bt1dia.isHidden = true
                                    //self.bt2dias.isHidden = true
                                   // self.lbTextdiaentrega.isHidden = true
                                  // self.btinfodiaentrega.isHidden = true
                                    self.btConfirmar.isHidden = true
                                    self.swRetiroTotal.isHidden = true
                                    self.lbRetiroTotal.isHidden = true
                                    self.tri2days(self.bt2dias)
                                    
                                 //   self.lyBt1dia.constant = 0
                                   // self.lyBt2dias.constant = -1
                                }
                                
                            }
                            
                        }
                        
                        let NotAction = UIAlertAction(title: "Cancelar", style: .default)
                        {
                            (action:UIAlertAction!) in
                            PostRetirementAnswerUser(controller: self, numcontracts: self.numeroContratoLocal, surveyAnswer: "0", product: self.productCodeLocal, surveyType: "0", Ok: {rest in
                            })
                            self.navigationItem.title = "Ingrese el monto"
                            self.parent?.navigationItem.title = "Ingrese el monto"
                            self.bt1dia.isHidden = true
                            self.bt2dias.isHidden = true
                            self.lbTextdiaentrega.isHidden = true
                            self.btinfodiaentrega.isHidden = true
                            self.swRetiroTotal.isHidden = false
                            self.lbRetiroTotal.isHidden = false
                            self.btConfirmar.isHidden = false
                            self.lyBt1dia.constant = 0
                            self.lyBt2dias.constant = 0
                            
                        }
                        
                        alert.addAction(NotAction)
                        alert.addAction(YesAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                if (validationKey25){
                    
                    if(self.txMonto > self.valorMinKey25){
                        validationKeyGlobal = false
                        validationbtKey25 = true
                        self.bt1dia.isHidden = true
                        self.bt2dias.isHidden = false
                        self.lbTextdiaentrega.isHidden = true
                        self.btinfodiaentrega.isHidden = true
                        self.btConfirmar.isHidden = true
                        self.lyBt1dia.constant = -1
                        self.lyBt2dias.constant = 300
                        if(validationKey27==false){
                            self.tri2days(bt2dias)
                        }
                    }
                    
                }else{
                    if(self.txMonto > self.valorMinKey25){
                        validationKeyGlobal = false
                        validationbtKey25 = true
                        self.bt1dia.isHidden = true
                        self.bt2dias.isHidden = false
                        self.lbTextdiaentrega.isHidden = true
                        self.btinfodiaentrega.isHidden = true
                        self.btConfirmar.isHidden = true
                        self.lyBt1dia.constant = -1
                        self.lyBt2dias.constant = 300
                        if(validationKey27==false){
                            self.tri2days(bt2dias)
                        }
                    }
                }
                if(validationKeyGlobal){
                    self.bt1dia.isHidden = false
                    self.bt2dias.isHidden = false
                    self.lbTextdiaentrega.isHidden = false
                    self.btinfodiaentrega.isHidden = false
                    self.btConfirmar.isHidden = true
                    self.lyBt1dia.constant = 150
                    self.lyBt2dias.constant = 150
                    
                }
                
            }
            else{
                var message12  = ""
                
                if(RETIREMNTMESSANGECONTROLL?.Messages12 == nil) {
                    message12 = (RETIREMNTMESSANGE2CONTROLL?.Messages12)!
                }else{
                    message12 = (RETIREMNTMESSANGECONTROLL?.Messages12)!
                }
                
                let alert = UIAlertController(title: "Apreciado Cliente", message:message12, preferredStyle: .alert)
                
                let OKActionn = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default)
                {
                    (action:UIAlertAction!) in
                    self.swRetiroTotal.isHidden = false
                    self.lbRetiroTotal.isHidden = false
                }
                
                alert.addAction(OKActionn)
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
            
        }
    }
    
    @IBAction func tri1day(_ sender: UIButton) {
        
        keyBtDiaDisponible = 1
        retirementwithdrawalType = "1"
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "2" as NSObject,
            AnalyticsParameterItemName: "botón_Elegir_Destino_cuando_sea_para_Retiro_Express" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true)
        
        getContenedorWithdrawals(controller: self, product: productCodeLocal, numcontracts: numeroContratoLocal, available: self.availableGeneral , withdrawalAmount: txMonto , planProduct: planCodeLocal, isFullSurrender: keyBtDiaDisponible, Ok: {rest in
            
            self.infoPopupPortafolio = rest.FundDistribution
            
            self.messageretirementtotal = rest.Message
            
            vcspinner.hideSpinner()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "popupportafolio") as! PopupPortafolioController
            
            vc.modalPresentationStyle = .overFullScreen
            
            vc.modalTransitionStyle = .crossDissolve
            vc.ElegirDEstinoFunc = {
                self.performSegue(withIdentifier: "baknAccount", sender: self)
            }
            vc.CancelarDestino = {
                if(self.validationbtKey25 == true || self.planCodeLocal.isEqual("CAH1")){
                    self.navigationItem.title = "Ingrese el monto"
                    self.parent?.navigationItem.title = "Ingrese el monto"
                    self.bt1dia.isHidden = true
                    self.bt2dias.isHidden = true
                    self.lbTextdiaentrega.isHidden = true
                    self.btinfodiaentrega.isHidden = true
                    if(self.planCodeLocal.isEqual("CAH1")){
                        self.swRetiroTotal.isHidden = true
                        self.lbRetiroTotal.isHidden = true
                        
                    }else{
                        self.swRetiroTotal.isHidden = false
                        self.lbRetiroTotal.isHidden = false
                    }
                    self.btConfirmar.isHidden = false
                    self.lyBt1dia.constant = 0
                    self.lyBt2dias.constant = 0
                }
            }
            self.present(vc, animated: true, completion: nil)
        })
        
    }
    
    @IBAction func tri2days(_ sender: UIButton) {
    
        keyBtDiaDisponible = 0
        retirementwithdrawalType = "0"
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "3" as NSObject,
            AnalyticsParameterItemName: "botón_Elegir_Destino_cuando_sea_para_Retiro_Parcial" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true)
        getContenedorWithdrawals(controller: self, product: productCodeLocal, numcontracts: numeroContratoLocal, available: self.availableGeneral , withdrawalAmount: txMonto , planProduct: planCodeLocal, isFullSurrender: keyBtDiaDisponible, Ok: {rest in
            
            self.infoPopupPortafolio = rest.FundDistribution
            
            self.messageretirementtotal = rest.Message
            
            vcspinner.hideSpinner()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "popupportafolio") as! PopupPortafolioController
            
            vc.modalPresentationStyle = .overFullScreen
            
            vc.modalTransitionStyle = .crossDissolve

            vc.ElegirDEstinoFunc = {
                self.performSegue(withIdentifier: "baknAccount", sender: self)
            }
            vc.CancelarDestino = {
                if(self.validationbtKey25 == true || self.planCodeLocal.isEqual("CAH1")){
                    self.navigationItem.title = "Ingrese el monto"
                    self.parent?.navigationItem.title = "Ingrese el monto"
                    self.bt1dia.isHidden = true
                    self.bt2dias.isHidden = true
                    self.lbTextdiaentrega.isHidden = true
                    self.btinfodiaentrega.isHidden = true
                    if(self.planCodeLocal.isEqual("CAH1")){
                        self.swRetiroTotal.isHidden = true
                        self.lbRetiroTotal.isHidden = true
                        
                    }else{
                        self.swRetiroTotal.isHidden = false
                        self.lbRetiroTotal.isHidden = false
                    }
                    self.btConfirmar.isHidden = false
                    self.lyBt1dia.constant = 0
                    self.lyBt2dias.constant = 0
                }
            }
            self.present(vc, animated: true, completion: nil)
        })
        
    }
    
    @IBOutlet weak var contraininfodiadisponible: NSLayoutConstraint!
    var keycontreint = 1
    @IBAction func triinfodiadisponible(_ sender: UIButton) {
        
        var message3  = ""
        
        if(RETIREMNTMESSANGECONTROLL?.Messages3 == nil) {
            message3 = (RETIREMNTMESSANGE2CONTROLL?.Messages3)!
        }else{
            message3 = (RETIREMNTMESSANGECONTROLL?.Messages3)!
        }
        
        lbinfoDiaEntrega.text = message3
        if(keycontreint == 1){
            contraininfodiadisponible.constant = 140
            keycontreint = 2
        }
        else if (keycontreint == 2){
            contraininfodiadisponible.constant = 0
            keycontreint = 1
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Ingrese el monto"
        self.parent?.navigationItem.title = "Ingrese el monto"
    }
    
}


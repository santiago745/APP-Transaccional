//
//  RetirementContract.swift
//  MobileApp
//
//  Created by Periferia on 17/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var RETIREMENTCONTRACTS : RetirementContractController?


class RetirementContractCell:UITableViewCell {

    @IBOutlet weak var lbContrato: UILabel!
    @IBOutlet weak var lbNumContrato: UILabel!
    @IBOutlet weak var lbValorContrato: UILabel!
    
    func setContrato(contrato:RetirementContractsObject,productos:RetirementProductsObject)
    {
        let numerocontrato = contrato.Number
        var result = ""
        
        if let range = numerocontrato.range(of:"\\w{4}$", options: .regularExpression) {
             result = numerocontrato.substring(with:range)
        }
        
        lbContrato.text = productos.Caption
        //lbNumContrato.text = contrato.Number
        lbNumContrato.text = "...\(result)" 
        for field in contrato.Fields
        {
            if field.Key == "Saldo"
            {
                lbValorContrato.text = field.Value
            }
        }
        
    }
}


class RetirementContractController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  //  @IBOutlet weak var cwMensaje: UIView!
    
    //Creamos un Array de datos para presentar en la TableView
    //var contratoss = ["contrato 190","contrato 190456","contrato 190456","contrato 190456","contrato 1904576","contrato 190457","contrato 190457"]
    
    var contractsarray = [RetirementContractsObject]()
    var contractsarrayEnviar = RetirementContractsObject(dic: ["":""])
    var productssarray = [RetirementProductsObject]()
    var infoTotalBalance = [RetirementAvailableBalanceObject]()

    
    //Creamos el identificador de la TableView
    let cellIdentifier = "Cell"
    var keymsg1 = 1
    let defaults = UserDefaults.standard

    @IBOutlet weak var lbTitlecontrcts: UILabel!

    @IBOutlet weak var btMsg: UIButton!
    @IBOutlet weak var cvMsg: UIView!
    @IBOutlet weak var tbContrcat: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   while (defaults.integer(forKey: "otherUser1")) > 0 {
        
    var nuMessage = 1
    keymsg1 = defaults.integer(forKey: "m1\(nuMessage)")
    
        if ( keymsg1 == Int(LOCALCEDULA)){
            const.constant = 0
            self.cvMsg.isHidden = true
            self.btMsg.isHidden = true
            break
        }
        if ((defaults.integer(forKey: "otherUser1")) == nuMessage){
        break
    }
    nuMessage = nuMessage+1
        }
        
        getContenedor(controller: self, numeroDeDocumento: "", tipoDeDocument: "", Ok: {rest in
            
            for Control in rest
            {
                for productos in Control.Products
                {

                    for contratos in productos.Contracts
                    {
                        if(contratos.WithdrawalsAllowed){
                        self.contractsarray.append(contratos)
                        self.productssarray.append(productos)
                        }
                    }
                }
                
            }
            
            self.tbContrcat.reloadData()
            //self.base = rest
            
            
        })

        
        self.tbContrcat.dataSource = self
        self.tbContrcat.delegate = self
        
        RETIREMENTCONTRACTS = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.contractsarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementContractCell
    
        let arrayContratos =   self.contractsarray[indexPath.row]
        let arrayProductos =   self.productssarray[indexPath.row]

        cell.setContrato(contrato: arrayContratos, productos: arrayProductos)
        

        //cell.textLabel?.text = arrayContratos.Number as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let indexPath = self.tbContrcat.indexPathForSelectedRow!
        let currentCell = self.tbContrcat.cellForRow(at: indexPath)! as UITableViewCell
  //      var viewc = self.storyboard?.instantiateViewController(withIdentifier: "RetirementValueController") as! RetirementValueController
        //your code...
        
    
            self.performSegue(withIdentifier: "contractAmount", sender: self)

}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "contractAmount" ,
            let nextScene = segue.destination as? RetirementValueController ,
            let indexPath = self.tbContrcat.indexPathForSelectedRow {
            let selectedVehicle = contractsarray[indexPath.row]
            nextScene.contractsarrayRecibir = selectedVehicle
            
        }
        
    }
  
    @IBOutlet var const: NSLayoutConstraint!
    @IBAction func tribtCloseMsg(_ sender: UIButton) {
        self.cvMsg.isHidden = true
        self.btMsg.isHidden = true
        keymsg1 = Int(LOCALCEDULA)!
        
        var otherUser = defaults.integer(forKey: "otherUser1")
        otherUser = otherUser+1
        defaults.set(keymsg1, forKey: "m1\(otherUser)")
        defaults.set(otherUser, forKey: "otherUser1")
        
        const.constant = 0
        
    }
   
    @IBAction func trishared(_ sender: UIButton) {

        
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
}


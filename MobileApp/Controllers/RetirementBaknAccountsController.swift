//
//  RetirementBaknAccountsController.swift
//  MobileApp
//
//  Created by Periferia on 27/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var keysegmentaccount = 1

class RetirementBaknAccountsCell:UITableViewCell {
    @IBOutlet weak var vwinfoAccount: UIView!
    @IBOutlet weak var lbnamebank: UILabel!
//        @IBOutlet weak var sgaccount: UISegmentedControl!
    
    @IBOutlet weak var lbTypeAccount: UILabel!
    @IBOutlet weak var lbnumAccount: UILabel!

    @IBOutlet weak var lbNameThird: UILabel!
    
    @IBOutlet weak var contraintNameThird: NSLayoutConstraint!
    @IBOutlet weak var lbcityAccount: UILabel!
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        
        return UIColor(
            
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            
            alpha: CGFloat(1.0)
            
        )
        
    }
    func setAccounts(Accounts:RetirementBaknAccountsObject)
    {
        
        vwinfoAccount.layer.borderWidth = 1
        vwinfoAccount.layer.borderColor = UIColorFromRGB(rgbValue: 0xAAAAAA).cgColor
        vwinfoAccount.layer.cornerRadius = 10
        vwinfoAccount.layer.masksToBounds = true
        
        
        if(keysegmentaccount == 1){
        if(Accounts.OwnerTypeId == 0){
            lbnamebank.text = Accounts.BankName
            lbnumAccount.text = Accounts.Number
            lbcityAccount.text = Accounts.CityName
            lbTypeAccount.text = Accounts.TypeName
            contraintNameThird.constant = 10
            lbNameThird.text = ""
            }}else if(keysegmentaccount == 2){
            if(Accounts.OwnerTypeId == 1){
                contraintNameThird.constant = 19
                lbNameThird.text = Accounts.OwnerName
                lbnamebank.text = Accounts.BankName
                lbnumAccount.text = Accounts.Number
                lbcityAccount.text = Accounts.CityName
                lbTypeAccount.text = Accounts.TypeName
            }
        }

}

}

class RetirementBaknAccountsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellIdentifier = "Cell"
    var keybtback = false
    var arrayAccount = [RetirementBaknAccountsObject]()
    @IBOutlet weak var tbBankAccounts: UITableView!
    
    @IBOutlet weak var sgaccount: UISegmentedControl!
    var infoBaknAccountslocal = [RetirementBaknAccountsObject]()
    
    @IBOutlet weak var navGeneral: UINavigationItem!

    override func viewWillAppear(_ animated: Bool) {
        //Oskar Daza
        //Cambia el tintcolor de el navigation
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        keysegmentaccount = 1
       arrayAccount = (RETIREMENTVALUECONTROLLER?.infBankAccounts.BaknAccounts)!
        
        
        if (keysegmentaccount == 1){
          infoBaknAccountslocal = [RetirementBaknAccountsObject]()
            for cellcount in arrayAccount{
                self.tbBankAccounts.reloadData()
                if(cellcount.OwnerTypeId == 0){
                    self.infoBaknAccountslocal.append(cellcount)
                    self.tbBankAccounts.reloadData()
            }
        }
        }else if(keysegmentaccount == 2){
         infoBaknAccountslocal = [RetirementBaknAccountsObject]()
            for cellcount in arrayAccount{
                self.tbBankAccounts.reloadData()
                if(cellcount.OwnerTypeId == 1){
                self.infoBaknAccountslocal.append(cellcount)
                 self.tbBankAccounts.reloadData()
                }
            }}
 
        self.tbBankAccounts.dataSource = self
        self.tbBankAccounts.delegate = self
        self.tbBankAccounts.reloadData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        keybtback = true
    }
    
    func arrayloadtable(){
        if (keysegmentaccount == 1){
            infoBaknAccountslocal = [RetirementBaknAccountsObject]()
            for cellcount in arrayAccount{
                self.tbBankAccounts.reloadData()
                if(cellcount.OwnerTypeId == 0){
                    self.infoBaknAccountslocal.append(cellcount)
                    self.tbBankAccounts.reloadData()
                    
                }
            }
        }else if(keysegmentaccount == 2){
            infoBaknAccountslocal = [RetirementBaknAccountsObject]()
            for cellcount in arrayAccount{
                self.tbBankAccounts.reloadData()
                if(cellcount.OwnerTypeId == 1){
                    self.infoBaknAccountslocal.append(cellcount)
                    self.tbBankAccounts.reloadData()
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return self.infoBaknAccountslocal.count


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementBaknAccountsCell
        
        let arrayAccounts =   self.infoBaknAccountslocal[indexPath.row]
        
        cell.setAccounts(Accounts: arrayAccounts)
        
        
        //cell.textLabel?.text = arrayContratos.Number as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //      var viewc = self.storyboard?.instantiateViewController(withIdentifier: "RetirementValueController") as! RetirementValueController
        //your code...
        
        let indexPath = tbBankAccounts.indexPathForSelectedRow!
        let currentCell = tbBankAccounts.cellForRow(at: indexPath)! as UITableViewCell
        
            self.performSegue(withIdentifier: "summaryretirement", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "summaryretirement" ,
            let nextScene = segue.destination as? RetirementSummaryController,
            let indexPath = self.tbBankAccounts.indexPathForSelectedRow {
            let selectedVehicle = infoBaknAccountslocal[indexPath.row]
            nextScene.bankaccountsarrayRecibir = selectedVehicle
        }
        
    }
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch sgaccount.selectedSegmentIndex
        {
        case 0:
            keysegmentaccount = 1
            self.arrayloadtable()
        case 1:
            keysegmentaccount = 2
            self.arrayloadtable()
        default:
            break;
        }
    }
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            // Back button Event handler
           // self.navigationItem.title = "Ingrese el monto"
           // self.parent?.navigationItem.title = "Ingrese el monto"
            RETIREMENTVALUECONTROLLER?.viewDidLoad()
            
            //self.navigationItem.title = "Ingrese el monto"
           // self.parent?.navigationItem.title = "Ingrese el monto"

        }
    }

    

}


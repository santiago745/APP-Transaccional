//
//  RetirementSummaryPopup.swift
//  MobileApp
//
//  Created by Periferia on 23/01/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementSummaryPopupCell:UITableViewCell {

    @IBOutlet weak var lbNameCharge: UILabel!
    
    @IBOutlet weak var lbValueCharge: UILabel!
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    func setAccounts(Accounts:RetirementWithdrawalSimulationChargesObject)
    {
        lbNameCharge.text = Accounts.Name
        lbValueCharge.text = formatCurrency(value: Double(Accounts.Value))
        
    }
    
}

class RetirementSummaryPopup: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellIdentifier = "Cell"
    var arrayAccount = [RetirementBaknAccountsObject]()
    @IBOutlet weak var tbCharges: UITableView!

    var infoChargeslocal = [RetirementWithdrawalSimulationChargesObject]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
   //     for chargepopup in (RETIREMENTSUMMARYCONTROLLER?.infoChargesTotal)!{
    //        infoChargeslocal.append(chargepopup)
    //    }
        
        
        self.tbCharges.dataSource = self
        self.tbCharges.delegate = self
        self.tbCharges.reloadData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (RETIREMENTSUMMARYCONTROLLER?.infoChargesTotal.count)!
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementSummaryPopupCell
        
        let arrayAccounts =   RETIREMENTSUMMARYCONTROLLER?.infoChargesTotal[indexPath.row]
        
        cell.setAccounts(Accounts: arrayAccounts!)
        
        
        //cell.textLabel?.text = arrayContratos.Number as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //      var viewc = self.storyboard?.instantiateViewController(withIdentifier: "RetirementValueController") as! RetirementValueController
        //your code...
        
       // let indexPath = tbBankAccounts.indexPathForSelectedRow!
        //let currentCell = tbBankAccounts.cellForRow(at: indexPath)! as UITableViewCell
        
        //self.performSegue(withIdentifier: "summaryretirement", sender: self)
        
    }

    @IBAction func triClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

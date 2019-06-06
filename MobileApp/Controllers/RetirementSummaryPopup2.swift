//
//  RetirementSummaryPopup.swift
//  MobileApp
//
//  Created by Periferia on 23/01/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import Foundation
import UIKit

class RetirementSummaryPopupCell2:UITableViewCell {
    
    @IBOutlet weak var lbFecha: UILabel!
  
    @IBOutlet weak var lbMonto: UILabel!
    
    @IBOutlet weak var lbCapital: UILabel!
    @IBOutlet weak var lbCuenta: UILabel!
    @IBOutlet weak var lbBeneficio: UILabel!
    
    @IBOutlet weak var lbFechaV: UILabel!
    
    @IBOutlet weak var vwAportes: UIView!


    @IBOutlet weak var lbMontoV: UILabel!
    @IBOutlet weak var lbCapitalV: UILabel!
    @IBOutlet weak var lblbCuentaV: UILabel!
    @IBOutlet weak var lbBeneficioV: UILabel!
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func setAccounts(Accounts: RetirementWithdrawalInvestmentsObject)
    {
        lbFechaV.text = Accounts.EffectiveDate
        lbMontoV.text = formatCurrency(value:Double(Accounts.OriginalCapital))
        lbCapitalV.text = formatCurrency(value:Double(Accounts.WithdrewCapital))
        lblbCuentaV.text = formatCurrency(value:Double(Accounts.BenefitValue))
        lbBeneficioV.text = Accounts.TaxRemainingTime
        vwAportes.layer.borderWidth = 1
        vwAportes.layer.cornerRadius = 10
        vwAportes.layer.masksToBounds = true
      
        
    }
    
}

class RetirementSummaryPopup2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellIdentifier = "Cell"
    
 
    @IBOutlet weak var Investments: UITableView!
    var infoChargeslocal = [RetirementWithdrawalInvestmentsObject]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        //     for chargepopup in (RETIREMENTSUMMARYCONTROLLER?.infoChargesTotal)!{
        //        infoChargeslocal.append(chargepopup)
        //    }
        
        
        self.Investments.dataSource = self
        self.Investments.delegate = self
        self.Investments.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (RETIREMENTSUMMARYCONTROLLER?.infoNuminvestements.count)!
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementSummaryPopupCell2
        
        let arrayAccounts = RETIREMENTSUMMARYCONTROLLER?.infoNuminvestements[indexPath.row]
        
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

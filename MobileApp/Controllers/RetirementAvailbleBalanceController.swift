//
//  RetirementAvailbleBalanceController.swift
//  MobileApp
//
//  Created by Periferia on 21/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
var RETIREMENTAVAILBLEBALANCECONTROLLER : RetirementAvailbleBalanceController?

class RetirementAvailableBalanceCell:UITableViewCell{
    @IBOutlet weak var lbDescription: UILabel!
    
    
    @IBOutlet weak var lbValue: UILabel!
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = NSLocale(localeIdentifier: "es_US") as Locale
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func setBalance(contrato:RetirementBalanceChargesObject)
        
    {
        
        let valueFormat = formatCurrency(value: contrato.Value)
        lbDescription.text = contrato.Description
        lbValue.text = valueFormat

        
    }
    
}

class RetirementAvailbleBalanceController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbBalance: UITableView!

    var availablebalance = [RetirementBalanceChargesObject]()
    
    let cellIdentifier = "Cell"
    
    var balancetotal = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
            self.tbBalance.reloadData()

        RETIREMENTAVAILBLEBALANCECONTROLLER = self
        
        self.tbBalance.dataSource = self
        self.tbBalance.delegate = self
        

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (RETIREMENTVALUECONTROLLER?.availablebalance.count)!
       // return availablebalance.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementAvailableBalanceCell
        
        let availableBalance =   RETIREMENTVALUECONTROLLER?.availablebalance[indexPath.row]
        
        cell.setBalance(contrato: availableBalance!)
        
        
        //cell.textLabel?.text = arrayContratos.Number as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //      var viewc = self.storyboard?.instantiateViewController(withIdentifier: "RetirementValueController") as! RetirementValueController
        //your code...
        
        //let indexPath = tbContrcat.indexPathForSelectedRow!
        //let currentCell = tbContrcat.cellForRow(at: indexPath)! as UITableViewCell
        
        //self.performSegue(withIdentifier: "contractAmount", sender: self)
        
        
        
        
        
    }

}


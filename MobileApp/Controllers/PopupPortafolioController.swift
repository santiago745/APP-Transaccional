//
//  PruebaPopupController.swift
//  MobileApp
//
//  Created by Periferia on 28/11/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//
import Foundation
import UIKit

class RetirementPopup1Cell:UITableViewCell {
    @IBOutlet weak var lbnameportafolio: UILabel!
    @IBOutlet weak var lbPercentageportafolios: UILabel!

    
    func setPortafolios(portafolios:RetirementFundsAffectedObject)
    {
        
        lbnameportafolio.text = portafolios.Name
        lbPercentageportafolios.text = portafolios.Percentage
        
    }
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    
    return UIColor(
        
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        
        alpha: CGFloat(1.0)
        
    )
    
}

class PopupPortafolioController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var btCancelar: UIButton!
    let cellIdentifier = "Cell"
    @IBOutlet weak var tbPopup: UITableView!
    
    @IBOutlet weak var txinfoPortafolio: UITextView!
    
    var textpopup = ""
    var textohtml:NSAttributedString?
    var infopopup = [RetirementFundsAffectedObject]()
    var keypopuptoaccount = false
    
    
    var ElegirDEstinoFunc:(() -> Void)?
    var CancelarDestino:(() -> Void)?
    
    
    
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

        btCancelar.layer.borderWidth = 1
        btCancelar.layer.masksToBounds = true
        btCancelar.layer.borderColor = UIColorFromRGB(rgbValue: 0x999999).cgColor
        
        
 //     infopopup = (RETIREMENTVALUECONTROLLER?.infoPopupPortafolio[0].FundsAffected)!
        if (RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible == 1){
            
            let key25Format = formatCurrency(value: (RETIREMENTVALUECONTROLLER?.valorMinKey25)!)
        
      textpopup = (RETIREMENTVALUECONTROLLER?.messageretirementtotal.replacingOccurrences(of: "{var1}", with: key25Format))!
      
        for portafolios in (RETIREMENTVALUECONTROLLER?.infoPopupPortafolio)!
        {
            
                self.infopopup.append(portafolios)
            
        }
        }else if(RETIREMENTVALUECONTROLLER?.keyBtDiaDisponible == 0){
            
            let availbleBalancetotalFormat = formatCurrency(value: (RETIREMENTVALUECONTROLLER?.availbleBalancetotal)!)
            
            textpopup = (RETIREMENTVALUECONTROLLER?.messageretirementtotal.replacingOccurrences(of: "{var1}", with: availbleBalancetotalFormat))!
            
            for portafolios in (RETIREMENTVALUECONTROLLER?.infoPopupPortafolio)!
            {
                
                self.infopopup.append(portafolios)
                
            }
        }
        
        
        do{
            /*textohtml = try NSAttributedString(data:textpopup.data(using: String.Encoding.utf8)!, options: [NSAttributedString.DocumentAttributeKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentAttributeKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
 */
      
            
            textohtml = try NSAttributedString(data: textpopup.data(using: String.Encoding.utf8)!, options:
                [.documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        }catch{
//            print("Could not convert!")
            
        }
        txinfoPortafolio.attributedText = (textohtml)
        
        // Do any additional setup after loading the view.
        
        self.tbPopup.dataSource = self
        self.tbPopup.delegate = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.infopopup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetirementPopup1Cell
        
        let arrayPortafolios =   self.infopopup[indexPath.row]
        
        cell.setPortafolios(portafolios: arrayPortafolios)
        
        
        //cell.textLabel?.text = arrayContratos.Number as String
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //      var viewc = self.storyboard?.instantiateViewController(withIdentifier: "RetirementValueController") as! RetirementValueController
        //your code...
        
        let indexPath = tbPopup.indexPathForSelectedRow!
        let currentCell = tbPopup.cellForRow(at: indexPath)! as UITableViewCell
        
 //       if(UIDevice.current.userInterfaceIdiom == .phone){
 //           self.performSegue(withIdentifier: "contractAmount", sender: self)}
 //       else{
 //           self.performSegue(withIdentifier: "retirementdetailcontract", sender: self)
 //       }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func triCancelar(_ sender: UIButton) {
        /*self.dismiss(animated: true, completion: {
          self.CancelarDestino!()
        })*/
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func triElegirdestino(_ sender: Any) {
        
        self.dismiss(animated: true, completion: {
            self.ElegirDEstinoFunc!()
        })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AgentesContainerTableController.swift
//  MobileApp
//
//  Created by admin on 16/05/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import UIKit
import MessageUI

var NOMBRESTRING:String = ""
var NOMBREAGENTSTRING:String = ""
var MaxAgentes = 0
class AgentesContainerCellTableController: UITableViewCell
    
    
{

    @IBOutlet var lbNombreAgente: UILabel!
    @IBOutlet var lbNombreAgencia: UILabel!
    @IBOutlet var imAgente: UIImageView!

    
}
var AGENTESCONTAINERVIEW:UIViewController?
var AGENTESCONTROLLER:UIViewController?
class AgentesContainerTableController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
   
    
    @IBOutlet var tableView: UITableView!
    //var items: [String] = ["We", "Heart", "Swift"]
    var items: [String] = ["We"]
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        


        let request = RequestSwiftObjC()
        
        request.getAgentes(view: self, Ok: { res in
        
            
        
            LOCALARRAYAGENTES = res
            if LOCALARRAYAGENTES.count >= 1
            {
                AGENTE = LOCALARRAYAGENTES[0]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NMostarAgente), object: nil)
            }
            self.tableView.reloadData()
        })
        

        

        tableView.delegate = self
        tableView.dataSource = self
        
        AGENTESCONTROLLER = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    func GetMaxAgentes () -> Int
    {
        return MaxAgentes
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MaxAgentes = 0;
        MaxAgentes = MaxAgentes + (LOCALARRAYAGENTES.count * 100)
        let MaxAgetes1:[String: NSString] = ["MaxAgentes": "\(MaxAgentes)" as NSString]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NChangeHeigthView1"), object: MaxAgetes1)
        return LOCALARRAYAGENTES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath as IndexPath) as! AgentesContainerCellTableController
        
        
            cell.lbNombreAgente.text = LOCALARRAYAGENTES[indexPath.row].Name
            cell.lbNombreAgencia.text = LOCALARRAYAGENTES[indexPath.row].AgencyName
        // cell.lbItem.text = items[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "AgentesDetailController") as! AgentesDetailController

        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.agente = LOCALARRAYAGENTES[indexPath.row]
        
        self.present(viewController, animated: true, completion: nil)
        }
        else
        {
            AGENTE = LOCALARRAYAGENTES[indexPath.row]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NMostarAgente), object: nil)
        }
    }

}



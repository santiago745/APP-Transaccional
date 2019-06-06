//
//  RetirementSurveryController.swift
//  MobileApp
//
//  Created by Periferia on 1/02/18.
//  Copyright © 2018 Old Mutual. All rights reserved.
//

import UIKit
import Firebase

class RetirementSurveryController: UIViewController {
    @IBOutlet weak var btEducacion: UIButton!
    @IBOutlet weak var btEntretenimiento: UIButton!
    @IBOutlet weak var btLiquidez: UIButton!

    @IBOutlet weak var btGracias: UIButton!
    @IBOutlet weak var btVivienda: UIButton!
    @IBOutlet weak var btDeudas: UIButton!
    @IBOutlet weak var btInversion: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        btGracias.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callServiceSurvey(num:String){
        
        PostRetirementAnswerUser(controller: self, numcontracts: (RETIREMENTVALUECONTROLLER?.numeroContratoLocal)!, surveyAnswer: num, product: (RETIREMENTVALUECONTROLLER?.productCodeLocal)!, surveyType: "1", Ok: { rest in
        
           
        })
        
    }
    
    @IBAction func triInversion(_ sender: UIButton) {
        callServiceSurvey(num: "2")
        btGracias.isHidden = false
        gohome()
    }
    @IBAction func triDeudas(_ sender: UIButton) {
        callServiceSurvey(num: "3")
        btGracias.isHidden = false
        gohome()
    }
    @IBAction func triVivienda(_ sender: UIButton) {
        callServiceSurvey(num: "4")
        btGracias.isHidden = false
        gohome()
    }

    @IBAction func triLiquidez(_ sender: UIButton) {
        callServiceSurvey(num: "5")
        btGracias.isHidden = false
        gohome()
    }
    @IBAction func triEntretenimiento(_ sender: UIButton) {
        callServiceSurvey(num: "6")
        btGracias.isHidden = false
        gohome()
    }

    @IBAction func triEducacion(_ sender: UIButton) {
        callServiceSurvey(num: "7")
        btGracias.isHidden = false
        gohome()
    }
    @IBAction func triGracias(_ sender: UIButton) {
        
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "7" as NSObject,
            AnalyticsParameterItemName: "iconos_de_la_encuesta" as NSObject,
            AnalyticsParameterContentType: "cont" as NSObject
            ])
        
     
        

        
        
    }
    func gohome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            // Your code with delay
            self.performSegue(withIdentifier: "gohome", sender: self)
            

           //    _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
  


}

//
//  CertificacionesOfflineController.swift
//  MobileApp
//
//  Created by Pedro A. Daza Balaguera on 30/03/17.
//  Copyright © 2017 Old Mutual. All rights reserved.
//

import Foundation
import UIKit
import MicroBlink

class CertificacionesOfflineController : UIViewController, UITextFieldDelegate, PPScanningDelegate
{
    @IBOutlet weak var etTipoDocumento: UITextField!
    @IBOutlet weak var etNumeroDocumento: UITextField!
    
    @IBOutlet weak var btAfiliacion: UIButton!
    @IBOutlet weak var btTributario: UIButton!
    @IBOutlet weak var btExtracto: UIButton!
    @IBOutlet weak var btScanCamara: UIButton!

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //elf.navigationItem.backBarButtonItem?.title = ""
        
        etTipoDocumento.delegate = self
        etNumeroDocumento.delegate = self
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CertificacionesOfflineController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        
      // self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        var btn = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem=btn
        
        view.addGestureRecognizer(tap)
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:10, height:10));
        
        let image = UIImage(named: "logo");
        
        imageView.image = image;
        imageView.contentMode = UIViewContentMode.center
        
        //self.navigationItem.setHidesBackButton(false,animated:true);
        
       //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.view.addSubview(imageView);
        
        //view.addGestureRecognizer(tap)
        //self.navigationController?.navigationBar.topItem?.title = image;
        self.navigationItem.title = "Certificados sin Clave";

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.etTipoDocumento.resignFirstResponder()
            self.etNumeroDocumento.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.etTipoDocumento.resignFirstResponder()
        self.etNumeroDocumento.resignFirstResponder()
        dismissKeyboard()
        self.view.endEditing(true)
        return true
    }
    
    //Calls this function when the tap is recognized.
    @objc func  dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    
    
    @IBAction func triAfiliacion(_ sender: UIButton) {
        
       
    
        if (etTipoDocumento.text == "" || etNumeroDocumento.text == "")
        {
            
            ShowAlertError(view: self, Mensaje: "Por favor ingrese Tipo y número documento")
            //vcspinner.hideSpinner()
            
        }
        else
        {

            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
            vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vcspinner, animated: true, completion: nil)
            let params:NSDictionary = ["ipAddrres": "127.0.0.1"]
            GetCertificados(params: params, doc: etNumeroDocumento!.text!, typedoc: GetCodeList(ListCode: DOCCODE, Descripcion: etTipoDocumento!.text!, ListaDEscripcion: DOCTEXT), typecert: "MembershipCertificate", Ok: { res in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertInfo(view: self, Mensaje: res)
                })
                
                
                
                
            }, Errror: {error in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertError(view: self, Mensaje: error ?? "")
                })
                
            })

        }
    }
    @IBAction func triTributario(_ sender: UIButton) {
        
        if (etTipoDocumento.text == "" || etNumeroDocumento.text == "")
        {
            ShowAlertError(view: self, Mensaje: "Por favor ingrese Tipo y número documento")
            //vcspinner.hideSpinner()
        }
        else
        {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
            vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vcspinner, animated: true, completion: nil)
            let params:NSDictionary = ["ipAddrres": "127.0.0.1"]
            GetCertificados(params: params, doc: etNumeroDocumento!.text!, typedoc: GetCodeList(ListCode: DOCCODE, Descripcion: etTipoDocumento!.text!, ListaDEscripcion: DOCTEXT), typecert: "TaxCertificate", Ok: { res in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertInfo(view: self, Mensaje: res)
                })
                
            }, Errror: {error in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertError(view: self, Mensaje: error ?? "")
                })
                
                
            })

            
        }
        
    }
    
    @IBAction func triExtracto(_ sender: UIButton) {
        
        if (etTipoDocumento.text == "" || etNumeroDocumento.text == "")
        {
            ShowAlertError(view: self, Mensaje: "Por favor ingrese Tipo y número documento")
            //vcspinner.hideSpinner()
            
        }
        else
        {

            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
            vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vcspinner, animated: true, completion: nil)
            let params:NSDictionary = ["ipAddrres": "127.0.0.1"]
            GetCertificados(params: params, doc: etNumeroDocumento!.text!, typedoc: GetCodeList(ListCode: DOCCODE, Descripcion: etTipoDocumento!.text!, ListaDEscripcion: DOCTEXT), typecert: "Statement", Ok: { res in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertInfo(view: self, Mensaje: res)
                })
                
            }, Errror: {error in
                vcspinner.hideSpinnerCompletion(Ok: {
                    ShowAlertError(view: self, Mensaje: error!)
                })
            })
            
        }
        
        
    }
    
    
    func ValidateCamps(TipeCeritificate: String)
    {
        
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CertificacionesOfflineController.dismissKeyboard))
        if (etNumeroDocumento.text == "" || etTipoDocumento.text == "")
        {
            ShowAlertError(view: self, Mensaje: alMensajeLLenetodosloscampos)
            return
        }
        
        //postCertificadosOffline(view: self, numeroDocumento: etNumeroDocumento, tipoDocumento:etTipoDocumento, GetCodeList(ListCode: DOCCODE, Descripcion: etTipoDocumento!.text!, ListaDEscripcion: DOCTEXT), TipoCertificado: TipeCeritificate, IpAddress: "0.0.0.0")
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CertificacionesOfflineController.dismissKeyboard))
        if textField == etTipoDocumento
        {
            
            let _: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CertificacionesOfflineController.dismissKeyboard))
            
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let vcspinner = storyboard.instantiateViewController(withIdentifier: "PopupPickerViewController") as! PopupPickerViewController
            vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vcspinner.ReturnObject = { rest in
                self.etTipoDocumento.text = rest
                
            }
            self.present(vcspinner, animated: true)
            vcspinner.ShowPicker(Arre: DOCTEXT)
            view.endEditing(true)
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == etTipoDocumento
        {
            
        }
        else
        {
            
        }
        
        return true;
    }
    
    @IBAction func triScanCamera(_ sender: UIButton) {

            /** Instantiate the scanning coordinator */
            let error : NSErrorPointer = nil
            let coordinator : PPCameraCoordinator? = self.coordinatorWithError(error: error)
            
            /** If scanning isn't supported, present an error */
            if coordinator == nil {
                let messageString: String = (error!.pointee?.localizedDescription)!
                UIAlertView(title: "Warning", message: messageString, delegate: nil, cancelButtonTitle: "Ok").show()
                return
            }
            
            /** Create new scanning view controller */
            let scanningViewController: UIViewController = PPViewControllerFactory.cameraViewController(with: self, coordinator: coordinator!, error: nil)
            
            /** Present the scanning view controller. You can use other presentation methods as well (instead of presentViewController) */
            self.present(scanningViewController, animated: true, completion: nil)
        
    }
    /**
     * Method allocates and initializes the Scanning coordinator object.
     * Coordinator is initialized with settings for scanning
     * Modify this method to include only those recognizer settings you need. This will give you optimal performance
     *
     *  @param error Error object, if scanning isn't supported
     *
     *  @return initialized coordinator
     */
    private func coordinatorWithError(error: NSErrorPointer) -> PPCameraCoordinator? {
        
        /** 0. Check if scanning is supported */
        
        if PPCameraCoordinator.isScanningUnsupported(for: PPCameraType.back, error:error) {
            return nil
        }
        
        
        /** 1. Initialize the Scanning settings */
        
        // Initialize the scanner settings object. This initialize settings with all default values.
        let settings: PPSettings = PPSettings()
        
        
        /** 2. Setup the license key */
        
        // Visit www.microblink.com to get the license key for your app
        settings.licenseSettings.licenseKey = "2ASSGFRO-VEFPYRD6-GPFLZ2MX-J36EIPSX-ASR54XZA-U7Y75MKE-HZLQJI66-L4QPMK65"
        
        
        /**
         * 3. Set up what is being scanned. See detailed guides for specific use cases.
         * Remove undesired recognizers (added below) for optimal performance.
         */
        
        // Remove this code if you don't need to scan Pdf417
        do {
            // To specify we want to perform PDF417 recognition, initialize the PDF417 recognizer settings
            let ocrRecognizerSettings: PPPdf417RecognizerSettings = PPPdf417RecognizerSettings()
            
            /** You can modify the properties of pdf417RecognizerSettings to suit your use-case */
            
            // Add PDF417 Recognizer setting to a list of used recognizer settings
            settings.scanSettings.add(ocrRecognizerSettings)
        }
        
        // Remove this code if you don't need to scan QR codes
        do {
            // To specify we want to perform recognition of other barcode formats, initialize the ZXing recognizer settings
            let zxingRecognizerSettings: PPZXingRecognizerSettings = PPZXingRecognizerSettings()
            
            
            /** You can modify the properties of zxingRecognizerSettings to suit your use-case (i.e. add other types of barcodes like QR, Aztec or EAN)*/
            zxingRecognizerSettings.scanQR=true // we use just QR code
            
            // Add ZXingRecognizer setting to a list of used recognizer settings
            settings.scanSettings.add(zxingRecognizerSettings)
        }
        
        // Remove this code if you don't need to scan US drivers licenses
        do {
            // To specify we want to scan USDLs, initialize USDL rcognizer settings
            let usdlRecognizerSettings: PPUsdlRecognizerSettings = PPUsdlRecognizerSettings()
            
            /** You can modify the properties of usdlRecognizerSettings to suit your use-case */
            
            // Add USDL Recognizer setting to a list of used recognizer settings
            settings.scanSettings.add(usdlRecognizerSettings)
        }
        
        
        /** 4. Initialize the Scanning Coordinator object */
        
        let coordinator: PPCameraCoordinator = PPCameraCoordinator(settings: settings)
        
        return coordinator
    }
    
    func scanningViewController(_ scanningViewController: (UIViewController & PPScanningViewController)?, didOutputResults results: [PPRecognizerResult]) {
        
        let scanConroller: PPScanningViewController = scanningViewController as! PPScanningViewController
        
        /**
         * Here you process scanning results. Scanning results are given in the array of PPRecognizerResult objects.
         * Each member of results array will represent one result for a single processed image
         * Usually there will be only one result. Multiple results are possible when there are 2 or more detected objects on a single image (i.e. pdf417 and QR code side by side)
         */
        
        // If results are empty, continue scanning without any actions
        if (results.count == 0) {
            return
        }
        
        // first, pause scanning until we process all the results
        scanConroller.pauseScanning()
        
        var message: String = ""
        var title: String = ""
        
        var usdlFound = false;
        
        // Collect data from the result
        for result in results {
            if(result is PPUsdlRecognizerResult) {
                /** US drivers license was detected */
                
                let usdlResult = result as! PPUsdlRecognizerResult
                
                title = "USDL"
                
                // Get all USDL data as NSDictionary and save it in NSString form
                message = usdlResult.getAllStringElements().description
                
                usdlFound = true
                break
            }
        }
        
        // Collect other results
        
        if (!usdlFound) {
            for result in results {
                if(result is PPZXingRecognizerResult) {
                    /** One of ZXing codes was detected */
                    
                    let zxingResult = result as! PPZXingRecognizerResult
                    
                    title = "QR code"
                    
                    // Save the string representation of the code
                    message = zxingResult.stringUsingGuessedEncoding()
                }
                if(result is PPPdf417RecognizerResult) {
                    /** Pdf417 code was detected */
                    
                    let pdf417Result = result as! PPPdf417RecognizerResult
                    
                    title = "PDF417"
                    
                    // Save the string representation of the code
                    message = pdf417Result.stringUsingGuessedEncoding()
                }
                if(result is PPBarDecoderRecognizerResult) {
                    /** One of BarDecoder codes was detected */
                    
                    let barDecoderResult = result as! PPBarDecoderRecognizerResult
                    
                    title = "BarDecoder"
                    
                    // Save the string representation of the code
                    message = barDecoderResult.stringUsingGuessedEncoding()
                }
            }
        }
        
        let params = ["texto": message, "Dispositivo": "IOs"]
        
        PostDatosCedula(params: params as NSDictionary, Ok: { res in
            
            
            self.etNumeroDocumento.text = res
            self.etTipoDocumento.text = DOCTEXT[0]
            
            
        }, Errror: { err in
            message = message.lowercased()
            var ArString = message.components(separatedBy: "pubdsk_1")
            if ArString.count <= 1
            {
                ArString = message.components(separatedBy: "a  ")
                
                if ArString.count <= 1
                {
                    ArString = message.components(separatedBy: "b  ")
                    
                    if ArString.count <= 1
                    {
                        ArString = message.components(separatedBy: "n  ")
                        
                        if ArString.count <= 1
                        {
                            return
                        }
                        let Letras = "abcdefghijklmnopqrstuvwxyzñ"
                        var encontrado = false
                        var Numeros = ""
                        var Numero = "1234567890"
                        for charr in ArString[1].characters
                        {
                            for l in Letras.characters
                            {
                                if l == charr
                                {
                                    encontrado = true
                                    break
                                }
                                
                                
                            }
                            if encontrado
                            {
                                break
                            }
                            else
                            {
                                var esnumero = false
                                for n in Numero.characters
                                {
                                    if n == charr
                                    {
                                        esnumero = true
                                        break
                                        
                                    }
                                }
                                if esnumero
                                {
                                    Numeros = Numeros + "\(charr)"
                                }
                            }
                        }
                        
                        var string1 = Numeros
                        
                        var index1 = string1.index(string1.endIndex, offsetBy: -10)
                        var ncedula = string1.substring(from: index1)
                        
                        self.etNumeroDocumento.text = "\(String(describing: Int(ncedula)!))"
                        self.etTipoDocumento.text = DOCTEXT[0]
                        //etTipoDocumento.text = DOCTEXT[0]
                        // present the alert view with scanned results
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                    let Letras = "abcdefghijklmnopqrstuvwxyzñ"
                    var encontrado = false
                    var Numeros = ""
                    var Numero = "1234567890"
                    for charr in ArString[1].characters
                    {
                        for l in Letras.characters
                        {
                            if l == charr
                            {
                                encontrado = true
                                break
                            }
                            
                            
                        }
                        if encontrado
                        {
                            break
                        }
                        else
                        {
                            var esnumero = false
                            for n in Numero.characters
                            {
                                if n == charr
                                {
                                    esnumero = true
                                    break
                                    
                                }
                            }
                            if esnumero
                            {
                                Numeros = Numeros + "\(charr)"
                            }
                        }
                    }
                    
                    var string1 = Numeros
                    
                    var index1 = string1.index(string1.endIndex, offsetBy: -10)
                    var ncedula = string1.substring(from: index1)
                    
                    self.etNumeroDocumento.text = "\(String(describing: Int(ncedula)!))"
                    self.etTipoDocumento.text = DOCTEXT[0]
                    //etTipoDocumento.text = DOCTEXT[0]
                    // present the alert view with scanned results
                    self.dismiss(animated: true, completion: nil)
                    
                    return
                }
                let Letras = "abcdefghijklmnopqrstuvwxyzñ"
                var encontrado = false
                var Numeros = ""
                var Numero = "1234567890"
                for charr in ArString[1].characters
                {
                    for l in Letras.characters
                    {
                        if l == charr
                        {
                            encontrado = true
                            break
                        }
                        
                        
                    }
                    if encontrado
                    {
                        break
                    }
                    else
                    {
                        var esnumero = false
                        for n in Numero.characters
                        {
                            if n == charr
                            {
                                esnumero = true
                                break
                                
                            }
                        }
                        if esnumero
                        {
                            Numeros = Numeros + "\(charr)"
                        }
                    }
                }
                
                var string1 = Numeros
                
                var index1 = string1.index(string1.endIndex, offsetBy: -10)
                var ncedula = string1.substring(from: index1)
                
                self.etNumeroDocumento.text = "\(String(describing: Int(ncedula)!))"
                self.etTipoDocumento.text = DOCTEXT[0]
                //etTipoDocumento.text = DOCTEXT[0]
                // present the alert view with scanned results
                self.dismiss(animated: true, completion: nil)
                
                return;
            }
            
            let Letras = "abcdefghijklmnopqrstuvwxyzñ"
            var encontrado = false
            var Numeros = ""
            var Numero = "1234567890"
            for charr in ArString[1].characters
            {
                for l in Letras.characters
                {
                    if l == charr
                    {
                        encontrado = true
                        break
                    }
                    
                    
                }
                if encontrado
                {
                    break
                }
                else
                {
                    var esnumero = false
                    for n in Numero.characters
                    {
                        if n == charr
                        {
                            esnumero = true
                            break
                            
                        }
                    }
                    if esnumero
                    {
                        Numeros = Numeros + "\(charr)"
                    }
                }
            }
            
            var string1 = Numeros
            
            var index1 = string1.index(string1.endIndex, offsetBy: -10)
            var ncedula = string1.substring(from: index1)
            
            self.etNumeroDocumento.text = "\(String(describing: Int(ncedula)!))"
            self.etTipoDocumento.text = DOCTEXT[0]
            
        })
        self.dismiss(animated: true, completion: nil)
        /*let alertController: UIAlertController = UIAlertController.init(title: title, message: ncedula, preferredStyle: UIAlertControllerStyle.alert)
         
         let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default,
         handler: { (action) -> Void in
         
         })
         alertController.addAction(okAction)
         scanningViewController?.present(alertController, animated: true, completion: nil)*/
        
        
        
    }
    
  
    
    
    func scanningViewControllerUnauthorizedCamera(_ scanningViewController: UIViewController & PPScanningViewController) {
         // Add any logic which handles UI when app user doesn't allow usage of the phone's camera
    }
    
  
    func scanningViewController(scanningViewController: UIViewController, didFindError error: NSError) {
        // Can be ignored. See description of the method
    }
    
    
    func scanningViewControllerDidClose(_ scanningViewController: UIViewController & PPScanningViewController) {
        // As scanning view controller is presented full screen and modally, dismiss it
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    
    // dismiss the scanning view controller when user presses OK.
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scanningViewController(_ scanningViewController: UIViewController & PPScanningViewController, didFindError error: Error) {
        
    }
    
   
}


// GetDatos
func PostDatosCedula  (params:NSDictionary, Ok:@escaping ((String) -> Void), Errror:@escaping ((String!) -> Void))
{
    
    let url = "https://mobile.oldmutual.com.co/OM.MobileAffiliationsApi.Public/api/Cedula/"
    
    postDoc(params: params, url: url, Ok:{ res in Ok(res)

        
        
    }, Error: {error in
        
        Errror(error)
    })
}

func GetCertificados  (params:NSDictionary, doc:String, typedoc:String, typecert:String , Ok:@escaping ((String) -> Void), Errror:@escaping ((String!) -> Void))
{
    
    let url = BASEURLCERTIFICACION + "Certifications/post?docNumber=\(doc)&docType=\(typedoc)&certificationType=\(typecert)"

    getDic(params: params, url: url, Ok:{ res in
        
        
        let succes = res.object(forKey: "Success") as! Bool
        let Message = res.object(forKey: "Message") as! String
        if succes
        {
            Ok(Message)
        }else{
            Errror(Message)
        }
        
        
        

    }, Error: {error in
        
        Errror(error)
    })
}




func postDoc(params:NSDictionary, url:String, Ok:@escaping ((String) -> Void), Error:@escaping ((String!) -> Void))
{
    print("Parametros: \(params)")
    request(url, method: .post, parameters: params as! [String : AnyObject], encoding: URLEncoding.default)
        .responseData {response in
            if let err = response.result.error {
                print("error code: \(err.localizedDescription)")
                print("error: \(err.localizedDescription)")
                Error( "En el momento la aplicación no está disponible intente más tarde")
            }
            else
            {
                
                if let data = response.data{
                    
                    let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("puto json: \(str)")
                    var err: NSError?
                    var json:NSArray?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                    
                    
                    
                    do {
                        json = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                        // use anyObj here
                    } catch {
                        Error( "\(error)")
                        print("json error: \(error)")
                        return
                    }
                    print("error: \(json)")
                    
                    DispatchQueue.main.async() {
                        
                        if let Docnumber = (json![0] as AnyObject).object(forKey: "Documento")
                        {
                            Ok(Docnumber as! String)
                        }
                        else
                        {
                            Error("Error de codificacion")
                        }
                        
                    }
                }
                
            }
    }
}

    
    
func getDic(params:NSDictionary, url:String, Ok:@escaping ((NSDictionary) -> Void), Error:@escaping ((String!) -> Void))
    {
        /*let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let vcspinner = storyboard.instantiateViewController(withIdentifier: "SpinnerController") as! SpinnerController
        vcspinner.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vcspinner, animated: true, completion: nil)*/
        print("Parametros: \(params)")
        request(url, method: .post, parameters: params as! [String : AnyObject], encoding: URLEncoding.default)
            .responseData {response in
                if let err = response.result.error {
                    print("error code: \(err.localizedDescription)")
                    print("error: \(err.localizedDescription)")
                    Error( "En el momento la aplicación no está disponible intente más tarde")
                }
                else
                {
                    
                    if let data = response.data{
                        
                        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        print("puto json: \(str)")
                        var err: NSError?
                        var json:NSDictionary?// = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves) as? NSDictionary
                        
                        
                        
                        do {
                            json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                            // use anyObj here
                        } catch {
                            Error( "\(error)")
                            print("json error: \(error)")
                            return
                        }
                        print("error: \(json)")
                        
                        DispatchQueue.main.async() {

                                Ok(json!)
                            
                        }
                    }
                    
                }
        }
    
}




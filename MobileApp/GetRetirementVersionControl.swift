import Foundation
import  UIKit


class GetRetirementVersionControl: NSObject  {

    class func getRetirementVersionControl(controller:UIViewController, OS:String, Ok:@escaping ((RetirementVersionControlObject) -> Void))
{
    
    let ws = Ws()
    ws.getDictionary(view: controller, Ok: {ObjResponse in
        
        let Tetirement = RetirementVersionControlObject(dic: ObjResponse)
        
        
        Ok(Tetirement)
    }, Error: {errer in
        let alert = UIAlertController(title: "Apreciado Cliente", message: errer, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    },
       todoEndpointt: BASEURL + "/VersionInfo?os=IOS")
    
}
}

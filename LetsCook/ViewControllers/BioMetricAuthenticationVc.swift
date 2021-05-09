//
//  BioMetricAuthenticationVc.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/5/21.
//

import UIKit
import LocalAuthentication

class BioMetricAuthenticationVc: UIViewController {
    
    //MARK:- Variables
    var recipe:[Recipe] = []
    
   
//MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeApiCall()
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
   
    //MARK:- API Call
    func recipeApiCall(){
        CommonApi.callPostApi(url: baseURL, completionHandler:{
        rsult in
        self.recipe = rsult.map({Recipe.init(data: $0)})
    })
    }
    
    
//MARK:- IBActions
    @IBAction func authenticateOnTapButton(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self?.showToast(message: "Yayyy Authentication Successfull👏🏻")
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                        viewController?.recipe = self?.recipe ?? []
                        self?.navigationController?.pushViewController(viewController!, animated: true)
                        }
                        
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)        }
    }

    

}

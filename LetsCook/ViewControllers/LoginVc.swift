//
//  LoginVc.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/5/21.
//

import UIKit
import GoogleSignIn
class LoginVc: UIViewController, GIDSignInDelegate {
   
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
   
    //MARK:- Variables
    var recipe:[Recipe] = []

    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeApiCall()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        self.navigationController?.navigationBar.isHidden = true
        becomeFirstResponder()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
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
    @IBAction func submitButnAction(_ sender: UIButton) {
        if !(userNameTF.text?.isEmpty ?? false) && !(passwordTF.text?.isEmpty ?? false){
            self.showToast(message: "Yayyy Login Successfull👏🏻")
            UserDefaults.standard.set(true, forKey: kUserLoggedIn)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                vc?.recipe = self.recipe
                self.navigationController?.pushViewController(vc!, animated: true)
            }
           
        }else{
            let ac = UIAlertController(title: "", message: "Either username or password is incorrect", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    
    
    @IBAction func googleSignInButnAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    //MARK:- Google SignIn
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil{
          print(user.userID!)
          if let error = error {
           if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
           } else {
            print("\(error.localizedDescription)")
           }
           return
          }
            
            if let authToken = user.authentication.accessToken{
                print(authToken)
                self.showToast(message: "Yayyy Google Login Successfull👏🏻")
                UserDefaults.standard.set(true, forKey: kUserLoggedIn)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                vc?.recipe = self.recipe
                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            var userData = [String:Any]()
            userData["access"] = "gmailAccess"
            if let username = GIDSignIn.sharedInstance()?.currentUser.profile.name{
              userData["name"] = username
                print(username)
            }
            if let user_email = GIDSignIn.sharedInstance()?.currentUser.profile.email{
              userData["email"] = user_email
                //userNameTF.text = user_email
                print(user_email)
            }
            if let user_picture = GIDSignIn.sharedInstance()?.currentUser.profile.imageURL(withDimension: 100){
              userData["image"] = user_picture
                print(user_picture)
           }
        }
       
      }
    
}

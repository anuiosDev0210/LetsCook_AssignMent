//
//  AppDelegate.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/4/21.
//

import UIKit
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    

    var window: UIWindow?
    var navVC: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize sign-in
          GIDSignIn.sharedInstance().clientID = "71683839452-5de274hfv365ch3n59bv04elf40fv9gq.apps.googleusercontent.com"
          //GIDSignIn.sharedInstance().delegate = self

        if let isuserloggedIn = UserDefaults.standard.value(forKey: kUserLoggedIn) as? Bool{
            if isuserloggedIn{
            showAuthenticationVc()
            }else{
                showLoginVc()
            }
        }
        return true
    }

    

    func showLoginVc() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVc") as? LoginVc
        navVC = UINavigationController(rootViewController: vc!)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func showAuthenticationVc() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BioMetricAuthenticationVc") as? BioMetricAuthenticationVc
        navVC = UINavigationController(rootViewController: vc!)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
//              withError error: Error!) {
//      if let error = error {
//        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//          print("The user has not signed in before or they have since signed out.")
//        } else {
//          print("\(error.localizedDescription)")
//        }
//        return
//      }
//      // Perform any operations on signed in user here.
//      let userId = user.userID                  // For client-side use only!
//      let idToken = user.authentication.idToken // Safe to send to the server
//      let fullName = user.profile.name
//      let givenName = user.profile.givenName
//      let familyName = user.profile.familyName
//      let email = user.profile.email
//      // ...
//    }

}


//
//  ViewController.swift
//  LetsCook
//
//  Created by Anu Agrawal on 5/4/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    //MARK:- IBOutlets
    @IBOutlet weak var rTableview: UITableView!
    
    //MARK:- Variables
    var recipe:[Recipe] = []

  
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onTapLogOut))
        
    }
    
    
    
    
//MARK:- Tableview delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VuewControllerTableViewCell", for: indexPath) as! VuewControllerTableViewCell
        cell.title.text = recipe[indexPath.row].title
        cell.ingredients.text = recipe[indexPath.row].ingredients
        cell.foodImage.downloaded(from: recipe[indexPath.row].thumbnail!)
        cell.linkButn.addTarget(self, action: #selector(onTapLink(sender:)), for: .touchUpInside)
        cell.linkButn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/10 * 1.5
    }

    //MARK:- Buttton Action
    
    @objc func onTapLink(sender:UIButton){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        if let link = recipe[sender.tag].link{
            vc!.url = URL(string: link)
            self.navigationController?.pushViewController(vc!, animated: true)
        }

    }
    
    @objc func onTapLogOut(){
        kSharedAppDelegate.showLoginVc()
        GIDSignIn.sharedInstance().signOut()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}


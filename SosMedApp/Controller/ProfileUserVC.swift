//
//  ProfileUserVC.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 07/01/22.
//

import UIKit
import CoreData

class ProfileUserVC: UIViewController {
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var signOutBtn: UIButton!
    
    
    @IBAction func clickSignOut(_ sender: Any) {
        
        let alertWarning = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        
        alertWarning.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertWarning.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            //MARK: Remove ALL Sessions
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
        
            self.showToast(message: "Sign out success")
            
            DispatchQueue.main.async {() -> Void in
                let displayVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                displayVC.navigationItem.hidesBackButton = true
                displayVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(displayVC, animated: true)
            }
        }))
        
        present(alertWarning, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signOutBtn.layer.cornerRadius = 10
        signOutBtn.layer.masksToBounds = true
        getDataProfile()
    }
   
    func getDataProfile() {
        
        tfName.text = UserDefaults.standard.string(forKey: "name")
        tfAddress.text = UserDefaults.standard.string(forKey: "address")
        tfPhoneNo.text = UserDefaults.standard.string(forKey: "phone")
        tfUsername.text = UserDefaults.standard.string(forKey: "userName")
        tfEmail.text = UserDefaults.standard.string(forKey: "email")
    }
}

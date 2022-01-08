//
//  ViewController.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 07/01/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import Lottie
import CoreData

class SignInVC: UIViewController {
    
    var server = API()
    var users = [User]()
    var profileVC: ProfileUserVC?
    var rememberMeFlag = false
    //var userName, name, email, street, suite, city, zipcode, phone, address:String?
    var userName:String?
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var roundedView: UIView!
    
    
    @IBAction func clickSignInAction(_ sender: Any) {
        
        if tfUsername.text == "" && tfPassword.text == "" {
            
            self.showToast(message: "Please input your username and password to sign in.")
            
        } else if tfUsername.text == "" || tfPassword.text == "" {
        
            self.showToast(message: "Username or password are invalid")
            
        } else {
            
            if rememberMeFlag == true {
                
                UserDefaults.standard.set("1", forKey: "rememberme")
                UserDefaults.standard.set(tfUsername.text ?? "", forKey: "username")
                login()
            }
            else {
                
                UserDefaults.standard.set("2", forKey: "rememberme")
                login()
            }
        }
    }
    
    @IBAction func clickRememberBtn(_ sender: UIButton) {
        
        if rememberMeFlag == false {
            sender.setBackgroundImage(UIImage(named: "checkedBox"), for: .normal)
           
            rememberMeFlag = true
        } else {
            sender.setBackgroundImage(UIImage(named: "uncheckBox"), for: .normal)
           
            rememberMeFlag = false
        }
    }
    
    //MARK: Viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        animationLottie()
        customLayoutView()
       
        if userName == nil {
            
            checkAndAdd()
        }
        else {
            
            tfUsername.text = userName
        }
    }
    
    //MARK: REMEMBER BUTTON FUNCT
    func checkAndAdd() {
        
        if UserDefaults.standard.string(forKey: "rememberme") == "1" && userName != "" {
           
           if let image = UIImage(named: "checkedBox") {
               btnCheckBox.setBackgroundImage(image, for: .normal)
           }
           
           rememberMeFlag = true
           
           //SET VALUE
           self.tfUsername.text = UserDefaults.standard.string(forKey: "username") ?? ""
           
       }
       else {
           
           if let image = UIImage(named: "uncheckBox") {
               btnCheckBox.setBackgroundImage(image, for: .normal)
           }
           
           rememberMeFlag = false
       }
    }
    
    //MARK: login func
    func login() {
        self.showSpinner(onView: self.view)
        
        AF.request(server.baseUrlAPI + server.getUsers, method: .get) .responseJSON {(response) in
            
            switch response.result {
            
            case .success(let value):
                self.removeSpinner()
                
                let json = JSON(value)
                
                for i in 0 ..< json.count {
                    
                    let id = json[i]["id"].int
                    let name = json[i]["name"].stringValue
                    let userName = json[i]["username"].stringValue
                    let email = json[i]["email"].stringValue
                    let street = json[i]["address"]["street"].stringValue
                    let suite = json[i]["address"]["suite"].stringValue
                    let city = json[i]["address"]["city"].stringValue
                    let zipcode = json[i]["address"]["zipcode"].stringValue
                    let phone = json[i]["phone"].stringValue
                    
                    let address = "\(street), \(suite), \(city), \(zipcode)"
                  
                    self.users.append(User(id: id ?? 0, name: name, username: userName, email: email, address: address, phone: phone))
                }
                
                if let filterUser = self.users.filter({$0.username == self.tfUsername.text && $0.username == self.tfPassword.text}).first {
                   
                    UserDefaults.standard.setValue("success", forKey: "isLogin")
                    UserDefaults.standard.setValue(filterUser.id, forKey: "id")
                    UserDefaults.standard.setValue(filterUser.name, forKey: "name")
                    UserDefaults.standard.setValue(filterUser.username, forKey: "userName")
                    UserDefaults.standard.setValue(filterUser.email, forKey: "email")
                    UserDefaults.standard.setValue(filterUser.address, forKey: "address")
                    UserDefaults.standard.setValue(filterUser.phone, forKey: "phone")
                   
                    let displayTabBar = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! UITabBarController
                    displayTabBar.navigationItem.hidesBackButton = true
                    self.present(displayTabBar, animated: true, completion: nil)

                } else {
                    
                    UserDefaults.standard.setValue("failed", forKey: "isLogin")
                    self.showToast(message: "Username or password are invalid")
                }
               
                break
            case .failure(let error):
                self.removeSpinner()
                print("Error login : \(error.localizedDescription)")
                break
            }
        }
    }
    
    func customLayoutView(){
        
        roundedView.roundCorners(corners: [.topLeft, .topRight], radius: 50)
        btnSignIn.layer.cornerRadius = 10
        btnSignIn.layer.masksToBounds = true
    }
    
    //MARK: Animation view
    func animationLottie() {
        
        animationView.backgroundColor = .clear
        animationView.loopMode = .loop
        animationView.play()
    }
}


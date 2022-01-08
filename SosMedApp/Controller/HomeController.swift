//
//  HomeController.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 08/01/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeController: UIViewController {
    
    var postID:Int?
    var postTitle, postBody, nameUser, commentUser:String?
    var server = API()
    var userPosts = [Posts]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getUserPosts()
    }
    
    //MARK: Get user posts from API
    func getUserPosts(){
       
        AF.request(server.baseUrlAPI + server.getPosts).responseJSON {(response) in
         
            switch response.result {
            
            case .success(let value):
               
                let json = JSON(value)
               
                for i in 0 ..< json.count {
                    
                    self.postID = json[i]["id"].int
                    self.postTitle = json[i]["title"].stringValue
                    self.postBody = json[i]["body"].stringValue
                  
                    self.getUserComments(postID: self.postID ?? 0, postTitle: self.postTitle ?? "", postBody: self.postBody ?? "")
                }
                
                
            case .failure(let error):
               
                print("Error get user post : \(error.localizedDescription)")
            }
            self.tableView.reloadData()
        }
    }
    
    //MARK: Get user comments
    func getUserComments(postID: Int, postTitle: String, postBody: String){
        
        AF.request(server.baseUrlAPI + server.getPosts + "/\(postID)/" + server.getComments).responseJSON {(response) in
         
            switch response.result {
            
            case .success(let value):
                
                let json = JSON(value)
                
                for i in 0 ..< json.count {
                    
                    self.nameUser = json[i]["name"].stringValue
                    self.commentUser = json[i]["body"].stringValue
                    
                    self.userPosts.append(Posts(postId: postID, titlePost: postTitle, bodyPost: postBody, totalComments: json.count, nameOfUser: self.nameUser ?? "", comment: self.commentUser ?? ""))
                }
            
            case .failure(let error):
                print("Error get user comment : \(error.localizedDescription)")
            }
            self.tableView.reloadData()
        }
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userPosts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataPosts = userPosts[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell") as! HomeTableCell
        
        cell.getUserPosts(posts: dataPosts)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        let bodyPost = userPosts[indexPath.row].bodyPost
        let name = userPosts[indexPath.row].nameOfUser
        let postId = userPosts[indexPath.row].postId
        
        if cell?.isSelected == true {
            
            let displayDetailVC = storyboard?.instantiateViewController(withIdentifier: "DetailPostVC") as! DetailPostVC
            
            displayDetailVC.bodyPost = bodyPost
            displayDetailVC.nameUser = name
            displayDetailVC.postID = postId
            
            navigationController?.pushViewController(displayDetailVC, animated: true)
        }
    }
}

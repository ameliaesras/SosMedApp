//
//  DetailPostVC.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 08/01/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailPostVC: UIViewController {
    
    var server = API()
    var post = [Posts]()
    var nameUser, bodyPost:String?
    var postID = 0
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var lblNamePost: UILabel!
    @IBOutlet weak var lblBodyPost: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundedView.dropShadow()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        lblNamePost.text = nameUser
        lblBodyPost.text = bodyPost
    
        getCommentsPost()
    }
    
    func getCommentsPost() {
        
        AF.request(server.baseUrlAPI + server.getPosts + "/\(postID)/" + server.getComments, method: .get).responseJSON {(response) in
        
            switch response.result {
            
            case .success(let value):
                
                let json = JSON(value)
                
                for i in 0 ..< json.count {
                    
                    let nameUser = json[i]["name"].stringValue
                    let comments = json[i]["body"].stringValue
                    
                    self.post.append(Posts(postId: 0, titlePost: "", bodyPost: "", totalComments: 0, nameOfUser: nameUser, comment: comments))
                }
                
            case .failure(let error):
                print("Error get comments : \(error.localizedDescription)")
            }
            self.tableView.reloadData()
        }
    }

}

extension DetailPostVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return post.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataPost = post[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCommentsTableCell") as! UserCommentsTableCell
        
        cell.getCommentOfUser(post: dataPost)
        
        return cell
    }
}

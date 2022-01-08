//
//  Posts.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 08/01/22.
//

import Foundation

class Posts {
    
    var postId:Int
    var titlePost:String
    var bodyPost:String
    var totalComments:Int
    var nameOfUser:String
    var comment: String
    
    init(postId:Int, titlePost:String, bodyPost:String, totalComments:Int, nameOfUser:String, comment: String) {
        
        self.postId = postId
        self.titlePost = titlePost
        self.bodyPost = bodyPost
        self.totalComments = totalComments
        self.nameOfUser = nameOfUser
        self.comment = comment
    }
}

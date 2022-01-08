//
//  UserCommentsTableCell.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 08/01/22.
//

import UIKit

class UserCommentsTableCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    func getCommentOfUser(post: Posts){
        
        roundedView.dropShadow()
        name.text = post.nameOfUser
        comments.text = post.comment
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  HomeTableCell.swift
//  SosMedApp
//
//  Created by Amelia Esra S on 08/01/22.
//

import UIKit

class HomeTableCell: UITableViewCell {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblTotalComments: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    

    func getUserPosts(posts: Posts){
        
        roundedView.dropShadow()
        nameUser.text = posts.nameOfUser
        lblTitle.text = posts.titlePost
        lblBody.text = posts.bodyPost
        lblTotalComments.text = String(posts.totalComments)
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

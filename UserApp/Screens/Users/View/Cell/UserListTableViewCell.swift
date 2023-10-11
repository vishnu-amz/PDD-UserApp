//
//  UserListTableViewCell.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var viewUserCard: UIView!
    @IBOutlet weak var viewImageOrTitle: ImageOrTitle!
    @IBOutlet weak var lblFirstAndLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    
    //MARK: - Objects
    var index: Int?
    var user: UserData? {
        didSet {
            userData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Methods
    func userData() {
        viewUserCard.tableCellCardShadow()
        lblFirstAndLastName.text = "\(user?.firstName ?? "") \(user?.lastName ?? "")"
        lblEmail.text = user?.email
        viewImageOrTitle.layer.borderWidth = 0.6
        viewImageOrTitle.layer.borderColor = UIColor.lightGray.cgColor
        viewImageOrTitle.layer.cornerRadius = viewImageOrTitle.frame.height / 2
        viewImageOrTitle.layer.masksToBounds = true
        let userFirstNameInitial = user?.firstName?.first.map { "\($0)" } ?? ""
        let userLastNameInitial = user?.lastName?.first.map { "\($0)" } ?? ""
        let fullNameInitials = userFirstNameInitial + userLastNameInitial
        
        guard let index else {
            return
        }
        if index % 2 == 0 {
            if let url = URL(string: user?.avatar ?? "") {
                viewImageOrTitle.imgUserAvatar.setImage(withURL: url, placeholder: UIImage(named: Constant.ImageAssets.thumbnail))
                viewImageOrTitle.lblUserNameStartingLetter.isHidden = true
                viewImageOrTitle.imgUserAvatar.isHidden = false
            }
        } else {
            viewImageOrTitle.lblUserNameStartingLetter.isHidden = false
            viewImageOrTitle.imgUserAvatar.isHidden = true
            viewImageOrTitle.lblUserNameStartingLetter.text = fullNameInitials
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

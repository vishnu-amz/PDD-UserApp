//
//  ImageOrTitle.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import UIKit

class ImageOrTitle: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var lblUserNameStartingLetter: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK: - Methods
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed(Constant.XibClass.imageOrTitle, owner: self)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

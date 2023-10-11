//
//  UserDetailsViewController.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFIeldLastName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    
    
    //MARK: Objects
    var userDetailsViewModel = UserDetailsViewModel()
    var user: UserData?
    
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldFirstName.delegate = self
        txtFIeldLastName.delegate = self
        txtFieldEmail.delegate = self
        navigationItem.title = Constant.Screens.userDetails
        self.hideKeyboardWhenTappedAround()
        userDetails()
        fieldValidation()
    }
    
    //MARK: Methods
    func userDetails() {
        if let url = URL(string: user?.avatar ?? "") {
            imgUser.setImage(withURL: url, placeholder: UIImage(named: Constant.ImageAssets.thumbnail))
        }
        txtFieldFirstName.text = user?.firstName ?? ""
        txtFIeldLastName.text = user?.lastName ?? ""
        txtFieldEmail.text = user?.email ?? ""
    }
    
    func fieldValidation() {
        userDetailsViewModel.txtFieldValidation = { [weak self] validationHandler in
            switch validationHandler {
            case .fieldIsEmpty :
                self?.alertMessage(title: Constant.ErrorMessage.emptyTitle, message: Constant.ErrorMessage.fieldEmptyDescrption, submit: Constant.ErrorMessage.ok)
            case .emailIsNotValid :
                self?.alertMessage(title: Constant.ErrorMessage.validate, message: Constant.ErrorMessage.validEmail, submit: Constant.ErrorMessage.ok)
            case .emailIsValid :
                let _ = UIViewController.instantiateFromStoryboard(Constant.Storyboard.main, identifier: Constant.StoryboardIdentifiers.userListVC) as? UserListViewController
                self?.userDetailsViewModel.sendDataToSource(self?.userDetailsViewModel.firstName ?? "", self?.userDetailsViewModel.lastName ?? "", self?.userDetailsViewModel.email ?? "")
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //MARK: Actions
    @IBAction func btnSaveClicked(_ sender: Any) {
        userDetailsViewModel.firstName = txtFieldFirstName.text ?? ""
        userDetailsViewModel.lastName = txtFIeldLastName.text ?? ""
        userDetailsViewModel.email = txtFieldEmail.text ?? ""
        userDetailsViewModel.isValid = isValidEmail(txtFieldEmail.text ?? "")
        
        userDetailsViewModel.validateFields()
    }
}

//MARK: UITextFieldDelegate
extension UserDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

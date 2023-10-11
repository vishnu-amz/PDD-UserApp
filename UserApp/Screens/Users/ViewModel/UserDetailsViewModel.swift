//
//  UserDetailsViewModel.swift
//  UserApp
//
//  Created by Vishnu - iOS on 11/10/23.
//

import Foundation


final class UserDetailsViewModel {
    
    //MARK: - Objects
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var isValid = Bool()
    
    var updatedData: ((String, String, String) -> Void)?
    var txtFieldValidation: ((ValidationChecker) -> Void)?
    
    //MARK: - Methods
    func sendDataToSource(_ fistName: String, _ lastName: String, _ email: String) {
        updatedData?(fistName, lastName, email)
    }
    
    func validateFields() {
        guard (!firstName.isEmpty && !email.isEmpty) || !lastName.isEmpty else {
            txtFieldValidation?(.fieldIsEmpty)
            return
        }
        guard isValid else {
            txtFieldValidation?(.emailIsNotValid)
            return
        }
        txtFieldValidation?(.emailIsValid)
    }
}

extension UserDetailsViewModel {
    enum ValidationChecker {
        case emailIsValid
        case emailIsNotValid
        case fieldIsEmpty
    }
}

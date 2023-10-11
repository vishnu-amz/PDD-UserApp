//
//  UIViewController+.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    // email validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    // instantiate viewcontroller
    static func instantiateFromStoryboard<T: UIViewController>(_ storyboardName: String, identifier: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Failed to instantiate view controller with identifier '\(identifier)' from storyboard '\(storyboardName)'.")
        }
        return viewController
    }
    
    // error alert
    func alertMessage(title: String, message: String, submit: String? = nil){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            guard submit == nil else{
                alert.addAction(UIAlertAction(title: submit, style: .default, handler: nil))
                return
            }
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    // manage keyboard
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

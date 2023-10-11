//
//  UINavigationController+.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation
import UIKit

extension UINavigationBarAppearance {
    
    // configure navigationbar
    func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor.black
        self.configureWithOpaqueBackground()
        self.backgroundColor = .orange
        self.shadowImage = nil
        self.shadowColor = nil
        UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = self
        UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = self
    }
}

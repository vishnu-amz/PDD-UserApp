//
//  Constants.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation

enum Constant {
    enum Api {
        static var baseURL = "https://reqres.in/api/users?page="
    }
    
    enum Screens {
        static var userDetails = "User Details"
    }
    
    enum CellIdentifiers {
        static var userListCell = "UserListCell"
    }
    
    enum StoryboardIdentifiers {
        static var userListVC = "UserListViewController"
        static var userDetailsVC = "UserDetailsViewController"
    }
    
    enum XibClass {
        static var imageOrTitle = "ImageOrTitle"
    }
    
    enum Storyboard {
        static var main = "Main"
    }
    
    enum ErrorMessage {
        static var oops = "Oops!"
        static var connectInternet = "Please Connect Internet"
        static var ok = "Ok"
        
        static var emptyTitle = "Fields Cannot be Empty"
        static var fieldEmptyDescrption = "UserName and Email is Mandatory"
        static var validEmail = "Please enter valid Email"
        static var validate = "Validation Error"
        static var incorrectEmail = "Email or Password is wrong"
    }
    
    enum ImageAssets {
        static var thumbnail = "Thumbnail.png"
    }
}

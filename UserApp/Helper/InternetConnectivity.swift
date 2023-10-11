//
//  InternetConnectivity.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

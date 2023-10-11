//
//  UserViewModel.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation

final class UserViewModel {
    
    //MARK: - Objects
    var eventHandler: ((_ event: Event) -> Void)?
    var noIntenetAvailability: (() -> Void)?
    var response: User?
    var currentPage = 1
    
    //MARK: - Methods
    func checkInternetAvailability() {
        guard Connectivity.isConnectedToInternet() else {
            noIntenetAvailability?()
            return
        }
    }
    
    func fetchData() {
        self.eventHandler?(.loadingStart)
        ApiManger.shared.fetchData(page: currentPage) {(result: Result<User, DataError>) in
            self.eventHandler?(.loadingStops)
            switch result {
            case .success(let response):
                if self.response == nil {
                    self.response = response
                } else {
                    self.response?.page = response.page
                    self.response?.data.append(contentsOf: response.data)
                }
                self.currentPage += 1
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UserViewModel {
    enum Event {
        case loadingStart
        case loadingStops
        case dataLoaded
        case message(Error?)
    }
}

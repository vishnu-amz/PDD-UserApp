//
//  ViewController.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import UIKit

class UserListViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var tblViewUserList: UITableView!
    
    //MARK: - Objects
    private var userViewModel = UserViewModel()
    static var selectedIndexPath = Int()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Methods
    func configure() {
        observeErrorAlert()
        userViewModel.checkInternetAvailability()
        tblViewUserList.dataSource = self
        tblViewUserList.delegate = self
        initViewModel()
    }
    
    func initViewModel() {
        userViewModel.fetchData()
        observeEvents()
    }
    
    func observeErrorAlert() {
        userViewModel.noIntenetAvailability = { [weak self] in
            self?.alertMessage(title: Constant.ErrorMessage.oops, message: Constant.ErrorMessage.connectInternet, submit: Constant.ErrorMessage.ok)
        }
    }
    
    func observeEvents() {
        DispatchQueue.main.async {
            LoadingOverlay.shared.showOverlay(view: self.view)
        }
        userViewModel.eventHandler = { [weak self] eventHandler in
            switch eventHandler {
            case .loadingStart:
                print("loadingStarts")
            case .loadingStops:
                print("loadingStops")
            case .dataLoaded:
                DispatchQueue.main.async {
                    LoadingOverlay.shared.hideOverlayView()
                    self?.tblViewUserList.reloadData()
                }
            case .message(let err):
                print(err ?? "")
            }
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.response?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblViewUserList.dequeueReusableCell(withIdentifier: Constant.CellIdentifiers.userListCell) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        cell.index = indexPath.row
        cell.user = userViewModel.response?.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let users = userViewModel.response?.data.count {
            if indexPath.row == users - 1 {
                if users < userViewModel.response?.total ?? 0 {
                    initViewModel()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserListViewController.selectedIndexPath = indexPath.row
        let selectedIndex = UserListViewController.selectedIndexPath
        let userDetailsViewController = UIViewController.instantiateFromStoryboard(Constant.Storyboard.main, identifier: Constant.StoryboardIdentifiers.userDetailsVC) as? UserDetailsViewController
        userDetailsViewController?.userDetailsViewModel.updatedData = { [weak self] firstName, lastName, email in
            self?.userViewModel.response?.data[selectedIndex].firstName = firstName
            self?.userViewModel.response?.data[selectedIndex].lastName = lastName
            self?.userViewModel.response?.data[selectedIndex].email = email
            DispatchQueue.main.async {
                self?.tblViewUserList.reloadData()
            }
        }
        userDetailsViewController?.user = userViewModel.response?.data[indexPath.row]
        self.navigationController?.pushViewController(userDetailsViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userViewModel.response?.data.remove(at: indexPath.row)
            if let pageTotal = userViewModel.response?.total {
                userViewModel.response?.total = pageTotal - 1
            }
            tblViewUserList.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//
//  ViewController.swift
//  AxonTestTask
//
//  Created by Aleksei Chupriienko on 12.03.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let service = RandomUserService()
    private var users: [User] = []
    private var currentPage = 1
    private var isLoading = false
    
    @IBOutlet weak var usersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.tableFooterView = UIView()
        navigationItem.title = ScreenConstants.mainScreenTitle
        updateList()
    }
    private func updateList() {
        isLoading = true
        service.fetchUsers(page: currentPage) { [weak self] (fetchedUsers) in
            self?.users.append(contentsOf: fetchedUsers)
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.usersTableView.reloadData()
            }
        }
        currentPage += 1
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstants.cellIdentifier, for: indexPath) as? UserCell else {
            fatalError("could not configure cell")
        }
        let user = users[indexPath.row]
        cell.setup(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(integerLiteral: ScreenConstants.rowHeight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == users.count - 3, !isLoading else { return }
        updateList()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: ScreenConstants.storyboardName, bundle: nil)
        guard let details = storyboard.instantiateViewController(withIdentifier: ScreenConstants.detailViewControllerIdentifier) as? DetailViewController else { return }
        let user = users[indexPath.row]
        details.user = user
        details.navigationItem.title = user.name.first
        show(details, sender: nil)
    }
}

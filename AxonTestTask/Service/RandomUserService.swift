//
//  RandomUserService.swift
//  AxonTestTask
//
//  Created by Aleksei Chupriienko on 12.03.2020.
//  Copyright © 2020 Aleksei Chupriienko. All rights reserved.
//

import Foundation

struct RandomUserService {
    private let session = URLSession.shared
    func fetchUsers(page: Int, completion: @escaping (([User]) -> Void)) {
        guard let url = URL(string: "https://randomuser.me/api/?page=\(page)&results=20&seed=abc") else {
            print("not valid url")
            return
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                return
            }
            switch response.statusCode {
            case 200:
                do {
                    let usersResult = try UsersResult.decode(fromData: data)
                    completion(usersResult.results)
                } catch let error {
                    print(error.localizedDescription)
                }
            default:
                fatalError()
            }
        }
        task.resume()
    }
}

//
//  ViewController.swift
//  NativeNetwoking
//
//  Created by 20514535 on 02/05/2023.
//  Copyright (c) 2023 20514535. All rights reserved.
//

import UIKit
import NativeNetwoking

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostsAPIClient.fetchPosts {[weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts ?? []
                self?.tableView.reloadData()
            
            case .failure(let error):
                print(error.description)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = post.title
        return cell
    }
}

struct Post: Codable {
    let userId, id: Int
    let title, body: String
}

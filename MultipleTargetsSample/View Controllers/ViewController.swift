//
//  ViewController.swift
//  MultipleTargetsSample
//
//  Created by Farrukh Javeid on 29/09/2018.
//  Copyright © 2018 The Right Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    fileprivate var photos: [Photo]!
    fileprivate var users: [Users]!

    //MARK:- UIView Controller Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //initialization
        photos = [Photo]()
        users = [Users]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        #if PhotosType
            self.title = "Photos"
        #else
            self.title = "Users"
        #endif

        //tableview
        tableView.estimatedRowHeight = 44.0
        
        //get content from the server
        loadScreenContent()
    }

    //MARK:- UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        #if PhotosType
            return photos.count
        #else
            return users.count
        #endif
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        #if PhotosType

            if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell {
                
                cell.selectionStyle = .none
                cell.configureCell(photo: photos[indexPath.row])
                return cell
            }
        
        #else
        
            if let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
                
                cell.selectionStyle = .none
                cell.configureCell(user: users[indexPath.row])
                return cell
            }
        
        #endif
        
        return UITableViewCell()
    }
}

extension ViewController {
    
    //MARK:- Load Screen Content
    fileprivate func loadScreenContent() {
        
        var urlString: String!
        
        #if PhotosType
            urlString = "https://jsonplaceholder.typicode.com/photos"
        #else
            urlString = "https://jsonplaceholder.typicode.com/users"
        #endif

        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, urlResponse, error) in
                
                if (error != nil) {
                    //we got error from service
                    //handle error here
                    
                } else {

                    //No error
                    if let jsonString = String(data: data!, encoding:String.Encoding.utf8) {
                        
                        #if PhotosType
                            self.photos = self.getPhotosFromJsonString(jsonString: jsonString)
                        #else
                            self.users = self.getUsersFromJsonString(jsonString: jsonString)
                        #endif
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    fileprivate func getPhotosFromJsonString(jsonString: String) -> [Photo] {
        
        var photosToReturn = [Photo]()
        
        do {
            let photosArray = try JSONSerialization.jsonObject(with: jsonString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, options: .allowFragments) as! [[String:Any]]
            
            for photoDictionay in photosArray {
            
                var title = ""
                if let currentPhotoTitle = photoDictionay["title"] as? String {
                    title = currentPhotoTitle
                }
                
                var thumbnailUrl = ""
                if let currentPhotoImageUrl = photoDictionay["thumbnailUrl"] as? String {
                    thumbnailUrl = currentPhotoImageUrl
                }

                let photo = Photo(photoTitle: title, photoUrl: thumbnailUrl)
                photosToReturn.append(photo)
            }
        } catch  {
            
            //an exception has occured
        }

        return photosToReturn
    }
    
    fileprivate func getUsersFromJsonString(jsonString: String) -> [Users] {
        
        var usersToReturn = [Users]()
        
        do {
            let usersArray = try JSONSerialization.jsonObject(with: jsonString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, options: .allowFragments) as! [[String:Any]]
            
            for userDictionay in usersArray {
                
                var name = ""
                if let currentUserName = userDictionay["name"] as? String {
                    name = currentUserName
                }
                                
                let user = Users(userName: name)
                usersToReturn.append(user)
            }
        } catch  {
            
            //an exception has occured
        }
        
        return usersToReturn
    }
}

//MARK:- Models
struct Photo {
    let photoTitle: String!
    let photoUrl: String!
}

struct Users {
    let userName: String!
}

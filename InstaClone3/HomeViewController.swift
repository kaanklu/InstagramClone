//
//  HomeViewController.swift
//  InstaClone3
//
//  Created by Kaan Kalaycıoğlu on 9.03.2023.
//

import UIKit
import Firebase
import SDWebImage
class HomeViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var postedByArray = [String]()
    var likesArray = [Int]()
    var imageUrlArray=[String]()
    var postCommentArray = [String]()
    var documentIDArray = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getdataFirebase()
    }
    func getdataFirebase() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if snapshot?.isEmpty != true && snapshot != nil {
                self.postedByArray.removeAll(keepingCapacity: false)
                self.likesArray.removeAll(keepingCapacity: false)
                self.imageUrlArray.removeAll(keepingCapacity: false)
                self.postCommentArray.removeAll(keepingCapacity: false)
                
                
                for document in snapshot!.documents {
                    if let documentID = document.documentID as? String {
                        self.documentIDArray.append(documentID)
                    }
                    if let postedBy = document.get("postedBy") {
                        self.postedByArray.append(postedBy as! String)
                    }
                    if let like = document.get("likes") as? Int {
                        self.likesArray.append(like)
                    }
                    if let imageUrl = document.get("imageurl") as? String {
                        self.imageUrlArray.append(imageUrl)
                    }
                    if let comment = document.get("postComment") as? String {
                        self.postCommentArray.append(comment)
                    }
                    
                    self.tableView.reloadData()
                    
                    
                }
                
                
                
            }
        }
        
        
        
        
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postedByArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! HomeCell
        
        //
        cell.imageView1.sd_setImage(with: URL(string: imageUrlArray[indexPath.row]))
        cell.commentLabel.text = postCommentArray[indexPath.row]
        cell.likeCounter.text = String(likesArray[indexPath.row])
        cell.mailLabel.text = postedByArray[indexPath.row]
        cell.hiddenIDLabel.text = documentIDArray[indexPath.row]
        return cell
    }
    


}

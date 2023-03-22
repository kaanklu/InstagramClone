//
//  UploadViewController.swift
//  InstaClone3
//
//  Created by Kaan Kalaycıoğlu on 9.03.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var commentTF: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        imageView.addGestureRecognizer(gestureRecogniser)
    }
    func makeAlert(titleInput : String, messegeInput : String) {
        let alert = UIAlertController(title: titleInput, message: messegeInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    @objc func choosePicture() {
    let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        var uuidString = UUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        let imageData = imageView.image?.jpegData(compressionQuality: 0.5)
        let imageRef = mediaFolder.child("\(uuidString).jpg")
        imageRef.putData(imageData!) { storedmetadata, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
              imageRef.downloadURL { url, error in
                    if error==nil {
                        let url = url?.absoluteString
                        print("URL ----->>  \(url ?? "url not found.")")
                        
                        //DATABASE
                        
                        let firestoreDatabase = Firestore.firestore()
                        var firestoreRef : DocumentReference? = nil
                        let firestorePost = ["imageurl" : url!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentTF.text ?? "", "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                        
                        firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                            if error != nil {
                                self.makeAlert(titleInput: "Error", messegeInput: error?.localizedDescription ?? "undefined error")
                            }
                            else {
                                self.tabBarController?.selectedIndex = 0
                                self.commentTF.text = ""
                                self.imageView.image = UIImage()
                            
                            }
                                
                                
                                
                        })
                            
                        }
                        
                        
                        
                    }
                }
            }
        }
        
        
    }
    
   



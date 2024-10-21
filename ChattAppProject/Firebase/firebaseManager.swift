//
//  firebaseManager.swift
//  ChattAppProject
//
//  Created by jacqueline Ngigi on 2024-10-21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private init() {}
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseAuth", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(user))
        }
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(NSError(domain: "FirebaseAuth", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(user))
        }
    }
    
    func uploadImage(imageData: Data, toPath path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "FirebaseStorage", code: 0, userInfo: nil)))
            return
        }
        
        let storageRef = Storage.storage().reference(forURL: "/images/\(path)")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(NSError(domain: "FirebaseStorage", code: 0, userInfo: nil)))
                    return
                }
                
                completion(.success(url))
            }
        }
    }
    
    func downloadImage(fromURL url: URL, completion: @escaping (Result<Data?, Error>) -> Void) {
        let storageRef = Storage.storage().reference(forURL: url.absoluteString)
        
        storageRef.getData(maxSize: 1024 * 1024 * 5) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "FirebaseStorage", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
    }
}
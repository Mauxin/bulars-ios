//
//  Requester.swift
//  Bulars
//
//  Created by Murilo Dias on 15/01/19.
//  Copyright © 2019 Murilo Dias. All rights reserved.
//

import UIKit
import Firebase

/*class Requester {
    
    private let db: Firestore
    
    init() {
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    func getDocuments(in collection: FirebaseCollection, completion: @escaping (Result<[DocumentSnapshot]>) -> Void) {
        db.collection(collection.rawValue).getDocuments() { snapshot, error in
            if let error = error {
                return completion(Result.failure(error))
            }
            
            guard let snapshot = snapshot else {
                return completion(Result.failure(Error.invalidSnapshot))
            }
            
            completion(Result.success(snapshot.documents))
        }
    }
    
    func getDocuments(for references: [DocumentReference], completion: @escaping (Result<[DocumentSnapshot]>) -> Void) {
        concurrentRequests(items: references, request: { reference, completion in
            self.getDocument(for: reference, completion: completion)
        }, completion: completion)
    }
    
    func getDocumentWith(id: String, firebaseCollection: FirebaseCollection, completion: @escaping (Result<QuerySnapshot>) -> Void) {
        db.collection(firebaseCollection.rawValue).whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                return completion(Result.failure(error))
            } else {
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
                
                guard let snapshot = snapshot else {
                    return completion(Result.failure(Error.invalidSnapshot))
                }
                
                completion(Result.success(snapshot))
            }
        }
    }
}*/

//
//  WebResultViewModel.swift
//  Bulars
//
//  Created by Murilo Dias on 21/01/19.
//  Copyright © 2019 Murilo Dias. All rights reserved.
//
import SwiftSoup
import Firebase

// swiftlint:disable force_unwrapping
// swiftlint:disable force_cast
// swiftlint:disable force_try

class WebResultViewModel {
    
    let db: Firestore
    let medicateURL: URL
    
    init(url: URL) {
        self.medicateURL = url
        self.db = Firestore.firestore()
    }
    
    func getDescriptionFor(medicate: String, completion: @escaping (String) -> Void) {
        db.collection(Localized.collection).whereField(Localized.name, isEqualTo: medicate).getDocuments { querySnapshot, err in
            if err != nil {
                print(Localized.error)
            } else if !(querySnapshot?.documents.isEmpty)! {
                for document in querySnapshot!.documents {
                    let medicate = document.data()
                    completion(medicate[Localized.description] as! String)
                }
            } else {
                completion(self.getDescriptionFromWeb(medicate))
            }
        }
    }
    
    private func getDescriptionFromWeb(_ medicate: String) -> String {
        let doc: Document = try! SwiftSoup.parse(String(contentsOf: medicateURL))
        //TODO: empty state
        let body: Element? = try! doc.body()?.getElementById(Localized.body)
        
        let headers: [Element] = try! body?.getElementsByTag(Localized.headers).array() ?? []
        let texts: [Element] = try! body?.getElementsByTag(Localized.htmlTexts).array() ?? []
        
        var myText = ""
        var counter = 0
        
        while counter < headers.count {
            myText.append("\n\n")
            myText.append(try! headers[counter].text())
            
            myText.append("\n\n")
            myText.append("       " + (try! texts[counter].text()))
            
            counter += 1
        }
        
        addMedicateToDB(medicate, description: myText)
        return myText
    }
    
    private func addMedicateToDB(_ medicate: String, description: String) {
        var ref: DocumentReference?
        
        ref = db.collection(Localized.collection).addDocument(data: [
            Localized.name: medicate,
            Localized.description: description
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}

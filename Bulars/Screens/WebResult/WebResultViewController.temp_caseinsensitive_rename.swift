import UIKit
import SwiftSoup
import Firebase

// swiftlint:disable force_cast
// swiftlint:disable force_try
// swiftlint:disable force_unwrapping
class WebResultViewController: UIViewController {
    
    @IBOutlet weak var textContent: UITextView!
    
    let medicateURL: URL?
    let medicate: String
    let db = Firestore.firestore()
    
    init(medicate: String) {
        self.medicate = medicate.replacingOccurrences(of: " ", with: "_").lowercased()
        self.medicateURL = URL(string: "https://www.bulario.com/" + self.medicate + "/")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = medicate.capitalized
        textContent.text = ""
        updateNavigationBar()
        //showLoading()
        
        getDescriptionFor(medicate: medicate.lowercased()) { description in
            //self.dismissLoading()
            self.textContent.text = description
        }
    }
    
    private func getDescriptionFor(medicate: String, completion: @escaping (String) -> Void) {
        db.collection("medicates").whereField("name", isEqualTo: medicate).getDocuments { querySnapshot, err in
            if err != nil {
                print("Erro")
            } else if !(querySnapshot?.documents.isEmpty)! {
                for document in querySnapshot!.documents {
                    let medicate = document.data()
                    completion(medicate["medicineBottle"] as! String)
                }
            } else {
                completion(self.getDescriptionFromWeb(medicate))
            }
        }
    }
    
    private func getDescriptionFromWeb(_ medicate: String) -> String {
        let doc: Document = try! SwiftSoup.parse(String(contentsOf: medicateURL!))
        let body: Element? = try! doc.body()?.getElementById("bulaBody")
        
        let headers: [Element] = try! body?.getElementsByTag("h3").array() ?? []
        let texts: [Element] = try! body?.getElementsByTag("p").array() ?? []
        
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
        
        ref = db.collection("medicates").addDocument(data: [
            "name": medicate,
            "medicineBottle": description
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    private func updateNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.title = ""
        let favoriteNavBtn = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(favoriteClicked))
        navigationItem.rightBarButtonItem  = favoriteNavBtn
    }
    
    @IBAction private func dismissClicked() {
        AnalyticsEvents.clickEvent(content: "dismiss_result")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func favoriteClicked() {
        AnalyticsEvents.clickEvent(content: "favorite_clicked")
    }
}

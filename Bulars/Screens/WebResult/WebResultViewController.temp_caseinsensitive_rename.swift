import UIKit
import WebKit
import SwiftSoup
import Firebase

// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping
class WebResultViewController: UIViewController {
    
    @IBOutlet weak var textContent: UITextView!
    
    let medicateURL: URL?
    let medicate: String
    let db = Firestore.firestore()
    
    init(medicate: String) {
        self.medicateURL = URL(string: "https://www.bulario.com/" + medicate + "/")
        self.medicate = medicate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = medicate.uppercased()
        textContent.text = ""
        updateNavigationBar()
        showLoading()
        
        getDescriptionFor(medicate: medicate.lowercased()) { description in
            self.dismissLoading()
            self.textContent.text = description
        }
    }
    
    private func getDescriptionFor(medicate: String, completion: @escaping (String) -> Void) {
        
        db.collection("medicates").whereField("name", isEqualTo: medicate).getDocuments { querySnapshot, err in
            if let err = err {
                completion(err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    let medicate = document.data()
                    
                    completion(medicate["medicineBottle"] as! String)
                }
            }
        }
        
    }
    
    private func updateNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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

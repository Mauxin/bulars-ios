import UIKit
import WebKit
import SwiftSoup

class WebResultViewController: UIViewController {
    
    @IBOutlet weak var textContent: UITextView!
    
    let medicateURL: URL?
    let medicate: String
    
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
        updateNavigationBar()
        
        do {
            guard let url: URL = medicateURL else {
                //TODO: Empty State
                return
            }
            
            let doc: Document = try SwiftSoup.parse(String(contentsOf: url))
            let body: Element? = try doc.body()?.getElementById("bulaBody")
            textContent.text = try body?.text()
        } catch {
            //TODO: Empty State or error
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

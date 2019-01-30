import UIKit

// swiftlint:disable force_unwrapping
class WebResultViewController: UIViewController {
    
    @IBOutlet weak var textContent: UITextView!
    
    let viewModel: WebResultViewModel
    let medicate: String
    
    init(medicate: String) {
        self.medicate = medicate.replacingOccurrences(of: " ", with: "_").lowercased()
        self.viewModel = WebResultViewModel(
            url: URL(string: "https://www.bulario.com/" + self.medicate + "/")!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
        //showLoading()
        
        viewModel.getDescriptionFor(medicate: medicate.lowercased()) { description in
            self.textContent.text = description
            //self.dismissLoading()
        }
    }
    
    private func updateNavigationBar() {
        title = medicate.capitalized
        textContent.text = ""
        
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

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet private weak var startReadButton: UIButton!
    @IBOutlet weak var testImage: UIImageView!
    
    let searchBar = UISearchBar()
    let viewModel = HomeViewModel()
    weak var delegate: HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBar()
        delegate = viewModel
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        startReadButton.layer.cornerRadius = 8
    }
    
    func updateNavigationBar() {
        let searchNavBtn = UIBarButtonItem(image: Asset.search.image, style: .plain, target: self, action: #selector(HomeViewController.searchButtonAction))
        navigationItem.rightBarButtonItem  = searchNavBtn
    }

    @IBAction private func startReadButtonAction() {
        AnalyticsEvents.clickEvent(content: Localized.startImageSearch)
        viewModel.imageSearch(self)
    }
    
    @IBAction private func searchButtonAction() {        
        searchBar.sizeToFit()
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        
        AnalyticsEvents.clickEvent(content: Localized.startTextSearch)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        delegate?.startWebButtonAction(self, searchTerm: searchBar.text ?? Localized.error)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.dismissSearchAction(self)
    }
}

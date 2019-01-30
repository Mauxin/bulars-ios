import UIKit

extension UIViewController {
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: Localized.loading, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissLoading() {
        self.dismiss(animated: true, completion: nil)
    } 
}

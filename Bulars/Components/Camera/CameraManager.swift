import Foundation
import UIKit

// swiftlint:disable force_unwrapping
// swiftlint:disable implicitly_unwrapped_optional
class CameraManager: NSObject {
    static let shared = CameraManager()
    
    private var currentViewController: UIViewController!
    
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            AnalyticsEvents.clickEvent(content: Localized.cameraStart)
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            pickerController.cameraCaptureMode = .photo
            currentViewController.dismissLoading()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.currentViewController.present(pickerController, animated: true, completion: nil)
            }
        }
    }
    
    func photoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            AnalyticsEvents.clickEvent(content: Localized.libraryStart)
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            currentViewController.dismissLoading()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.currentViewController.present(myPickerController, animated: true, completion: nil)
            }
        }
    }
    
    func showActionSheet(controller: UIViewController) {
        currentViewController = controller
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: Localized.camera, style: .default, handler: { _ in
            self.currentViewController.showLoading()
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: Localized.library, style: .default, handler: { _ in
            self.currentViewController.showLoading()
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: Localized.cancel, style: .cancel, handler: nil))
        
        controller.present(actionSheet, animated: true, completion: nil)
    }
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("fileName.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
}

extension CameraManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //picker.takePicture()
            if self.saveImage(image: image) {
               self.imagePickedBlock?(getSavedImage(named: "fileName")!)
            }
        } else {
            //TODO: Empty State
            print(Localized.error)
        }
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
}

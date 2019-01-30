//
//  HomeViewModel.swift
//  Bulars
//
//  Created by Murilo Dias on 26/11/18.
//  Copyright © 2018 Murilo Dias. All rights reserved.
//

import UIKit
import Firebase

protocol HomeViewControllerDelegate: class {
    func startWebButtonAction(_ homeViewController: HomeViewController, searchTerm: String)
    func dismissSearchAction(_ homeViewController: HomeViewController)
}

class HomeViewModel {
    
    private var textFilter = TextFilter()
    
    init () {}
    
    func imageSearch(_ vc: HomeViewController) {
        CameraManager.shared.showActionSheet(controller: vc)
        CameraManager.shared.imagePickedBlock = { image in
            vc.testImage.image = image
            vc.testImage.alpha = 1
            self.detectText(image: image, vc: vc)
        }
    }
    
    private func detectText(image: UIImage, vc: HomeViewController) {
        let vision = Vision.vision()
        let textDetector = vision.onDeviceTextRecognizer()
        let visionImage = VisionImage(image: image)
        
        let metadata = VisionImageMetadata()
        metadata.orientation = self.detectorOrientation(in: image)
        visionImage.metadata = metadata
        
        textDetector.process(visionImage) { result, error in
            guard error == nil, let result = result else {
                //TODO: Empty State
                vc.titleLabel.text = Localized.noText
                return
            }
            
            var biggestText: VisionTextElement?
            
            for block in result.blocks {
                for line in block.lines {
                    for element in line.elements
                        where element.frame.height > biggestText?.frame.height ?? 0 {
                            biggestText = element
                    }
                }
            }
            
            vc.titleLabel.text = biggestText?.text.lowercased()
            
            AnalyticsEvents.searchingEvent(term: (biggestText?.text.lowercased()) ?? Localized.error, type: Localized.image)
            let webController = WebResultViewController(medicate: (biggestText?.text.lowercased()) ?? Localized.error)
            //TODO: Empty State
            vc.navigationController?.pushViewController(webController, animated: true)
        }
    }
    
    func detectorOrientation(in image: UIImage) -> VisionDetectorImageOrientation {
        switch image.imageOrientation {
        case .up:
            return .topLeft
        case .down:
            return .bottomRight
        case .left:
            return .leftBottom
        case .right:
            return .rightTop
        case .upMirrored:
            return .topRight
        case .downMirrored:
            return .bottomLeft
        case .leftMirrored:
            return .leftTop
        case .rightMirrored:
            return .rightBottom
        }
    }
    
}

extension HomeViewModel: HomeViewControllerDelegate {
    func startWebButtonAction(_ homeViewController: HomeViewController, searchTerm: String) {
        let webController = WebResultViewController(medicate: searchTerm)
        
        homeViewController.navigationController?.pushViewController(webController, animated: true)
        homeViewController.navigationItem.titleView = nil
        homeViewController.updateNavigationBar()
        
        AnalyticsEvents.searchingEvent(term: searchTerm.lowercased(), type: Localized.text)
    }
    
    func dismissSearchAction(_ homeViewController: HomeViewController) {
        homeViewController.navigationItem.titleView = nil
        homeViewController.updateNavigationBar()
        
        AnalyticsEvents.clickEvent(content: Localized.cancelTextSearch)
    }
    
}

//
//  MultipleImagePicker.swift
//  HyraApp
//
//  Created by muthuraja on 06/06/21.
//

import Foundation
import Photos
import UIKit
import BSImagePicker

protocol MultipleImagePickerDelegate: class {
    func multipleImages(images: [UIImage])
}

public class MultipleImagePicker: NSObject {
    
    private var pickerVc  : ImagePickerController!
    private weak var presentVc : UIViewController?
    private weak var delegate  : MultipleImagePickerDelegate?
    
    init(present: UIViewController, delegate: MultipleImagePickerDelegate) {
        super.init()
        self.pickerVc = ImagePickerController()
        pickerVc.settings.selection.max = 5
        self.presentVc = present
        self.delegate = delegate
    }
    
    public func present() {
        setupPicker()
    }
}


extension MultipleImagePicker {
    func setupPicker() {
        presentVc?.presentImagePicker(pickerVc, select: { (asset) in
            print("Selected: \(asset)")
        }, deselect: { (asset) in
            print("Deselected: \(asset)")
        }, cancel: { (assets) in
            print("Canceled with selections: \(assets)")
        }, finish: { (assets) in
            print("Finished with selections: \(assets)")
            let images = self.getAssetThumbnail(assets: assets)
            print("Valuesss:::", images)
            self.pickerVc.dismiss(animated: true, completion: nil)
            self.delegate?.multipleImages(images: images)
        }, completion: nil)
    }
    
    func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }
        
        return arrayOfImages
    }
}

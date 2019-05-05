//
//  BaseViewController.swift
//  ffmpeg-learning
//
//  Created by resober on 2019/4/26.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    lazy var ciContext:CIContext = {
        let context = CIContext(options:nil);
        return context;
    }();
    lazy var imagePickerDissmissCompletionBlock:(()->Void)? = nil;
    lazy var srcImage:UIImage = {
        let path = Bundle.main.path(forResource: "a5", ofType: "jpg");
        if (path != nil) {
            return UIImage.init(contentsOfFile: path!)!;
        }
        return UIImage();
    }();
    let imagePickerVC = UIImagePickerController.init();
    override func viewDidLoad() {
        super.viewDidLoad();
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "图片", style: UIBarButtonItem.Style.plain, target: self, action: #selector(replaceImageClicked(sender:)));
    }

    @objc final func replaceImageClicked(sender:UIBarButtonItem) {
        imagePickerVC.delegate = self;
        imagePickerVC.mediaTypes = ["public.image"];
        imagePickerVC.sourceType = .photoLibrary;
        self.present(imagePickerVC, animated: true, completion: nil);
    }
}


extension BaseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let oriImage = info[.originalImage] as? UIImage;
        let editedImage = info[.editedImage] as? UIImage;
        guard oriImage != nil || editedImage != nil else {
            self.dismiss(animated: true, completion: nil);
            return;
        }
        self.srcImage = (editedImage != nil) ? editedImage! : oriImage!;
        self.dismiss(animated: true, completion: {()-> Void in
            if ((self.imagePickerDissmissCompletionBlock) != nil) {
                self.imagePickerDissmissCompletionBlock!();
            }
        });
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil);
    }
}

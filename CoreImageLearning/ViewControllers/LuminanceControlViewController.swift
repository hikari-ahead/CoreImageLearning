//
//  LuminanceControlViewController.swift
//  ffmpeg-learning
//
//  Created by resober on 2019/4/26.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
import Photos

enum LCSOperationType {
    case Luminance
    case Contrast
    case Saturation
}

let defaultLuminanceValue:Float = 0.5;
let defaultContrastValue:Float = 0.5;
let defaultSaturationValue:Float = 0.5;
class LuminanceControlViewController: BaseViewController {
    lazy var metalKitView:MetalKitView = {
        let tmp = MetalKitView();
        return tmp;
    }();
    var luminanceKernel: CIColorKernel!;
    var contrastKernel: CIColorKernel!;
    var saturationKernel: CIColorKernel!;

    let luminanceSlide = LeftTitleSilde.init(title: "Luminance", minVal: 0, maxVal: 1.0, currVal: defaultLuminanceValue);
    let contrastSlide = LeftTitleSilde.init(title: "Contrast", minVal: 0, maxVal: 1.0, currVal: defaultContrastValue);
    let saturationSlide = LeftTitleSilde.init(title: "saturation", minVal: 0, maxVal: 1.0, currVal: defaultSaturationValue);

    let applyButton = UIButton();
    let saveToAlbumButton = UIButton();

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backItemClicked(sender:)));
        self.imagePickerDissmissCompletionBlock = {()-> Void in
            self.applyFilter(type: .Luminance, delta: 0);
        };
        setupViews();
        setupFilters();
        applyFilter(type: .Saturation, delta: 0.5);
    }

    final func setupViews() {
        var top:CGFloat = self.navigationController!.navigationBar.frame.size.height;
        if #available(iOS 11.0, *) {
            top += self.navigationController!.view.safeAreaInsets.top;
        }
        metalKitView.frame = CGRect.init(x: 0, y: top, width: view.frame.size.width, height: view.frame.size.width);
        view.addSubview(metalKitView);

        let horizMargin:CGFloat = 0;
        let topMargin:CGFloat = 35.0;
        let imageViewBottom = metalKitView.frame.size.height + metalKitView.frame.origin.y;
        luminanceSlide.frame = CGRect.init(x: horizMargin, y: imageViewBottom + topMargin, width: view.frame.size.width - 2 * horizMargin, height: 44.0);
        luminanceSlide.slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: UIControl.Event.valueChanged);
        view.addSubview(luminanceSlide);

        let luminanceSlideBottom = luminanceSlide.frame.size.height + luminanceSlide.frame.origin.y;
        contrastSlide.frame = CGRect.init(x: horizMargin, y: luminanceSlideBottom + topMargin, width: view.frame.size.width - 2 * horizMargin, height: 44.0);
        contrastSlide.slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: UIControl.Event.valueChanged);
        view.addSubview(contrastSlide);

        let contrastSlideBottom = contrastSlide.frame.size.height + contrastSlide.frame.origin.y;
        saturationSlide.frame = CGRect.init(x: horizMargin, y: contrastSlideBottom + topMargin, width: view.frame.size.width - 2 * horizMargin, height: 44.0);
        saturationSlide.slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: UIControl.Event.valueChanged);
        view.addSubview(saturationSlide);

        let saturationSlideBottom:CGFloat = saturationSlide.frame.origin.y + saturationSlide.frame.size.height;
        applyButton.setTitleColor(.black, for: .normal);
        saveToAlbumButton.setTitleColor(.black, for: .normal);
        applyButton.setTitle("Apply", for: .normal);
        saveToAlbumButton.setTitle("Save To Album", for: .normal);
        applyButton.frame = CGRect.init(x: saturationSlide.titleLabel.frame.origin.x, y: saturationSlideBottom + topMargin, width: 100, height: 44);
        saveToAlbumButton.frame = CGRect.init(x: applyButton.frame.origin.x + applyButton.frame.size.width + horizMargin, y: saturationSlideBottom + topMargin, width: 200, height: 44);
        view.addSubview(applyButton);
        view.addSubview(saveToAlbumButton);
        applyButton.addTarget(self, action: #selector(applyButtonClicked(sender:)), for: .touchUpInside);
        saveToAlbumButton.addTarget(self, action: #selector(saveToAlbumButtonClicked(sender:)), for: .touchUpInside);
    }

    func setupFilters() {
        let lUrl = Bundle.main.url(forResource: "brightness", withExtension: "cikernel")!;
        let cUrl = Bundle.main.url(forResource: "contrast", withExtension: "cikernel")!;
        let sUrl = Bundle.main.url(forResource: "saturation", withExtension: "cikernel")!;

        do {
            let lFilterCodeString = try String.init(contentsOf: lUrl);
            luminanceKernel = CIColorKernel.init(source: lFilterCodeString)!;

            let cFilterCodeString = try String.init(contentsOf: cUrl);
            contrastKernel = CIColorKernel.init(source: cFilterCodeString)!;

            let sFilterCodeString = try String.init(contentsOf: sUrl);
            saturationKernel = CIColorKernel.init(source: sFilterCodeString)!;

        } catch {
            print(error);
        }
    }

    final func applyFilter(type:LCSOperationType, delta:Float) {
        let srcCIImage = CIImage.init(image: srcImage);
        guard srcCIImage != nil else {
            return;
        }
        var kernel:CIKernel?
        switch type {
        case .Contrast:
            kernel = contrastKernel;
            break;
        case .Luminance:
            kernel = luminanceKernel;
            break;
        case .Saturation:
            kernel = saturationKernel;
            break;
        }
        guard kernel != nil else {
            return;
        }
        DispatchQueue.main.async {
            let dst = kernel!.apply(extent: srcCIImage!.extent, roiCallback: { (idx, rect) -> CGRect in
                return rect;
            }, arguments: [srcCIImage!, delta]);
            if (dst != nil && MetalManager.shared.mtDevice != nil) {
                self.metalKitView.render(image: dst!, context: self.ciContext, device: MetalManager.shared.mtDevice!);
            }
        }
    }


    // MARK: - Action
    @objc final func switchValueChanged(sender:UISwitch) {

    }

    @objc final func sliderValueChanged(sender:UISlider) {
        if (sender == luminanceSlide.slider) {
            let delta = sender.value - defaultLuminanceValue;
            applyFilter(type: .Luminance, delta: delta);
        } else if (sender == contrastSlide.slider) {
            let delta = sender.value - defaultContrastValue;
            applyFilter(type: .Contrast, delta: delta);
        } else if (sender == saturationSlide.slider) {
            let delta = sender.value;
            applyFilter(type: .Saturation, delta: delta);
        }

    }

    @objc final func backItemClicked(sender:UIBarButtonItem) {
        navigationController?.popViewController(animated: true);
    }

    @objc final func applyButtonClicked(sender:UIButton) {
        guard metalKitView.currentDrawable != nil else {
            return;
        }
        if let image = metalKitView.getUIImage(texture: metalKitView.currentDrawable!.texture, context: ciContext, orientation: srcImage.imageOrientation) {
            srcImage = image;
            applyButton.setTitle("success", for: .normal);
            applyButton.setTitleColor(.green, for: .normal);
            applyButton.isEnabled = false;
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.applyButton.setTitle("Apply", for: .normal);
                self.applyButton.setTitleColor(.black, for: .normal);
                self.applyButton.isEnabled = true;
            }
        }
    }

    @objc final func saveToAlbumButtonClicked(sender:UIButton) {
        if let image = metalKitView.getUIImage(texture: metalKitView.currentDrawable!.texture, context: ciContext, orientation: srcImage.imageOrientation) {
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image);
            }) { (success, error) in
                if (error != nil) {
                    print(error!);
                } else {
                    print("saved");
                    DispatchQueue.main.async {
                        self.saveToAlbumButton.setTitle("success", for: .normal);
                        self.saveToAlbumButton.setTitleColor(.green, for: .normal);
                        self.saveToAlbumButton.isEnabled = false;
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.saveToAlbumButton.setTitle("Save To Album", for: .normal);
                            self.saveToAlbumButton.setTitleColor(.black, for: .normal);
                            self.saveToAlbumButton.isEnabled = true;
                        }
                    }
                }
            }
        }
    }
}


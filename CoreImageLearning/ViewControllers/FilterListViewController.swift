//
//  FilterListViewController.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/30.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
import CoreImage

class FilterListViewController: BaseViewController {

    var collectionView:UICollectionView!;
    var cachedFilterImageDict:Dictionary<FilterNames, CIImage>!;

    override func viewDidLoad() {
        super.viewDidLoad()
        cachedFilterImageDict = [:];
        self.imagePickerDissmissCompletionBlock = {[weak self] ()-> Void in
            self?.cachedFilterImageDict.removeAll(keepingCapacity: true);
            self?.collectionView.reloadData();
        };
        view.backgroundColor = .white;
        setupViews();
    }

    func setupViews() {
        var top:CGFloat = self.navigationController!.navigationBar.frame.size.height;
        if #available(iOS 11.0, *) {
            top += self.navigationController!.view.safeAreaInsets.top;
        }
        let f = CGRect.init(x: 0, y: top, width: view.frame.size.width, height: view.frame.size.height - top);
        let layout = UICollectionViewFlowLayout();
        let gap:CGFloat = 5;
        let perWidth = (view.frame.size.width - 3 * gap) / 2.0;
        // perWidth + 25 = imageView.size.height + label.size.height
        layout.itemSize = CGSize.init(width: perWidth, height: perWidth + 25);
        layout.estimatedItemSize = layout.itemSize;
        layout.minimumLineSpacing = gap;
        layout.minimumInteritemSpacing = gap / 2.0;
        collectionView = UICollectionView.init(frame: f, collectionViewLayout: layout);
        collectionView.dataSource = self;
        collectionView.backgroundColor = .lightGray;
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: gap, bottom: 0, right: gap);
        collectionView.collectionViewLayout = layout;
        collectionView.register(FilterListCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FilterListCollectionViewCell.self));
        view.addSubview(collectionView);
    }

    func getFilteredImage(filterName:FilterNames, srcImage:UIImage, completionBlock:@escaping ((_ filterName:FilterNames,_ filterImage:CIImage?)->Void)) {
        DispatchQueue.global().async {
            let ciImage = CIImage.init(image: srcImage);
            guard ciImage != nil else {
                completionBlock(filterName, nil);
                return;
            }
            switch filterName {
            case .CIOriginal:
                completionBlock(filterName, ciImage!);
                break;
            case .CIBoxBlur:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    kCIInputRadiusKey: 20.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIDiscBlur:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    kCIInputRadiusKey: 10.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIGaussianBlur:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    kCIInputRadiusKey: 10.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIMaskedVariableBlur:
                let maskedUIImage = UIImage.init(named: "maskedBlurMask");
                DispatchQueue.main.async {
                    UIGraphicsBeginImageContextWithOptions(srcImage.size, false, 1);
                    maskedUIImage?.draw(in: CGRect.init(x: 0, y: 0, width: srcImage.size.width, height: srcImage.size.height));
                    let cgimage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage;
                    UIGraphicsEndImageContext();
                    let maskedImage = CIImage.init(cgImage: cgimage!);
                    DispatchQueue.global().async {
                        let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                            kCIInputImageKey: ciImage as Any,
                            kCIInputRadiusKey: 100.0,
                            "inputMask": maskedImage as Any
                            ]);
                        let optCIImage = filter?.outputImage;
                        completionBlock(filterName, optCIImage!);
                    }
                }
                break;
            case .CIMedianFilter:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIMotionBlur:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    kCIInputRadiusKey: 40.0,
                    kCIInputAngleKey: 0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CINoiseReduction:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputNoiseLevel": 0.02,
                    kCIInputSharpnessKey: 0.40]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIZoomBlur:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputCenter": CIVector.init(x: 150, y: 150),
                    "inputAmount": 10.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIColorClamp:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputMinComponents": CIVector.init(x: 0, y: 0, z: 0, w: 0),
                    "inputMaxComponents": CIVector.init(x: 1, y: 1, z: 1, w: 1)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIColorControls:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputSaturation": 3.0,
//                    "inputBrightness": 1.0,
                    "inputContrast": 1.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIColorMatrix:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputRVector": CIVector.init(x: 1, y: 0, z: 0, w: 0),
                    "inputGVector": CIVector.init(x: 0, y: 1, z: 0, w: 0),
                    "inputBVector": CIVector.init(x: 0, y: 0, z: 1.5, w: 0),
                    "inputAVector": CIVector.init(x: 0, y: 0, z: 0, w: 1),
                    "inputBiasVector": CIVector.init(x: 0.5, y: 0, z: 0.5, w: 0)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIColorPolynomial:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputRedCoefficients": CIVector.init(x: 0, y: 0, z: 0, w: 0.4),
                    "inputGreenCoefficients": CIVector.init(x: 0, y: 0, z: 0.5, w: 0.8),
                    "inputBlueCoefficients": CIVector.init(x: 0, y: 0, z: 0.5, w: 1),
                    "inputAlphaCoefficients": CIVector.init(x: 0, y: 1, z: 1, w: 1)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIExposureAdjust:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputEV": 0.5]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIGammaAdjust:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputPower": 0.75]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIHueAdjust:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputAngle": 0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CILinearToSRGBToneCurve:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CISRGBToneCurveToLinear:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CITemperatureAndTint:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputNeutral": CIVector.init(x: 6500, y: 0),
                    "inputTargetNeutral": CIVector.init(x: 6500, y: 0)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIToneCurve:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputPoint0": CIVector.init(x: 0, y: 0),
                    "inputPoint1": CIVector.init(x: 0.25, y: 0.25),
                    "inputPoint2": CIVector.init(x: 0.5, y: 0.5),
                    "inputPoint3": CIVector.init(x: 0.75, y: 0.75),
                    "inputPoint4": CIVector.init(x: 1, y: 1)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIVibrance:
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputAmount": 2.0]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            case .CIWhitePointAdjust:
                let whilePointColor = UIColor.yellow.withAlphaComponent(0.3);
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [
                    kCIInputImageKey: ciImage as Any,
                    "inputColor": CIColor.init(color: whilePointColor)]);
                let optCIImage = filter?.outputImage;
                completionBlock(filterName, optCIImage!);
                break;
            default:
                completionBlock(filterName, nil);
                break;
            }
        }
    }
}

extension FilterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gFilterNamesArray.count;
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:FilterListCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FilterListCollectionViewCell.self), for: indexPath) as? FilterListCollectionViewCell;
        if (cell == nil) {
            cell = FilterListCollectionViewCell();
        }
        let filterName = gFilterNamesArray[indexPath.row];
        if (self.cachedFilterImageDict[filterName] != nil) {
            cell?.config(image: self.cachedFilterImageDict[filterName], title: filterName.rawValue, context: ciContext, device: MetalManager.shared.mtDevice);
        } else {
            cell?.config(image: nil, title: filterName.rawValue, context: ciContext, device:nil);
            self.getFilteredImage(filterName: filterName, srcImage: srcImage, completionBlock: { [weak cell, weak self] (filterName:FilterNames, filterImage:CIImage?) in
                if filterImage != nil && self != nil {
                    self!.cachedFilterImageDict[filterName] = filterImage;
                }
                DispatchQueue.main.async {
                    cell?.config(image: filterImage, title: filterName.rawValue, context: (self?.ciContext)!, device: MetalManager.shared.mtDevice!);
                };
            });
        }
        return cell!;
    }

}

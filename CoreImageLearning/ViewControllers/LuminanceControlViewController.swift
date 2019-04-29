//
//  LuminanceControlViewController.swift
//  ffmpeg-learning
//
//  Created by resober on 2019/4/26.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
let defaultLuminanceValue:Float = 0.5;
let defaultContrastValue:Float = 0.5;
let defaultSaturationValue:Float = 0.5;
class LuminanceControlViewController: UIViewController {
    lazy var srcImage:UIImage = {
        let path = Bundle.main.path(forResource: "a5", ofType: "jpg");
        if (path != nil) {
            return UIImage.init(contentsOfFile: path!)!;
        }
        return UIImage();
    }();
    lazy var imageView:UIImageView = {
        let tmp = UIImageView.init(image: srcImage);
        tmp.contentMode = UIView.ContentMode.scaleAspectFill;
        return tmp;
    }();
    var luminanceKernel: CIColorKernel!;


    let luminanceSlide = LeftTitleSilde.init(title: "Luminance", minVal: 0, maxVal: 1.0, currVal: defaultLuminanceValue);
    let contrastSlide = LeftTitleSilde.init(title: "Contrast", minVal: 0, maxVal: 1.0, currVal: defaultContrastValue);
    let saturationSlide = LeftTitleSilde.init(title: "saturation", minVal: 0, maxVal: 1.0, currVal: defaultSaturationValue);

    let linearSwitch = UISwitch();

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white;
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backItemClicked(sender:)));
        setupViews();
        setupFilters();
    }

    final func setupViews() {
        var top:CGFloat = self.navigationController!.navigationBar.frame.size.height;
        if #available(iOS 11.0, *) {
            top += self.navigationController!.view.safeAreaInsets.top;
        }
        imageView.frame = CGRect.init(x: 0, y: top, width: view.frame.size.width, height: view.frame.size.width);
        view.addSubview(imageView);

        let horizMargin:CGFloat = 0;
        let topMargin:CGFloat = 35.0;
        let imageViewBottom = imageView.frame.size.height + imageView.frame.origin.y;
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

        linearSwitch.isOn = false;
        let saturationSlideBottom:CGFloat = saturationSlide.frame.origin.y + saturationSlide.frame.size.height;
        linearSwitch.frame = CGRect.init(x: saturationSlide.titleLabel.frame.origin.x, y: saturationSlideBottom + topMargin, width: 100.0, height: 44.0);
        linearSwitch.addTarget(self, action: #selector(switchValueChanged(sender:)), for: UIControl.Event.valueChanged);
        view.addSubview(linearSwitch);
    }

    func setupFilters() {
        let url = Bundle.main.url(forResource: "brightness", withExtension: "cikernel")!;
        do {
            let filterCodeString = try String.init(contentsOf: url);
            luminanceKernel = CIColorKernel.init(source: filterCodeString)!;
        } catch {
            print(error);
        }
    }


    final func applyLuminanceFilter(delta:Float) {
        let srcCIImage = CIImage.init(image: srcImage);
        guard srcCIImage != nil else {
            return;
        }
        DispatchQueue.global().async {
            let dst = self.luminanceKernel.apply(extent: srcCIImage!.extent, roiCallback: { (idx, rect) -> CGRect in
                return rect;
            }, arguments: [srcCIImage!, delta]);
            if (dst != nil) {
                // use dst.extent to prohibt scaled
                let context = CIContext(options:nil)
                let cgimg = context.createCGImage(dst!, from: dst!.extent);
                let newImage = UIImage(cgImage: cgimg!)
                DispatchQueue.main.async {
                    self.imageView.image = newImage;
                }
            }
        }
    }


    // MARK: - Action
    @objc final func switchValueChanged(sender:UISwitch) {

    }

    @objc final func sliderValueChanged(sender:UISlider) {
        if (sender == luminanceSlide.slider) {
            applyLuminanceFilter(delta: sender.value - defaultLuminanceValue);
        }

    }

    @objc final func backItemClicked(sender:UIBarButtonItem) {
        navigationController?.popViewController(animated: true);
    }
}

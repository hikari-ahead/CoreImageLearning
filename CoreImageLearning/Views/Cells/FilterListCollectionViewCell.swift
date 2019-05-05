//
//  FilterListCollectionViewCell.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/30.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit

class FilterListCollectionViewCell: UICollectionViewCell {
    var imageView:MetalKitView!;
    var label = UILabel();
    var context:CIContext?
    var device:MTLDevice?

    override var frame: CGRect {
        willSet {
//            updateSubViewsFrame();
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        setupViews();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setupViews();
    }

    convenience init() {
        self.init(frame: CGRect.zero);
    }

    private func setupViews() {
        self.layer.masksToBounds = true;
        self.backgroundColor = .white;

        imageView = MetalKitView();
        imageView.contentMode = .scaleAspectFill;
        addSubview(imageView);

        addSubview(label);
        label.textColor = .white;
        label.font = .systemFont(ofSize: 12);
        label.backgroundColor = UIColor.init(white: 0, alpha: 0.5);
        updateSubViewsFrame();
    }

    private func updateSubViewsFrame() {
        label.frame = CGRect.init(x: 0, y: 0, width: bounds.size.width, height: 25);
        imageView.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 25), size: CGSize.init(width: bounds.size.width, height: bounds.size.height - 25));
    }

    override func prepareForReuse() {
        super.prepareForReuse();
        imageView.releaseDrawables();
        imageView.removeFromSuperview();
        imageView = nil;
        imageView = MetalKitView();
        addSubview(imageView);
        updateSubViewsFrame();
        if #available(iOS 10.0, *) {
            self.context?.clearCaches()
        } else {
            // Fallback on earlier versions
        };
    }

    func config(image:CIImage?, title:String?, context:CIContext?, device:MTLDevice?) {
        label.text = title;
        label.setNeedsDisplay();
        guard context != nil && device != nil else {
            return;
        }
        self.context = context;
        self.device = device;
        if (image != nil) {
//            imageView.isHidden = false;
            imageView.render(image: image!, context: context!, device: device!);
            imageView.setNeedsDisplay();
        }
    }
}

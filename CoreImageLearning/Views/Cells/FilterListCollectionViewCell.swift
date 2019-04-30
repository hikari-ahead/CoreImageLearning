//
//  FilterListCollectionViewCell.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/30.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit

class FilterListCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView();
    var label = UILabel();

    override var frame: CGRect {
        willSet {
            updateSubViewsFrame();
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        setupViews();
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);

    }

    convenience init() {
        self.init(frame: CGRect.zero);
    }

    private func setupViews() {
        self.backgroundColor = .white;
        imageView.contentMode = .scaleAspectFill;
        addSubview(imageView);

        addSubview(label);
        label.textColor = .white;
        label.backgroundColor = UIColor.init(white: 0, alpha: 0.6);
    }

    private func updateSubViewsFrame() {
        imageView.frame = bounds;
        label.frame = CGRect.init(x: 0, y: 0, width: 100, height: 30);
    }

    override func prepareForReuse() {
        imageView.image = nil;
        label.text = nil;
    }

    func config(image:UIImage?, title:String?) {
        if (image != nil) {
            imageView.image = image!;
        }
        label.text = title;
    }
}

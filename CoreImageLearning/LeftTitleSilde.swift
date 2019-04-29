//
//  LeftTitleSilde.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/29.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit

class LeftTitleSilde: UIView {

    private let INTERNAL_HEIGHT:CGFloat = 44.0;
    let titleLabel = UILabel();
    let slider = UISlider();

    convenience init(title:String) {
        self.init();
        titleLabel.text = title;
    }

    convenience init(title:String, minVal:Float, maxVal:Float, currVal:Float) {
        self.init();
        titleLabel.text = title;
        slider.minimumValue = minVal;
        slider.maximumValue = maxVal;
        slider.value = currVal;
    }


    init() {
        super.init(frame: CGRect.zero);
        self.backgroundColor = .white;
        setupViews();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(titleLabel);
        addSubview(slider);
        let HORIZ_MARGIN:CGFloat = 20.0;
        let contentWidth = UIScreen.main.bounds.size.width - 2 * HORIZ_MARGIN;
        let titleLabelWidth:CGFloat = 100.0;
        titleLabel.frame = CGRect.init(x: HORIZ_MARGIN, y: 0, width: titleLabelWidth, height: INTERNAL_HEIGHT);
        slider.frame = CGRect.init(x: HORIZ_MARGIN + titleLabelWidth, y: 0, width: contentWidth - 2 * INTERNAL_HEIGHT - titleLabelWidth, height: INTERNAL_HEIGHT);
    }

    override var intrinsicContentSize: CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: INTERNAL_HEIGHT);
    }
}

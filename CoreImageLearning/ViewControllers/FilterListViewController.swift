//
//  FilterListViewController.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/30.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
import CoreImage

class FilterListViewController: UIViewController {

    var collectionView:UICollectionView!;

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let perWidth = (view.frame.size.width - 4 * gap) / 3.0;
        layout.itemSize = CGSize.init(width: perWidth, height: perWidth);
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
        cell!.config(image: nil, title: gFilterNamesArray[indexPath.row].rawValue);
        return cell!;
    }

}

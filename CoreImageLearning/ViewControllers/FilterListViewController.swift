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
                let filter = CIFilter.init(name: filterName.rawValue, parameters: [kCIInputImageKey: ciImage as Any, kCIInputRadiusKey: 20.0]);
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
                if filterImage != nil {
                    self?.cachedFilterImageDict[filterName] = filterImage;
                }
                DispatchQueue.main.async {
                    cell?.config(image: filterImage, title: filterName.rawValue, context: (self?.ciContext)!, device: MetalManager.shared.mtDevice!);
                };
            });
        }
        return cell!;
    }

}

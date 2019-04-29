//
//  MetalManager.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/29.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit

class MetalManager {
    static let shared:MetalManager = MetalManager();
    var mtDevice:MTLDevice?;
    init() {
        mtDevice = MTLCreateSystemDefaultDevice();
    }
}

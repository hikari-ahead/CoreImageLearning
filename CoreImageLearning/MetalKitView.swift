//
//  MetalKitView.swift
//  CoreImageLearning
//
//  Created by resober on 2019/4/29.
//  Copyright © 2019 resober. All rights reserved.
//

import UIKit
import MetalKit
import Metal
import AVFoundation

class MetalKitView: MTKView {
    private var commandQueue: MTLCommandQueue?;
    private var ciContext: CIContext?
    var mtTexture: MTLTexture?

    required init(coder: NSCoder) {
        super.init(coder: coder);
        self.isOpaque = false;
        self.enableSetNeedsDisplay = true;
    }

    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device);
        self.framebufferOnly = false;
        self.isOpaque = false;
        self.enableSetNeedsDisplay = true;
    }

    init() {
        self.init(frame: .zero);

    }

    func render(image: CIImage, context: CIContext, device: MTLDevice) {
//        #if !targetEnvironment(simulator)
        self.ciContext = context;
        self.device = device;

        var bounds = self.bounds;
        bounds.size = self.drawableSize;
        bounds = AVMakeRect(aspectRatio: image.extent.size, insideRect: bounds);
        let filteredImage = image.transformed(by: CGAffineTransform.init(scaleX: bounds.size.width / image.extent.size.width, y: bounds.size.height / image.extent.size.height));
        let x = -bounds.origin.x;
        let y = -bounds.origin.y;

        self.commandQueue = device.makeCommandQueue();

        let buffer = self.commandQueue!.makeCommandBuffer()!;
        self.mtTexture = self.currentDrawable!.texture;
        self.ciContext?.render(filteredImage, to: self.currentDrawable!.texture, commandBuffer: buffer, bounds: CGRect.init(x: x, y: y, width: self.drawableSize.width, height: self.drawableSize.height), colorSpace: CGColorSpaceCreateDeviceRGB());
        buffer.present(self.currentDrawable!)
        buffer.commit();
//        #endif
    }
}

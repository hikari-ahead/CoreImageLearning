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

    required init(coder: NSCoder) {
        super.init(coder: coder);
        commonSetup();
    }

    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device);
        commonSetup();
    }

    init() {
        self.init(frame: .zero);

    }

    func commonSetup() {
        self.framebufferOnly = false;
        self.isOpaque = false;
        self.enableSetNeedsDisplay = true;
    }

    func render(image: CIImage, context: CIContext, device: MTLDevice) {
        #if !targetEnvironment(simulator)
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
        if (self.currentDrawable != nil) {
            self.ciContext?.render(filteredImage, to: self.currentDrawable!.texture, commandBuffer: buffer, bounds: CGRect.init(x: x, y: y, width: self.drawableSize.width, height: self.drawableSize.height), colorSpace: CGColorSpaceCreateDeviceRGB());
            buffer.present(self.currentDrawable!)
            buffer.commit();
            releaseDrawables();
        }
        #else
        print("metal support arm64 devices only.");
        #endif
    }

    func getUIImage(texture: MTLTexture, context: CIContext, orientation:UIImage.Orientation)-> UIImage? {
        let options = [CIImageOption.colorSpace: CGColorSpaceCreateDeviceRGB(),
                      CIContextOption.outputPremultiplied: true,
                      CIContextOption.useSoftwareRenderer: false] as! [CIImageOption : Any];
        if var ciImageFromTexture = CIImage.init(mtlTexture: texture, options: options) {
            // vertical flip again due to from texture
            ciImageFromTexture = ciImageFromTexture.transformed(by: CGAffineTransform.init(translationX: 0, y: -ciImageFromTexture.extent.size.height));
            ciImageFromTexture = ciImageFromTexture.transformed(by: CGAffineTransform.init(scaleX: 1, y: -1));
            if let cgImage = context.createCGImage(ciImageFromTexture, from: ciImageFromTexture.extent) {
                let image = UIImage.init(cgImage: cgImage, scale: 1, orientation: orientation);
                return image;
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }
}

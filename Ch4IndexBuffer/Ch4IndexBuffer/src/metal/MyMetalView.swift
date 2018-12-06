//
//  MyMetalView.swift
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa
import MetalKit

class MyMetalView: MTKView {

    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        self.createRenderpass()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.render()
    }

    // MARK: - init
    private var renderpass: MyRenderpass!
    private var triangle: MyTriangleMesh!
    private func createRenderpass() {
        self.device = MyDevice.shared.device
        self.renderpass = MyRenderpass(vs: "hello_vertex", fs: "hello_fragment")
        self.triangle = MyTriangleMesh()
    }
    // MARK: - render
    private func render()  {
        guard let commandBuffer = MyDevice.shared.makeCommandBuffer() else { return }
        renderpass.makeEncoderToCommandBuffer(commandBuffer, renderTarget: currentDrawable!.texture, mesh: self.triangle)
        commandBuffer.present(currentDrawable!) // display result to this view
        commandBuffer.commit() // commit commandBuffer to Q and GPU
    }
}

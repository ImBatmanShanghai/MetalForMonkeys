//
//  MyMetalView.swift
//  Ch1HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa
import MetalKit

class MyMetalView: MTKView {
    
    override init(frame frameRect: CGRect, device: MTLDevice?) {
        super.init(frame: frameRect, device: device)
        self.createQAndPipelineAtInit()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.createRenderpassEncoderPerFrame()
    }
    
    // MARK: - init
    private var q: MTLCommandQueue!
    private var pipeline: MTLRenderPipelineState!
    private func createQAndPipelineAtInit() {
        self.device = MTLCreateSystemDefaultDevice() // tell metal view the device info
        q = self.device!.makeCommandQueue()

        // 1. create pipeline parameters
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        
        // 2.1 set pipeline parameters: what program running on GPU
        guard let library = self.device!.makeDefaultLibrary() else { return }
        pipelineStateDescriptor.vertexFunction = library.makeFunction(name: "hello_vertex")
        pipelineStateDescriptor.fragmentFunction = library.makeFunction(name: "hello_fragment")
        
        // 2.2 set pipeline parameters: what is render target color format
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        // 3. create pipeline with parameters, catch error if shader code not correct
        do {
            pipeline = try device!.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error as NSError { // catch shader code error information
            NSLog("fail to create pipeline:\n %@", error)
        }
    }
    
    // MARK: - render
    private func createRenderpassEncoderPerFrame() {
        // 1. create renderpass encoder parameters: output render target
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = currentDrawable!.texture // view canvas as render target
        renderPassDescriptor.colorAttachments[0].loadAction = .clear    // clear render target with default clearColor
        
        // create renderpass encoder with parameters
        guard let commandBuffer = q.makeCommandBuffer() else { return }
        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        // 2. attach renderpass encoder with: pipeline
        encoder?.setRenderPipelineState(pipeline)
        
        // 3. attach renderpass encoder with: input data
        var triangleVertices:[Float] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 0.0,       // xyz rgb of vertex 0: top
            -1.0, -1.0, 0.0, 0.0, 1.0, 0.0,     // xyz rgb of vertex 1: bottom left
            1.0, -1.0, 0.0, 0.0, 0.0, 1.0, ]    // xyz rgb of vertex 2: bottom right
        encoder?.setVertexBytes(&triangleVertices, length: triangleVertices.count * MemoryLayout<Float>.size, index: 0)
        
        // 4. attach renderpass encoder with: a draw call command
        encoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        
        // 5. package renderpass encoder to commandBuffer
        encoder?.endEncoding()
        
        // 6 commit renderpass encoder and commandBuffer to Q and GPU
        commandBuffer.present(currentDrawable!)  // display result to this view
        commandBuffer.commit()
    }
}

//
//  MyRenderpass.swift
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyRenderpass: NSObject {
    
    private var pipeline: MTLRenderPipelineState!
    init(vs: String, fs: String) {
        
        let device = MyDevice.shared.device
        
        // 1. create pipeline parameters
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        
        // 2.1 set pipeline parameters: what program running on GPU
        guard let library = device!.makeDefaultLibrary() else { return }
        pipelineStateDescriptor.vertexFunction = library.makeFunction(name: vs)
        pipelineStateDescriptor.fragmentFunction = library.makeFunction(name: fs)
        
        // 2.2 set pipeline parameters: what is render target color format
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        // 3. create pipeline with parameters, catch error if shader code not correct
        do {
            pipeline = try device!.makeRenderPipelineState(descriptor: pipelineStateDescriptor)
        } catch let error as NSError { // catch shader code error information
            NSLog("fail to create pipeline:\n %@", error)
        }
    }
    func makeEncoderToCommandBuffer(_ commandBuffer: MTLCommandBuffer,
                                    renderTarget: MTLTexture,
                                    mesh: MyTriangleMesh) {
        // 1. create renderpass encoder parameters: output render target
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = renderTarget // texture as render target
        renderPassDescriptor.colorAttachments[0].loadAction = .clear    // clear render target with default clearColor
        
        // create renderpass encoder with parameters
        let encoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        // 2. attach renderpass encoder with: pipeline
        encoder?.setRenderPipelineState(pipeline)
        
        // 3. attach renderpass encoder with: input data
        encoder?.setVertexBuffer(mesh.vertexBuffer!.buffer, offset: 0, index: 0)
        
        // 4. attach renderpass encoder with: a draw call command
        encoder?.drawIndexedPrimitives(type: .triangle, indexCount: mesh.indexCount, indexType: .uint16, indexBuffer: mesh.indexBuffer.buffer!, indexBufferOffset: 0) // ch4.change.2
        
        // 5. package renderpass encoder to commandBuffer
        encoder?.endEncoding()
    }
}

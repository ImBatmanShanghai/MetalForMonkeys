//
//  MyMesh.swift
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyTriangleMesh: NSObject {

    var vertexBuffer: MyBuffer!
    var vertexCount: Int
    var uniforms: MyRenderUnforms
    
    override init() {
        var vertices:[Float] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 0.0,       // xyz rgb of vertex 0: top
            -1.0, -1.0, 0.0, 0.0, 1.0, 0.0,     // xyz rgb of vertex 1: bottom left
            1.0, -1.0, 0.0, 0.0, 0.0, 1.0, ]    // xyz rgb of vertex 2: bottom right
        
        vertexBuffer = MyBuffer(bytes: &vertices, length: vertices.count * MemoryLayout<Float>.size)
        vertexCount = 3
        
        // ch4.change.1 add uniforms to mesh
        uniforms = MyRenderUnforms()
        uniforms.brightness = 0.5;
        
        super.init()
    }
}

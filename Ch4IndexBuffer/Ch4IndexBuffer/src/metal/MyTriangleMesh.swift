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
    
    // ch4.change.1
    var indexBuffer: MyBuffer!
    var indexCount: Int
    
    override init() {
        var vertices:[Float] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 0.0,       // xyz rgb of vertex 0: top
            -1.0, -1.0, 0.0, 0.0, 1.0, 0.0,     // xyz rgb of vertex 1: bottom left
            1.0, -1.0, 0.0, 0.0, 0.0, 1.0, ]    // xyz rgb of vertex 2: bottom right
        
        vertexBuffer = MyBuffer(bytes: &vertices, length: vertices.count * MemoryLayout<Float>.size)
        vertexCount = 3
        
        // ch4.change.1
        var indices:[UInt16] = [
            0, 1, 2  // triangle 0 indices
        ]
        indexBuffer = MyBuffer(bytes: &indices, length: indices.count * MemoryLayout<UInt16>.size)
        indexCount = indices.count
        
        super.init()
    }
}

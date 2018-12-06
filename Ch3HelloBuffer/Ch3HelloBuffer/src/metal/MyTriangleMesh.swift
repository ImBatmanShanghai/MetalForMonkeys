//
//  MyMesh.swift
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyTriangleMesh: NSObject {

    // ch3.change1
    var vertexBuffer: MyBuffer!
    var vertexCount: Int
    
    override init() {
        var vertices:[Float] = [
            0.0, 1.0, 0.0, 1.0, 0.0, 0.0,       // xyz rgb of vertex 0: top
            -1.0, -1.0, 0.0, 0.0, 1.0, 0.0,     // xyz rgb of vertex 1: bottom left
            1.0, -1.0, 0.0, 0.0, 0.0, 1.0, ]    // xyz rgb of vertex 2: bottom right
        
        // ch3.change2
        vertexBuffer = MyBuffer(bytes: &vertices, length: vertices.count * MemoryLayout<Float>.size)
        vertexCount = 3
        
        super.init()
    }
}

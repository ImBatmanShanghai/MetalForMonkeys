//
//  MyRenderUnforms.swift
//  Ch4HelloUniform
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyRenderUnforms: NSObject {
    
    // MARK: - remote copy
    var buffer: MyBuffer
    
    // MARK: - local copy
    private struct Property {
        var brightness:Float = 0
    }
    private var properties: Property
    private var isDirty: Bool = false
    
    // MARK: - init
    override init() {
        properties = Property()
        buffer = MyBuffer(bytes: &properties, length: MemoryLayout<Property>.size)!
        super.init()
    }
    
    // MARK: - interface
    var brightness: Float {
        get {  return self.properties.brightness }
        set(newValue) {
            self.properties.brightness = newValue
            isDirty = true
        }
    }
    
    func rereshBuffer() {
        if isDirty {
            buffer.updateBuffer(bytes: &properties, length: MemoryLayout<Property>.size)
        }
    }
    
    
}

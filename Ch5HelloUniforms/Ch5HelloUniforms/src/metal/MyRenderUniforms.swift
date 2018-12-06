//
//  MyRenderUniforms.swift
//  Ch5HelloUniforms
//
//  Created by chenkai on 2018/12/7.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyRenderUniforms: NSObject {
    
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
    
    func refreshUniforms() {
        if isDirty {
            buffer.updateBuffer(bytes: &properties, length: MemoryLayout<Property>.size)
        }
    }
}

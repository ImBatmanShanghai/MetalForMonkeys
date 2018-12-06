//
//  MyBuffer.swift
//  Ch3HelloBuffer
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyBuffer: NSObject {

    var buffer: MTLBuffer!
    let length: Int
    
    // make new buffer and copy bytes to it
    init?(bytes: UnsafeRawPointer, length:Int) {
        
        self.length = length
        buffer = MyDevice.shared.device.makeBuffer(bytes: bytes, length: length, options: [])
        guard buffer != nil else { return nil }
        
        super.init()
    }
    
    // Create a buffer by allocating new memory
    init?(length:Int) {
        
        self.length = length
        buffer = MyDevice.shared.device.makeBuffer(length: length, options: [])
        guard buffer != nil else { return nil }
        
        super.init()
    }
    
    // copy bytes to buffer
    func updateBuffer(bytes: UnsafeRawPointer, length:Int) {
        memcpy(buffer.contents(), bytes, length) // move to shared copy
    }
}

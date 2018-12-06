//
//  MyDevice.swift
//  Ch1Example2HelloTriangle
//
//  Created by chenkai on 2018/12/6.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class MyDevice: NSObject {
    
    private static var s_instance: MyDevice?
    static var shared: MyDevice {
        s_instance = s_instance != nil ? s_instance : MyDevice()
        return s_instance!
    }
    
    // public
    var device: MTLDevice!
    let defaultLibrary: MTLLibrary!
    let defaultQ: MTLCommandQueue!
    
    override init() {
        
        self.device = MTLCreateSystemDefaultDevice()
        self.defaultLibrary = device.makeDefaultLibrary()
        self.defaultQ = device.makeCommandQueue()
        
        super.init()
    }
    
    func makeCommandBuffer() -> MTLCommandBuffer? {
        return self.defaultQ!.makeCommandBuffer()
    }
}

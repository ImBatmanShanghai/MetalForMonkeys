//
//  ViewController.swift
//  Ch4IndexBuffer
//
//  Created by chenkai on 2018/12/7.
//  Copyright © 2018 ImBatman. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(MyMetalView(frame: self.view.frame))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


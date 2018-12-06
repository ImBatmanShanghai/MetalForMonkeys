//
//  ViewController.swift
//  Ch3HelloBuffer
//
//  Created by chenkai on 2018/12/6.
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


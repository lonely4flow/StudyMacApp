//
//  ViewController.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/7.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

class HomeViewController: NSViewController {

    @IBOutlet weak var pathField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnClicked(_ sender: Any) {
        self.push(viewController: TransionDemoViewController())
    }
    

    @IBAction func selectPathBtnClicked(_ sender: Any) {
        self.push(viewController: ResizeImageViewController())
//        let openPanel = NSOpenPanel()
//        // 选择文件夹
//        openPanel.canChooseDirectories = true
//        // 选择文件
//        openPanel.canChooseFiles = false
//        openPanel.allowsMultipleSelection = false
//        openPanel.allowedFileTypes = ["ipa"]
//
//
//        let finded = openPanel.runModal()
//        if .OK == finded {
//            guard let path = openPanel.url?.path else {
//                return
//            }
//            self.pathField.stringValue = path
//        }
    }
    
}


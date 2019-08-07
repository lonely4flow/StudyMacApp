//
//  ViewController.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/7.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

class HomeViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnClicked(_ sender: Any) {
        self.push(viewController: TransionDemoViewController())
    }
    

    @IBAction func selectPathBtnClicked(_ sender: Any) {
    }
    
}


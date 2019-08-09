//
//  ResizeImageViewController.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/9.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa
import HandyJSON

class ResizeImageViewController: NSViewController {

    @IBOutlet weak var iconImageView: LFDragImageView!
    @IBOutlet weak var imagePathField: NSTextField!
    
    @IBOutlet weak var platformBox: NSComboBox!
    @IBOutlet weak var templatePathField: NSTextField!
    @IBOutlet weak var templateBtn: NSButton!
    
    @IBOutlet weak var savePathField: NSTextField!
    
    
    var currentPlatform: Int? {
        didSet {
            let isShow = (currentPlatform! == self.platformBox.numberOfItems-1)
            self.templatePathField.isEnabled = isShow
            self.templateBtn.isEnabled = isShow
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.platformBox.selectItem(at: 0)
        self.currentPlatform = self.platformBox.indexOfSelectedItem
    }
    
    
    @IBAction func selectImgBtnClicked(_ sender: Any) {
            let openPanel = NSOpenPanel()
            // 选择文件夹
            openPanel.canChooseDirectories = false
            // 选择文件
            openPanel.canChooseFiles = true
            openPanel.allowsMultipleSelection = false
            openPanel.allowedFileTypes = ["png","jpg"]
    
    
            let finded = openPanel.runModal()
            if .OK == finded {
                guard let path = openPanel.url?.path else {
                    return
                }
                self.imagePathField.stringValue = path
                self.iconImageView.image = NSImage(contentsOfFile: path)
            }
    }
    
    @IBAction func selectPlatformBtnClicked(_ sender: NSComboBox) {
        self.currentPlatform = sender.indexOfSelectedItem
    }
    
    @IBAction func selectTemplateBtnClicked(_ sender: Any) {
        let openPanel = NSOpenPanel()
        // 选择文件夹
        openPanel.canChooseDirectories = false
        // 选择文件
        openPanel.canChooseFiles = true
        openPanel.allowsMultipleSelection = false
        openPanel.allowedFileTypes = ["json"]
        
        
        let finded = openPanel.runModal()
        if .OK == finded {
            guard let path = openPanel.url?.path else {
                return
            }
            self.templatePathField.stringValue = path
        }
    }
    
    @IBAction func selectSavePathBtnClicked(_ sender: Any) {
        let openPanel = NSOpenPanel()
        // 选择文件夹
        openPanel.canChooseDirectories = true
        // 选择文件
        openPanel.canChooseFiles = false
        openPanel.allowsMultipleSelection = false
        
        
        let finded = openPanel.runModal()
        if .OK == finded {
            guard let path = openPanel.url?.path else {
                return
            }
            self.savePathField.stringValue = path
        }
    }
    
    @IBAction func createBtnClicked(_ sender: Any) {
        if 0 == self.currentPlatform! {
            guard let path = Bundle.main.path(forResource: "ios_Contents", ofType: "json") else {
                return
            }
            guard let json = String.readJson(path: path) as? [String:Any] else {
                return
            }
            guard let images = [ResizeModel].deserialize(from: (json["images"] as! [Any]))  as? [ResizeModel] else {
                return
            }
            let fileFolder = "\(self.savePathField.stringValue)/AppIcon.appiconset"
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: fileFolder) {
                try? fileManager.createDirectory(at: URL(fileURLWithPath: fileFolder), withIntermediateDirectories: true, attributes: nil)
            }
            // 保存json文件
            let _ = (json as NSDictionary).save(path: "\(fileFolder)/Contents.json")
            // 创建图片
            for model in images {
                let savePath = "\(fileFolder)/\(model.filename!)"
                self.iconImageView.image?.save(size: model.sizeVal, path: savePath)
            }
            print("\(json)")
    } else if 1 == self.currentPlatform! {
        guard let path = Bundle.main.path(forResource: "mac_Contents", ofType: "json") else {
            return
        }
        guard let json = String.readJson(path: path) as? [String:Any] else {
            return
        }
        guard let images = [ResizeModel].deserialize(from: (json["images"] as! [Any]))  as? [ResizeModel] else {
            return
        }
        let fileFolder = "\(self.savePathField.stringValue)/AppIcon.appiconset"
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileFolder) {
        try? fileManager.createDirectory(at: URL(fileURLWithPath: fileFolder), withIntermediateDirectories: true, attributes: nil)
        }
        // 保存json文件
        let _ = (json as NSDictionary).save(path: "\(fileFolder)/Contents.json")
        // 创建图片
        for model in images {
        let savePath = "\(fileFolder)/\(model.filename!)"
        self.iconImageView.image?.save(size: model.sizeVal, path: savePath)
        }
        print("\(json)")
   }
        
 }

}

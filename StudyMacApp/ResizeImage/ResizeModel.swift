//
//  ResizeModel.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/10.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa
import HandyJSON

struct ResizeModel: HandyJSON{
    var size: String?
    var idiom: String?
    var scale: String?
    var filename: String?
    
    var sizeVal: NSSize {
        let scaleVal = CGFloat(Double(scale!.lowercased().components(separatedBy: "x").first!) ?? 0)
        let sizeArray = size!.lowercased().components(separatedBy: "x") as [String]
        let widthVal = CGFloat(Double(sizeArray.first!) ?? 0)
        let heightVal = CGFloat(Double(sizeArray.last!) ?? 0)
        let sizeVal = NSSize(width: widthVal*scaleVal, height: heightVal*scaleVal)
        return sizeVal
    }
}

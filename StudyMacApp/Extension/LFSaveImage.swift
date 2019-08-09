//
//  LFSaveImage.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/10.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

extension NSImage {
    func drawImage(size: NSSize) -> NSImage {
        let rect = NSRect(x: 0, y: 0, width: size.width, height: size.height)
//        let percent = CGFloat(0.125)
        //let path = NSBezierPath(roundedRect: rect, xRadius: NSWidth(rect)*percent, yRadius: NSHeight(rect)*percent)
        let reSizeImage = NSImage(size: size)
        
        reSizeImage.lockFocus()
        self.draw(in: rect, from: NSRect.zero, operation: .sourceOver, fraction: 1.0, respectFlipped: true, hints: nil)
        reSizeImage.unlockFocus()
        
        return reSizeImage
    }
    
    func save(size: NSSize,path: String)  {
        guard let imageData = self.drawImage(size: size).tiffRepresentation else {
            return
        }
        guard let outputData = NSBitmapImageRep(data: imageData)?.representation(using: .png, properties: [:]) else {
            return
        }
        do {
            try outputData.write(to: URL(fileURLWithPath: path))
        }catch {
            print("\(error)")
        }
    }
}

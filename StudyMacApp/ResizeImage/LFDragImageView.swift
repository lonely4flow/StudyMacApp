//
//  LFDragImageView.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/9.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

class LFDragImageView: NSImageView {

    var isRoundCorner: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSGraphicsContext.current?.restoreGraphicsState()
        let path = self.isRoundCorner ? NSBezierPath(roundedRect: dirtyRect, xRadius: NSWidth(dirtyRect)*0.125, yRadius: NSHeight(dirtyRect)*0.125) : NSBezierPath(rect: dirtyRect)
        NSColor.red.setStroke()
        path.stroke()
        NSGraphicsContext.current?.saveGraphicsState()
    }
    // MARK: - Drag
    override func draggingEnded(_ sender: NSDraggingInfo) {
        
    }
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pastboard = sender.draggingPasteboard
        guard let data = pastboard.data(forType: .fileURL) else {
            return true
        }
        do {
            guard let fileNames = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String] else {
                return true
            }
            guard let filePath = fileNames.first else {
                return true
            }

            self.image = NSImage(contentsOfFile: filePath)
            
        } catch {
            
        }
        return true
        
    }
}

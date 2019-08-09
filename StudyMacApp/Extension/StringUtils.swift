//
//  StringUtils.swift
//  StudyMacApp
//
//  Created by liuhuan on 2019/8/10.
//  Copyright © 2019 fresh. All rights reserved.
//

import Cocoa

extension String {
    static func readJson(path: String) -> Any? {
        do {
            let contents = try String(contentsOfFile: path)
            return contents.json
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    var json: Any? {
        
        guard let jsonData = self.data(using: .utf8) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        return json
        
    }
}

extension NSDictionary {
    func save(path: String) -> Bool {
        
        try? self.jsonString?.write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
        return true
        
    }
    
    var jsonString: String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }
}

extension NSArray {
    func save(path: String) -> Bool {
        try? self.jsonString?.write(to: URL(fileURLWithPath: path), atomically: true, encoding: .utf8)
        return true
    }
    
    var jsonString: String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return nil
        }
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }
}

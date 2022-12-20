//
//  PersonExtension.swift
//  Demo
//
//  Created by xq on 2022/12/20.
//

import Foundation

extension Person {
    
    @objc dynamic class func hookEat() {
        print("hook class \(#function)")
    }
    
    @objc dynamic func hookEat() {
        print("hook instance \(#function)")
    }
    
}

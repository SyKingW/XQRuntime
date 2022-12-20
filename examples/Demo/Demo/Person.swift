//
//  Person.swift
//  Demo
//
//  Created by xq on 2022/12/20.
//

import Foundation
import XQRuntime


class Person: NSObject {
    
    @objc dynamic class func eat() {
        print("class \(#function)")
    }
    
    @objc dynamic func eat() {
        print("instance \(#function)")
    }
    
}


//
//  ViewController.swift
//  Demo
//
//  Created by xq on 2022/12/15.
//

import UIKit
import XQRuntime


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.oc()
        self.xqSwift()
        self.testCoder()
    }
    
    func oc() {
        print("\(Add.add(withA: 1, b: 2)), \(Add().add(withA: 3, b: 2))")
        print("\(Add.hook(withA: 1, b: 2)), \(Add().hook(withA: 3, b: 2))")
        
        // 把 add 的方法替换为 hookAdd
        Add.exchangeClassMethod(withOriginSEL: #selector(Add.add(withA:b:)), otherSEL: #selector(Add.hook(withA:b:)))
        Add.exchangeInstanceMethod(withOriginSEL: #selector(Add.add(withA:b:)), otherSEL: #selector(Add.hook(withA:b:)))
        
        // 这里调用 add，变成了 hookAdd
        // hookAdd，变成了 add
        print("\(Add.add(withA: 1, b: 2)), \(Add().add(withA: 3, b: 2))")
        print("\(Add.hook(withA: 1, b: 2)), \(Add().hook(withA: 3, b: 2))")
    }
    
    func xqSwift() {
        
        Person.eat()
        Person().eat()
        Person.hookEat()
        Person().hookEat()
        
        // swift 也一样使用，不过 func 面前得加上 @objc dynamic
        Person.exchangeInstanceMethod(withOriginSEL: #selector(Person.eat), otherSEL: #selector(Person.hookEat))
        Person.exchangeClassMethod(withOriginSEL: #selector(Person.eat), otherSEL: #selector(Person.hookEat))
        
        Person.eat()
        Person().eat()
        Person.hookEat()
        Person().hookEat()
        
    }
    
    func testCoder() {
        let s = School()
        s.xqNSString = "大学名称"
        s.xqMutableString = "大学"
        
        s.xqDictionary = ["asd": 0]
        
        s.xqArray = ["asd", "123"]
        s.xqMutableArray = ["asd", "123", "mu"]
        
        s.xqSet = ["set", "set1"]
        
        s.xqNSInteger = 100
        s.xqCGFloat = 50.55
        
        s.xqCGRect = CGRect.init(x: 0, y: 100, width: 0, height: 100)
        s.xqCGPoint = CGPoint.init(x: 30, y: 30)
//        s.xqCGSize = CGSize.zero
        
//        s.xqBOOL = false
        
        let tm = TestModel()
        tm.xqInteger = 33
        s.xqCustomModel = tm
        
        
        let d = try? NSKeyedArchiver.archivedData(withRootObject: s, requiringSecureCoding: true)
        print("data: \(String(describing: d))")
        
        if let data = d {
            /*
             iOS 15 之后出现该问题
             *** -[NSKeyedUnarchiver validateAllowedClass:forKey:] allowed unarchiving safe plist type ''NSString'
             
             所以这里要用 ofClasses，增加 NSString.self 上去
             */
            if let s1 = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [School.self, TestModel.self, NSString.self, NSDictionary.self, NSNumber.self, NSArray.self, NSSet.self], from: data) as? School {
                print("解析成功: \(s1.xqNSString), \(s1.xqNSInteger), \(s1.xqCGFloat) \(s1.xqMutableString) \(s1.xqDictionary) \(s1.xqCGRect) \(s1.xqCGPoint) \(s1.xqArray) \(s1.xqMutableArray) \(s1.xqSet) \(s1.xqCustomModel.xqInteger)")
            }else {
                print("解析错误")
            }
        }
    }


}


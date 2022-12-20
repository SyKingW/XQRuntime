# XQRuntime



平常在项目里面需要一些特殊, 或者不想做重复工作, 比如实现NSCoding协议, 交换方法, 把Button和View的点击转为block, 还有动态改变语言等等, 这时候经常会使用到Runtime，所以就在空闲时间封装了下。 

# 导入

```
pod 'XQRuntime', :git => 'https://github.com/SyKingW/XQRuntime.git'
```

# 使用

## NSObject+XQExchangeIMP 使用

用 runtime hook 方法
 
```swift
class Person: NSObject {
    @objc dynamic class func eat() {
        print("class \(#function)")
    }
}

extension Person {
    @objc dynamic class func hookEat() {
        print("hook class \(#function)")
    }
}

// 交换两个方法
Person.exchangeClassMethod(withOriginSEL: #selector(Person.eat), otherSEL: #selector(Person.hookEat))

// 这时候调用 eat 就会走 hookEat
// 调用 hookEat 就走 eat
Person.eat()
Person.hookEat()
```

## NSObject+XQArchiverData 使用

利用 runtime 对 NSSecureCoding 的封装

```objective-c
// .h 遵守 NSSecureCoding
@interface School : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *name;

@end

// .m 写入宏
@implementation School

XQArchiverM

@end
```

```swift
let model = School()
model.name = "学习名称"
// encode 为 Data
let data = try? NSKeyedArchiver.archivedData(withRootObject: s, requiringSecureCoding: true)
// decode 为 Model
let model = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [School.self, NSString.self], from: data) as? School
```
 
 # 错误

 ## iOS 15 之后解包错误
 
 iOS 15 之后以下代码会出现错误 *** -[NSKeyedUnarchiver validateAllowedClass:forKey:] allowed unarchiving safe plist type ''NSString'
 
 ```swift
 let model = try? NSKeyedUnarchiver.unarchivedObject(ofClass: 你的类.self, from: data)
 ```
 
 解决方法，加上你 model 要解析的类
 
 ```swift
 let model = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [你的类.self, NSString.self, NSDictionary.self, NSNumber.self, NSArray.self, NSSet.self], from: data) as? 你的类
 ```




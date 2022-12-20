//
//  NSObject+ArchiverData.h
//  Runtime
//
//  Created by ladystyle100 on 2017/6/9.
//  Copyright © 2017年 WangXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 遵守 NSSecureCoding, 如没有什么需要自己手动写入的, 可以直接在.m 调用该宏就行 */
#define XQArchiverM - (instancetype)initWithCoder:(NSCoder *)aDecoder {\
self = [super init];\
if (self) {\
[self decoder:aDecoder];\
}\
return self;\
}\
\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
[self encoder:aCoder];\
}\
+ (BOOL)supportsSecureCoding {\
    return  true;\
}\

/**
 
 用 runtime 对 NSSecureCoding 进行封装
 
 @note 示例
 
 ```oc
 // .h 遵守 NSSecureCoding
 \@interface School : NSObject<NSSecureCoding>
 @property (nonatomic, copy) NSString *name;
 @end
 
 // .m 写入宏
 \@implementation School
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
 
 @note 解包错误
 
 iOS 15 之后以下代码会出现错误 *** -[NSKeyedUnarchiver validateAllowedClass:forKey:] allowed unarchiving safe plist type ''NSString'
 
 ```swift
 let model = try? NSKeyedUnarchiver.unarchivedObject(ofClass: 你的类.self, from: data)
 ```
 
 解决方法，加上你 model 要解析的类
 
 ```swift
 let model = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [你的类.self, NSString.self, NSDictionary.self, NSNumber.self, NSArray.self, NSSet.self], from: data) as? 你的类
 ```
 
 */
@interface NSObject (XQArchiverData)

/** 解档 */
- (void)decoder:(NSCoder *)coder;

/** 归档 */
- (void)encoder:(NSCoder *)coder;

@end

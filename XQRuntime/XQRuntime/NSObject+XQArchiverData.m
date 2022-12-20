//
//  NSObject+ArchiverData.m
//  Runtime
//
//  Created by ladystyle100 on 2017/6/9.
//  Copyright © 2017年 WangXQ. All rights reserved.
//

#import "NSObject+XQArchiverData.h"
#import <objc/runtime.h> // 包含对类、成员变量、属性、方法的操作
//#import <objc/message.h> // 包含消息机制

@implementation NSObject (XQArchiverData)

- (void)decoder:(NSCoder *)coder {
    [self coder:coder isDecoder:YES];
}

- (void)encoder:(NSCoder *)coder {
    [self coder:coder isDecoder:NO];
}

/** isDecoder: 是否解档 */
- (void)coder:(NSCoder *)coder isDecoder:(BOOL)isDecoder {
    // 获取该属性的个数 unsigned int: 无符号整形
    unsigned int count = 0;
    // 获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i =0; i < count; i ++) {
        // 根据objc_property_t获得其属性的名称
        objc_property_t property = properties[i];
        // 解码每个属性,利用kVC取出每个属性对应的数值
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        
        const char *a = property_getAttributes(property);
        NSString *attr = [NSString stringWithUTF8String:a];
        
        // 是否解档
        if (isDecoder) {
            if ([attr hasPrefix:@"Tq,"] || [attr hasPrefix:@"Ti,"] || [attr hasPrefix:@"Tc,"] || [attr hasPrefix:@"Ts,"]) {
                NSInteger value = [coder decodeIntegerForKey:key];
                [self setValue:[NSNumber numberWithInteger:value] forKey:key];
                
            }else if ([attr hasPrefix:@"Tf,"]) {
                float value = [coder decodeFloatForKey:key];
                [self setValue:[NSNumber numberWithFloat:value] forKey:key];
            }else if ([attr hasPrefix:@"Td,"]) {
                double value = [coder decodeDoubleForKey:key];
                [self setValue:[NSNumber numberWithDouble:value] forKey:key];
                
            }else if ([attr hasPrefix:@"TB,"]) {
                BOOL value = [coder decodeBoolForKey:key];
                [self setValue:[NSNumber numberWithBool:value] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGRect"]) {
                CGRect value = [coder decodeCGRectForKey:key];
                [self setValue:[NSValue valueWithCGRect:value] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGPoint"]) {
                CGPoint value = [coder decodeCGPointForKey:key];
                [self setValue:[NSValue valueWithCGPoint:value] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGSize"]) {
                CGSize value = [coder decodeCGSizeForKey:key];
                [self setValue:[NSValue valueWithCGSize:value] forKey:key];
                
            }else {
//                NSLog(@"decode name: %s attr: %@", name, attr);
                id value = [coder decodeObjectForKey:key];
                [self setValue:value forKeyPath:key];
            }
            
        }else {
            id value = [self valueForKeyPath:key];
            
            // 还要增加类型的话，就类似现在这样去判断就行
            if ([attr hasPrefix:@"Tq,"] || [attr hasPrefix:@"Ti,"] || [attr hasPrefix:@"Tc,"] || [attr hasPrefix:@"Ts,"]) {
                NSNumber *v = value;
                [coder encodeInteger:[v integerValue] forKey:key];
                
            }else if ([attr hasPrefix:@"Tf,"]) {
                NSNumber *v = value;
                [coder encodeFloat:[v floatValue] forKey:key];
            }else if ([attr hasPrefix:@"Td,"]) {
                NSNumber *v = value;
                [coder encodeDouble:[v doubleValue] forKey:key];
                
            }else if ([attr hasPrefix:@"TB,"]) {
                NSNumber *v = value;
                [coder encodeBool:[v boolValue] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGRect"]) {
                NSValue *v = value;
                [coder encodeCGRect:[v CGRectValue] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGPoint"]) {
                NSValue *v = value;
                [coder encodeCGPoint:[v CGPointValue] forKey:key];
                
            }else if ([attr hasPrefix:@"T{CGSize"]) {
                NSValue *v = value;
                [coder encodeCGSize:[v CGSizeValue] forKey:key];
                
            }else {
//                NSLog(@"encode name: %s attr: %@ class: %@", name, attr, NSStringFromClass([value class]));
                [coder encodeObject:value forKey:key];
            }
            
        }
    }
    
    // 释放
    free(properties);
}

@end













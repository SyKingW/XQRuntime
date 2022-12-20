//
//  Add.m
//  Demo
//
//  Created by xq on 2022/12/20.
//

#import "Add.h"

@implementation Add

+ (NSInteger)addWithA:(NSInteger)a b:(NSInteger)b {
    NSLog(@"class method %@, %@", NSStringFromClass(self), NSStringFromSelector(_cmd));
    return a + b;
}

- (NSInteger)addWithA:(NSInteger)a b:(NSInteger)b {
    NSLog(@"instance method %@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return a + b;
}

@end

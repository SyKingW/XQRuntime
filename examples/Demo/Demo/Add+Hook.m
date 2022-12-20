//
//  Add+Hook.m
//  Demo
//
//  Created by xq on 2022/12/20.
//

#import "Add+Hook.h"

@implementation Add (Hook)

+ (NSInteger)hookAddWithA:(NSInteger)a b:(NSInteger)b {
    NSLog(@"hook class method %@, %@", NSStringFromClass(self), NSStringFromSelector(_cmd));
    return a + b;
}

- (NSInteger)hookAddWithA:(NSInteger)a b:(NSInteger)b {
    NSLog(@"hook instance method %@, %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    return a + b;
}

@end

//
//  Add+Hook.h
//  Demo
//
//  Created by xq on 2022/12/20.
//

#import "Add.h"

NS_ASSUME_NONNULL_BEGIN

@interface Add (Hook)

+ (NSInteger)hookAddWithA:(NSInteger)a b:(NSInteger)b;

- (NSInteger)hookAddWithA:(NSInteger)a b:(NSInteger)b;

@end

NS_ASSUME_NONNULL_END

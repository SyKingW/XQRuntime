//
//  School.h
//  Demo
//
//  Created by xq on 2022/12/20.
//

#import <Foundation/Foundation.h>

#import "TestModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface School : NSObject<NSSecureCoding>

@property (nonatomic, assign) CGFloat xqCGFloat;

@property (nonatomic, assign) float xqFloat;

@property (nonatomic, assign) double xqDouble;


@property (nonatomic, assign) NSInteger xqNSInteger;

@property (nonatomic, assign) int xqInt;

@property (nonatomic, assign) int8_t xqInt8;

@property (nonatomic, assign) int16_t xqInt16;

@property (nonatomic, assign) int32_t xqInt32;

@property (nonatomic, assign) int64_t xqInt64;

@property (nonatomic, assign) BOOL xqBOOL;

@property (nonatomic, assign) bool xqbool;


@property (nonatomic, assign) CGRect xqCGRect;

@property (nonatomic, assign) CGPoint xqCGPoint;

@property (nonatomic, assign) CGSize xqCGSize;



@property (nonatomic, copy) NSString *xqNSString;

@property (nonatomic, strong) NSMutableString *xqMutableString;

@property (nonatomic, copy) NSDictionary *xqDictionary;

@property (nonatomic, copy) NSArray *xqArray;

@property (nonatomic, copy) NSSet *xqSet;

@property (nonatomic, strong) NSMutableDictionary *xqMutableDictionary;

@property (nonatomic, strong) NSMutableArray *xqMutableArray;

@property (nonatomic, strong) NSMutableSet *xqMutableSet;

@property (nonatomic, strong) TestModel *xqCustomModel;

@end

NS_ASSUME_NONNULL_END

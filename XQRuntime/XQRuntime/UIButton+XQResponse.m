//
//  UIButton+XQResponse.m
//  XQLocalizedString
//
//  Created by ladystyle100 on 2017/9/6.
//  Copyright © 2017年 WangXQ. All rights reserved.
//

#import "UIButton+XQResponse.h"
//#import <objc/runtime.h>
#import <objc/message.h>

@interface UIButton ()

@end

@implementation UIButton (XQResponse)

- (void)xq_addEvent:(UIControlEvents)event callback:(XQBtnClick)callback {
    if (!callback) {
        NSLog(@"click is nil");
        return;
    }
    
    const char * str =  [self getEventStr:event];
    objc_setAssociatedObject(self, str, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    /** 现在模拟写两个, 可以照着这个思路, 一个一个全部写下去 */
    SEL sel = nil;
    switch (event) {
        case UIControlEventTouchDown:{
            sel = @selector(respondsToTouchDown:);
        }
            break;
            
        case UIControlEventTouchUpInside:{
            sel = @selector(respondsToTouchUpInside:);
        }
            break;
            
        default:
            // 默认为点下内部起来
            event = UIControlEventTouchUpInside;
            sel = @selector(respondsToTouchUpInside:);
            break;
    }
    
    [self addTarget:self action:sel forControlEvents:event];
}

/** 用char做key */
- (const char *)getEventStr:(UIControlEvents)events {
    // 其实这里也可以直接把events转成字符串, 然后直接返回出去
    NSString *str = [NSString stringWithFormat:@"%ld", (unsigned long)events];
    return str.UTF8String;
}

- (void)clickWithEvents:(UIControlEvents)events {
    const char * str =  [self getEventStr:events];
    XQBtnClick click = objc_getAssociatedObject(self, str);
    if (click) {
        click(self);
    }else {
        NSLog(@"block不存在");
    }
}

#pragma mark -- respondsTo... 这边就比较苦逼了，得一直写完所有方法, 目前没想到比较好的解决方法

- (void)respondsToTouchDown:(UIButton *)sender {
    [self clickWithEvents:UIControlEventTouchDown];
}

- (void)respondsToTouchUpInside:(UIButton *)sender {
    [self clickWithEvents:UIControlEventTouchUpInside];
}

//- (void)dealloc {
//    objc_removeAssociatedObjects(self);
//}

@end


















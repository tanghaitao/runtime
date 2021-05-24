//
//  TZPerson.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"
#import "TZDog.h"
#import <objc/runtime.h>

@implementation TZPerson

- (id) forwardingTargetForSelector:(SEL)aSelector {
    
        if (aSelector == @selector(walk)) {
            return [TZDog new];// id, 只能转实例方法，return [TZDog class] 报错
        }
    
    return [super forwardingTargetForSelector:aSelector];
}

//方法名注册
- (NSMethodSignature* ) methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(walk)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void) forwardInvocation:(NSInvocation *)anInvocation {
    
    NSLog(@"%s", __func__);//[TZPerson forwardInvocation:]
    
    //    [anInvocation invokeWithTarget:[TZDog new]];//[TZDog walk]
    
    /// 转发给自己
//    anInvocation.target = [TZDog new];// -[TZDog run]
    anInvocation.selector = @selector(run);//[TZPerson run]
    // anImp
    [anInvocation invoke];
}

- (void) run {
    NSLog(@"%s", __func__);
}

@end

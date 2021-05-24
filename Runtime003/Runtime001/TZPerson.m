//
//  TZPerson.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"
#import <objc/runtime.h>

@implementation TZPerson

//- (void) walk {
//    NSLog(@"%s", __func__);
//}

void walk2() {// c方法
    NSLog(@"%s", __func__);
}


- (void) run {//oc方法
    NSLog(@"%s", __func__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    
   // 元类
    // 实例对象、    类对象、       元类对象，
    //    p   、[p class],   object_getClass("类名")
    //   实例对象isa找到类，类通过isa找到元类，元类通过is找到根元类，
    // 实例对象存的是特殊的实例方法。   [p method0]
    // 类对象存的是所有特殊实例的方法 - 减号 [p1 method0] [p2 method0] [p3 method0]
    // 元类对象存的是类的所有方法。 + 加号[Person method1];
//    if (sel == @selector(walk)) { //c方法
//        return class_addMethod(self, sel, (IMP)walk2, "v@:");
//    }
    
    if (sel == @selector(walk)) {//oc方法
        Method runMethod = class_getInstanceMethod(self, @selector(run));
        IMP runIMP = method_getImplementation(runMethod);
        const char* types = method_getTypeEncoding(runMethod);
        NSLog(@"%s", types);//v16@0:8 总共16个字节，从0-8.
        return class_addMethod(self, sel, runIMP, types);
//        class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    }
    

    
    return [super resolveInstanceMethod:sel];
}

@end

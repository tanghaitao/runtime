//
//  main.m
//  Runtime001
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZPerson.h"
#import "TZDog.h"
#import <objc/runtime.h>

struct method_t {
    SEL name;
    const char *types;
    IMP imp;
};


// 代码--> 编译链接--->执行

//void run() {
//    NSLog(@"%s", __func__);
//}

void run();// c语言编译什么就执行什么，编译报错，oc语言可以动态修改编译好的方法。



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //        run();
        TZPerson* p = [TZPerson new];
        
        TZDog* d = [TZDog new];
        
        //方法名
        Method m1 = class_getInstanceMethod([p class], @selector(walk));
        Method m2 = class_getInstanceMethod([d class], @selector(run));// 其他类的其他方法
//        struct method_t *m2 = class_getInstanceMethod([d class], @selector(run));//[TZDog run]
//        函数体
//        IMP imp = method_getImplementation(m2);
//        method_setImplementation(m1, m2->imp);//[TZPerson run]
//        object_setClass(p, [d class]);//[TZDog walk] //其他类
//        method_setImplementation(m1, (IMP)run); //调用c语言的函数
        [p walk];
    }
    return 0;
}

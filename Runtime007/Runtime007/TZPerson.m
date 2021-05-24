//
//  TZPerson.m
//  Runtime007
//
//  Created by hzg on 2018/9/10.
//  Copyright © 2018年 tz. All rights reserved.
//

#import "TZPerson.h"
#import <objc/runtime.h>

@implementation TZPerson

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* name = ivar_getName(var);
        NSString* key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
    
}

//面向对象的程序在运行的时候会创建一个复杂的对象图，经常要以二进制的方法序列化这个对象图，这个过程叫做Archiving. 二进制流可以通过网络或写入文件中（来源于某教材的一段话）
//
//本人的理解是当你于写数据需要本地存储时，即将你的数据写到硬盘上的时候，你就必须对他进行序列化，转换成二进制文件，从而便于在磁盘上的读写，同理在取出的时候必须将其在反序列化，这样才能将数据读出来，就好比加密和揭秘的过程。
//将一个自己定义的类放进去（写进plist ），在读出来
//其实在nsstring 的类的定义中已经添加了协议 即他是实现了nscoding 代理的方法的。

//从coder中读取数据，保存到相应的变量中，即反序列化数据
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self == [super init]) {
        unsigned int count = 0;
        Ivar* ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            Ivar var = ivars[i];
            const char* name = ivar_getName(var);
            NSString* key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        
        free(ivars);
    }
    return self;
}

@end

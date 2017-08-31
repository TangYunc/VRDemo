//
//  BaseModel.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
// 自定义初始化方法（带有自动映射属性的作用）
- (instancetype)initWithContentDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 1.获取映射关系字典
        NSDictionary *keyAndAttDic = [self keyAndAttWithContentDic:dic];
        // 2.遍历所有的属性开始设置内容
        for (NSString *key in keyAndAttDic) {
            // key设置内容字典的名字
            // 01 获取这个key里面的内容需要设置到模型对象属性的名字
            NSString *attName = keyAndAttDic[key];
            // 02 拼接当前属性名字的set:方法
            SEL setMethod = [self getSetMethodWithAttName:attName];
            if ([self respondsToSelector:setMethod]) {
                // 03 给当前对象设置内容
                [self performSelector:setMethod withObject:dic[key]];
            }
        }
        
    }
    return self;
}

// 02 拼接当前属性名字的set:方法
- (SEL)getSetMethodWithAttName:(NSString *)attName
{
    // title ->setTitle:
    // 1.获取属性名字首字母的大小
    NSString *firstName = [attName substringToIndex:1].capitalizedString;
    // 2.获取剩余的名字
    NSString *lastName = [attName substringFromIndex:1];
    // 3.拼接完整的方法名字
    NSString *setAttName = [NSString stringWithFormat:@"set%@%@:",firstName,lastName];
    return NSSelectorFromString(setAttName);
}
// 1.获取当前字典的映射关系
- (NSDictionary *)keyAndAttWithContentDic:(NSDictionary *)dic
{
    // 创建映射关系字典
    NSMutableDictionary *keyAndAttDic = [NSMutableDictionary dictionary];
    // 给字典设置默认的映射关系
    for (NSString *key in dic) {
        // key :字典里面的key
        // value :model里面属性的名字
        [keyAndAttDic setObject:key forKey:key];
    }
    return keyAndAttDic;
}

@end

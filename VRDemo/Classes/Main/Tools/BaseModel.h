//
//  BaseModel.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
// 自定义初始化方法（带有自动映射属性的作用）
- (instancetype)initWithContentDic:(NSDictionary *)dic;

// 获取当前字典的映射关系
- (NSDictionary *)keyAndAttWithContentDic:(NSDictionary *)dic;
@end

//
//  ImageModel.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
// 自定义初始化方法
- (instancetype)initWithContentDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.imageId = dic[@"id"];
        self.image = dic[@"image"];
        self.type = dic[@"type"];
    }
    return self;
}
@end

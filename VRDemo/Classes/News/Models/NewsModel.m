//
//  NewsModel.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
// 自定义初始化方法
- (instancetype)initWithContentDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.newsId = dic[@"id"];
        self.type = dic[@"type"];
        self.title = dic[@"title"];
        self.summary = dic[@"summary"];
        self.image = dic[@"image"];
    }
    return self;
}
@end

//
//  NewsModel.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel
/*
 "id" : 1491520,
 "type" : 0,
 "title" : "科幻大作《全面回忆》全新预告片发布",
 "summary" : "",
 "image" : "http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg"
 */

@property (nonatomic, strong) NSString *newsId; // 新闻id
@property (nonatomic, strong) NSNumber *type; // 新闻id
@property (nonatomic, strong) NSString *title; // 新闻id
@property (nonatomic, strong) NSString *summary; // 新闻id
@property (nonatomic, strong) NSString *image; // 新闻id

// 自定义初始化方法
- (instancetype)initWithContentDic:(NSDictionary *)dic;
@end

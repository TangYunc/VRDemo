//
//  ImageModel.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//
/*
 {
 "id": 2238621,
 "image": "http://img31.mtime.cn/pi/2013/02/04/093444.29353753_1280X720.jpg",
 "type": 6
 }
 */

#import "BaseModel.h"

@interface ImageModel : BaseModel
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *type;

// 自定义初始化方法
- (instancetype)initWithContentDic:(NSDictionary *)dic;

@end

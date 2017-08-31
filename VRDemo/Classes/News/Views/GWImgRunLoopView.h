//
//  GWImgRunLoopView.h
//  cps
//
//  Created by 唐云川 on 2017/3/27.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWImgRunLoopView : UIView
/** 本地图片数组*/
@property (nonatomic,strong) NSArray *imgArray;
/** 网络图片数组*/
@property (nonatomic,strong) NSArray *imgUrlArray;
/** 图片点击调用*/
- (void)touchImageIndexBlock:(void (^)(NSInteger index))block;

- (instancetype)initWithFrame:(CGRect)frame placeholderImg:(UIImage *)img;
@end

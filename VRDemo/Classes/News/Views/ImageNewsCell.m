//
//  ImageNewsCell.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "ImageNewsCell.h"

@implementation ImageNewsCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1 设置视图透明
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
        // 2 创建图片视图
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置图片视图的大小和内容
    _titleImageView.frame = self.bounds;
    NSURL *imageUrl = [NSURL URLWithString:self.model.image];
    [_titleImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"zanwu"]];
}

@end

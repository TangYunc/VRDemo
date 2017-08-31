//
//  AlbumCell.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
        // 创建滑动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth, kScreenHeight)];
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 1.5;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
        // 创建图片视图
        _imageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imageView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 还原缩放比例
    _scrollView.zoomScale = 1.0;
    // 设置图片的内容
    NSURL *imageUrl = [NSURL URLWithString:self.imageName];
    [_imageView sd_setImageWithURL:imageUrl];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

@end

//
//  CarouseCell.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/31.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "CarouseCell.h"
#import "ImageNewsViewController.h"
#import "WebNewsViewController.h"


@interface CarouseCell ()

/** 图片数组*/
@property (nonatomic,strong) NSMutableArray *imgMarr;


@end
@implementation CarouseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        //初始化子视图
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    
    _imgRunView = [[GWImgRunLoopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150) placeholderImg:[UIImage imageNamed:@"DefaultIcon大"]];
    NSLog(@"theHeight:%f",self.frame.size.height);
    [self.contentView addSubview:_imgRunView];
    //间隙视图
    _gapView = [[UIView alloc] initWithFrame:CGRectZero];
    _gapView.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    [self.contentView addSubview:_gapView];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _imgRunView.imgUrlArray = self.imgMarr;
    [_imgRunView  touchImageIndexBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
        [self choiceTheImageIndex:index];
    }];
    CGFloat gapViewHeight = 0;
    if ([self.tempShowGap isEqualToString:@"show"]) {
        gapViewHeight = 0;
    }else{
        gapViewHeight = 10 * KWidth_ScaleH;
    }
    _gapView.frame = CGRectMake(0, _imgRunView.bottom, self.width, gapViewHeight);
}

#pragma mark -- method
- (void)choiceTheImageIndex:(NSInteger)index{
    
    NSLog(@"点击了第%ld图",(long)index);
    NSArray *items = self.bannerList;
    for (int i = 0; i < items.count; i++) {
        NewsModel *dataListItem = items[i];
        if (index == (NSInteger)i) {
            if (dataListItem.type.intValue == 0) {
                // 点击的是普通新闻
                WebNewsViewController *webNewsVC = [[WebNewsViewController alloc] init];
                webNewsVC.hidesBottomBarWhenPushed = YES;
                [self.viewControler.navigationController pushViewController:webNewsVC animated:YES];
            } else if (dataListItem.type.intValue == 1) {
                // 点击的是图片新闻
                ImageNewsViewController *imageNewsVC = [[ImageNewsViewController alloc] init];
                imageNewsVC.hidesBottomBarWhenPushed = YES;
                [self.viewControler.navigationController pushViewController:imageNewsVC animated:YES];
            }
            
        }
    }
    
    
}
#pragma mark - 根据颜色生成图片
- (UIImage *)generateImageFromColor:(UIColor *)color{
    
    UIGraphicsBeginImageContext(CGSizeMake(1, 1));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

#pragma mark -- 懒加载
- (NSMutableArray *)imgMarr{
    if (!_imgMarr) {
        NSMutableArray *imageUrlArr = [NSMutableArray array];
        for (NewsModel *tempModel in self.bannerList) {
            [imageUrlArr addObject:tempModel.image];
        }
        
        NSArray *imageArr = [imageUrlArr copy];
        NSArray *tempImageArr = imageArr;
        _imgMarr = [NSMutableArray arrayWithCapacity:8];
        for (int i=0; i<tempImageArr.count; i++) {
            NSString *imgUrl = tempImageArr[i];
            [_imgMarr addObject:imgUrl];
        }
    }
    return _imgMarr;
}
@end

//
//  CarouseCell.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/31.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWImgRunLoopView.h"
#import "NewsModel.h"

@interface CarouseCell : UITableViewCell
{
    GWImgRunLoopView *_imgRunView;
    UIView *_gapView;
    
}
@property (nonatomic, copy) NSString *tempShowGap;
@property (nonatomic, copy) NSArray *bannerList;
@property (nonatomic, strong) NewsModel *model;
@end

//
//  NewsHeaderCell.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsHeaderCell : UITableViewCell
{
    UIImageView *_titleImageView;   // 标题图片
    UILabel *_titleLabel;           // 新闻标题
}

@property (nonatomic, strong) NewsModel *model;
@end

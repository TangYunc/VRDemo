//
//  NewsCell.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@class NewsCell;
@protocol NewsCellDelegate <NSObject>

//不想看
- (void)newsCell:(NewsCell *)newsCell currentIndexPath:(NSIndexPath *)currentIndexPath clickExplainBtnShowStatus:(BOOL)showStatus;
//想看
- (void)newsCell:(NewsCell *)newsCell currentIndexPath:(NSIndexPath *)currentIndexPath;

@end


@interface NewsCell : UITableViewCell
{
    UIImageView *_titleImageView;       //  标题图片
    UILabel *_titleLabel;               //  标题文本
    UIImageView *_typeImageView;         //  新闻类型图片
    UILabel *_detailLabel;              //  简介文本
    UIButton *_maskBtn;                 //屏蔽按钮
}

@property (nonatomic, weak) id <NewsCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NewsModel *model;
@property (nonatomic, copy) NSString *fromWhere;
@end

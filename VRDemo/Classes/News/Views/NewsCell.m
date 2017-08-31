//
//  NewsCell.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "NewsCell.h"


@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 清除背景颜色
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = nil;
        
        // 创建子视图
        // 01 创建标题图片
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleImageView];
        
        // 02 创建标题
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor orangeColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:_titleLabel];
        
        // 03 创建新闻类型图片
        _typeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_typeImageView];
        
        // 04 创建新闻简介
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_detailLabel];
        
        //05 屏蔽按钮
        _maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskBtn.frame = CGRectZero;
        [_maskBtn setTitle:@"不想看" forState:UIControlStateNormal];
        [_maskBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _maskBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_maskBtn addTarget:self action:@selector(maskBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_maskBtn];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

/*
 重点：单元格由于数据改变了视图的位置和是否显示-有if设置就必须写else的设置
 */

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 1.设置标题视图
    _titleImageView.frame = CGRectMake(10, 5, 70, 70);
    NSURL *imageUrl = [NSURL URLWithString:self.model.image];
    [_titleImageView sd_setImageWithURL:imageUrl];
    
    // 2.设置标题文本
    _titleLabel.frame = CGRectMake(_titleImageView.right + 10, 15, kScreenWidth - _titleImageView.right - 10 - 10, 20);
    _titleLabel.text = self.model.title;
    
    // 3.设置新闻类型图片
    _typeImageView.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 13, 16, 12);
    // 0:普通新闻 1:图片新闻 2:视频新闻
    if (self.model.type.intValue == 0) {
        // 是普通新闻，没图片显示
        // 1.隐藏图片
        _typeImageView.hidden = YES;
    } else if (self.model.type.intValue == 1) {
        // 显示图片
        _typeImageView.hidden = NO;
        // 是图片新闻
        _typeImageView.image = [UIImage imageNamed:@"sctpxw"];
    } else {
        // 显示图片
        _typeImageView.hidden = NO;
        // 是视频新闻
        _typeImageView.image = [UIImage imageNamed:@"scspxw"];
    }
    
    // 4.设置详情文本
    if (self.model.type.intValue == 0) {
        // 没有类型图片
        _detailLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom + 10, _titleLabel.width, 18);
    } else {
        // 有类型图片
        _detailLabel.frame = CGRectMake(_typeImageView.right + 10, _titleLabel.bottom + 10, _titleLabel.width - 16 - 10, 18);
    }
    // 设置内容
    _detailLabel.text = self.model.summary;
    
    _maskBtn.frame = CGRectMake(0, 0, 60, 30);
    _maskBtn.right = self.width - 10;
    _maskBtn.bottom = self.height - 5;
    if ([self.fromWhere isEqualToString:@"maskListTableView"]) {
        [_maskBtn setTitle:@"想看" forState:UIControlStateNormal];
    }else if([self.fromWhere isEqualToString:@"NewsViewControllerTableView"]){
        [_maskBtn setTitle:@"不想看" forState:UIControlStateNormal];
    }
}

#pragma mark -- 按钮事件
- (void)maskBtnAction:(UIButton *)button{
    
    if ([self.fromWhere isEqualToString:@"maskListTableView"]) {
        if ([self.delegate respondsToSelector:@selector(newsCell:currentIndexPath:)]) {
            [self.delegate newsCell:self currentIndexPath:self.currentIndexPath];
        }
    }else if([self.fromWhere isEqualToString:@"NewsViewControllerTableView"]){
        if ([self.delegate respondsToSelector:@selector(newsCell:currentIndexPath:clickExplainBtnShowStatus:)]) {
            [self.delegate newsCell:self currentIndexPath:self.currentIndexPath clickExplainBtnShowStatus:YES];
        }
    }
}
@end

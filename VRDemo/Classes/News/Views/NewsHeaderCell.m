//
//  NewsHeaderCell.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "NewsHeaderCell.h"

@implementation NewsHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 创建子视图
        // 01 创建标题图片
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleImageView];
        
        // 02 创建标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置图片的大小和内容
    _titleImageView.frame = self.bounds;
    NSURL *imageUrl = [NSURL URLWithString:self.model.image];
    [_titleImageView sd_setImageWithURL:imageUrl];
    
    // 2.设置文本的大小
    _titleLabel.frame = CGRectMake(0, self.height - 20,     kScreenWidth, 20);
    _titleLabel.text = [NSString stringWithFormat:@"  %@",self.model.title];
}


@end

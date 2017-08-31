//
//  ImageNewsCell.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@interface ImageNewsCell : UICollectionViewCell
{
    UIImageView *_titleImageView;   // 图片视图
}

@property (nonatomic, strong) ImageModel *model;
@end

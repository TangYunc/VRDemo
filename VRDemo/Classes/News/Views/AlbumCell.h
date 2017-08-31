//
//  AlbumCell.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UICollectionViewCell<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}

@property (nonatomic, strong) NSString *imageName;

@end

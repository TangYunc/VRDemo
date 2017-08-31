//
//  AlbumViewController.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "BaseViewController.h"

@interface AlbumViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, assign) int selectedIndex;    // 点击图片的索引位置

@end

//
//  ImageNewsViewController.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "BaseViewController.h"

@interface ImageNewsViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
}
@property (nonatomic, copy) NSArray *dataList;

@end

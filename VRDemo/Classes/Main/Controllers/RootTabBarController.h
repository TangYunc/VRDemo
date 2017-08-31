//
//  RootTabBarController.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTabBarController : UITabBarController
{
    UIImageView *_tabBarView;   // 自定义标签栏
    UIImageView *_selectedView; // 选中背景视图
}
@end

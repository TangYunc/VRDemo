//
//  NewsViewController.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "BaseViewController.h"
#import "maskListTableView.h"

@interface NewsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    maskListTableView *_maskListTableView;
}

@property (nonatomic, copy) NSArray *dataList; // 新闻列表数据
@property (nonatomic, copy) NSArray *bannerList; // 新闻列表banner数据

@end

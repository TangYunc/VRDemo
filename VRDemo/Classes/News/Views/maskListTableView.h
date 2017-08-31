//
//  maskListTableView.h
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class maskListTableView;
@protocol maskListTableViewDelegate <NSObject>

- (void)maskListTableView:(maskListTableView *)maskListTableView changeTheDataListForTableView:(NSArray *)changeDataList;

@end


@interface maskListTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <maskListTableViewDelegate>tempDelegate;
@property (nonatomic, strong) NSArray *dataList; // 新闻列表数据
@end

//
//  maskListTableView.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "maskListTableView.h"
#import "NewsHeaderCell.h"
#import "NewsCell.h"
#import "ImageNewsViewController.h"
#import "WebNewsViewController.h"

@interface maskListTableView ()<NewsCellDelegate>

@property(nonatomic, strong) NSMutableArray *maskListMarr;

@end

@implementation maskListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc] init];
        //初始化子视图
        self.backgroundColor = [UIColor colorWithRed:245/250.0 green:245/250.0 blue:245/250.0 alpha:1];
        self.backgroundView=nil;
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifierNewsCellId = @"newsCellId";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNewsCellId];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierNewsCellId];
    }
    // 设置单元格的内容
    cell.fromWhere = @"maskListTableView";
    cell.currentIndexPath = indexPath;
    cell.delegate = self;
    cell.model = _dataList[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中样式
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 点击单元格事件
    // 获取当前点击的单元格内容
    NewsModel *newsModel = _dataList[indexPath.row];
    if (newsModel.type.intValue == 0) {
        // 点击的是普通新闻
        WebNewsViewController *webNewsVC = [[WebNewsViewController alloc] init];
        webNewsVC.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:webNewsVC animated:YES];
    } else if (newsModel.type.intValue == 1) {
        // 点击的是图片新闻
        ImageNewsViewController *imageNewsVC = [[ImageNewsViewController alloc] init];
        imageNewsVC.hidesBottomBarWhenPushed = YES;
        [self.viewControler.navigationController pushViewController:imageNewsVC animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *mArr = [_dataList mutableCopy];
    NewsModel *model = [mArr objectAtIndex:indexPath.row];
    [mArr removeObjectAtIndex:indexPath.row];
    _dataList = [mArr copy];
    // 4.刷新当前当前单元格
    [self reloadData];
    
    NSMutableArray *tempMarr = [NSMutableArray array];
    [tempMarr addObject:model];
    [self.maskListMarr addObjectsFromArray:tempMarr];
    if ([self.tempDelegate respondsToSelector:@selector(maskListTableView:changeTheDataListForTableView:)]) {
        [self.tempDelegate maskListTableView:self changeTheDataListForTableView:[self.maskListMarr copy]];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消屏蔽";
}

#pragma mark -- 自定义协议
- (void)newsCell:(NewsCell *)newsCell currentIndexPath:(NSIndexPath *)currentIndexPath{
    
    NSMutableArray *mArr = [_dataList mutableCopy];
    NewsModel *model = [mArr objectAtIndex:currentIndexPath.row];
    [mArr removeObjectAtIndex:currentIndexPath.row];
    _dataList = [mArr copy];
    // 4.刷新当前当前单元格
    [self reloadData];
    
    
    
    NSMutableArray *tempMarr = [NSMutableArray array];
    [tempMarr addObject:model];
    [self.maskListMarr addObjectsFromArray:tempMarr];
    if ([self.tempDelegate respondsToSelector:@selector(maskListTableView:changeTheDataListForTableView:)]) {
        [self.tempDelegate maskListTableView:self changeTheDataListForTableView:[self.maskListMarr copy]];
    }
    
}

#pragma mark -- 懒加载
- (NSMutableArray *)maskListMarr{
    
    if (!_maskListMarr) {
        _maskListMarr = [NSMutableArray array];
    }
    return _maskListMarr;
}
@end

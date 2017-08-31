//
//  NewsViewController.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsHeaderCell.h"
#import "NewsCell.h"
#import "ImageNewsViewController.h"
#import "WebNewsViewController.h"
#import "CarouseCell.h"

@interface NewsViewController ()<NewsCellDelegate,maskListTableViewDelegate>

@property (nonatomic, copy) NSArray *originNewsDataList;
@property (nonatomic, copy) NSArray *originBannerDataList;


@property(nonatomic, strong) NSMutableArray *bannerMarr;
@property(nonatomic, strong) NSMutableArray *maskListMarr;
@property (nonatomic, strong) NSNumber *pageTotal;
@property (nonatomic, strong) NSNumber *numberPage;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGBA(245, 245, 245, 1.0);
    
    // 2.创建子视图
    [self _initViews];
    
    // 3.创建右侧导航按钮
    [self _initRightBarButtonItem];
    
    // 4.请求数据
    [self _loadMovieDataList];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    _tableView.mj_footer.automaticallyHidden = YES;
    
}
-(void)headerRereshing
{
    self.numberPage = @1;
    [self _loadMovieDataList];
}

-(void)footerRereshing
{
    self.numberPage = [NSNumber numberWithDouble:[self.numberPage intValue] + 1];
    [self _loadMovieDataList];
}

// 4.请求数据
- (void)_loadMovieDataList
{
    // 3.获取数据
    [DataService getResultDataWithFileName:@"news_list" FinishBlock:^(id result, NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
        NSArray *newsTempList = result;
        
        NSDictionary *tempDic1 = result[0];
        NSDictionary *tempDic2 = result[1];
        NSDictionary *tempDic3 = result[2];
        NSArray *tempBannerList = @[tempDic1,tempDic2,tempDic3];
        self.originBannerDataList = tempBannerList;
        NSMutableArray *theMarr = [result mutableCopy];
        [theMarr removeObjectAtIndex:0];
        [theMarr removeObjectAtIndex:1];
        [theMarr removeObjectAtIndex:2];
        // 把数据转换成模型对象
        self.originNewsDataList = [theMarr copy];
        
        NSMutableArray *bannerTempModels = [NSMutableArray array];
        for (NSDictionary *dic in tempBannerList) {
            // 创建对应的数据原型对象
            NewsModel *model = [[NewsModel alloc] initWithContentDic:dic];
            // 把数据原型对象添加到数组中
            [bannerTempModels addObject:model];
        }
        self.bannerList = bannerTempModels;
        // 把数据转换成模型对象
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSInteger i = 3; i < newsTempList.count; i++) {
            NSDictionary *dic = newsTempList[i];
            // 创建对应的数据原型对象
            NewsModel *model = [[NewsModel alloc] initWithContentDic:dic];
            // 把数据原型对象添加到数组中
            [models addObject:model];
        }
        
        // 保存到全局属性中
        _dataList = models;
        // 刷新表视图
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }];
    
}

// 3.创建右侧导航按钮
- (void)_initRightBarButtonItem
{
    // 01 创建新闻列表按钮
    UIButton *posterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    posterButton.frame = CGRectMake(0, 0, 80, 25);
    posterButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [posterButton setTitle:@"新闻列表" forState:UIControlStateNormal];
    [posterButton setBackgroundColor:UIColorFromRGBA(199, 9, 9 , 1.0)];
    [posterButton addTarget:self action:@selector(posterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 02 创建屏蔽列表按钮
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.frame = CGRectMake(0, 0, 80, 25);
    listButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [listButton setBackgroundColor:UIColorFromRGBA(199, 9, 9 , 1.0)];
    [listButton setTitle:@"屏蔽列表" forState:UIControlStateNormal];
    [listButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.右侧按钮的视图
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 25)];
    // 把新闻列表视图添加到按钮视图上
    [rightView addSubview:posterButton];
    // 把屏蔽列表按钮视图添加到按钮视图上
    [rightView addSubview:listButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

// 2.创建子视图
- (void)_initViews
{
    // 1.屏蔽列表视图
    _maskListTableView = [[maskListTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _maskListTableView.tempDelegate = self;
    // 设置背景颜色
    _maskListTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_maskListTableView];
    
    // 2.创建新闻列表表视图
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_tableView];
    
}

#pragma mark - 导航按钮点击事件
- (void)posterButtonAction:(UIButton *)posterButton
{
    
    // 切换当前控制器根视图的新闻视图和屏蔽列表视图的上下位置
    [self myAnimationTransitionWithSuperView:self.view formLeft:NO];
    // 切换右侧导航按钮视图的新闻按钮和屏蔽列表按钮的上下位置
    [self myAnimationTransitionWithSuperView:posterButton.superview formLeft:NO];
}

- (void)listButtonAction:(UIButton *)listButton
{
    // 切换当前控制器根视图的新闻视图和屏蔽列表视图的上下位置
    [self myAnimationTransitionWithSuperView:self.view formLeft:YES];
    // 切换右侧导航按钮视图的新闻按钮和屏蔽列表按钮的上下位置
    [self myAnimationTransitionWithSuperView:listButton.superview formLeft:YES];
}

#pragma mark - 翻转动画的方法封装
- (void)myAnimationTransitionWithSuperView:(UIView *)superView formLeft:(BOOL)formLeft
{
    [UIView animateWithDuration:.35 animations:^{
        // 添加翻转动画配置
        [UIView setAnimationTransition:formLeft == YES ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight forView:superView cache:YES];
        // 切换右侧导航按钮视图的屏蔽列表按钮和新闻列表按钮的上下位置
        [superView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }];
}


// 视图已经显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 取消选中单元格效果
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return _dataList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifierHeaderCellId = @"identifierHeaderCellId";
        CarouseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHeaderCellId];
        if (cell == nil) {
            cell = [[CarouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierHeaderCellId];
        }
        cell.tempShowGap = @"show";
        // 设置单元格的内容
        cell.bannerList = self.bannerList;
        return cell;
    }else {
        static NSString *identifierNewsCellId = @"newsCellId";
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierNewsCellId];
        if (cell == nil) {
            cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierNewsCellId];
        }
        cell.fromWhere = @"NewsViewControllerTableView";
        cell.currentIndexPath = indexPath;
        cell.delegate = self;
        // 设置单元格的内容
        cell.model = _dataList[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中样式
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 点击单元格事件
    // 获取当前点击的单元格内容
    if (indexPath.section == 1) {
        
        NewsModel *newsModel = _dataList[indexPath.row];
        if (newsModel.type.intValue == 0) {
            // 点击的是普通新闻
            WebNewsViewController *webNewsVC = [[WebNewsViewController alloc] init];
            webNewsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webNewsVC animated:YES];
        } else if (newsModel.type.intValue == 1) {
            // 点击的是图片新闻
            ImageNewsViewController *imageNewsVC = [[ImageNewsViewController alloc] init];
            imageNewsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:imageNewsVC animated:YES];
        }
    }
}


#pragma mark -- 自定义协议
- (void)newsCell:(NewsCell *)newsCell currentIndexPath:(NSIndexPath *)currentIndexPath clickExplainBtnShowStatus:(BOOL)showStatus{
    /*
     NSMutableArray *currentMarr = [self.originNewsDataList mutableCopy];
     [currentMarr removeObjectAtIndex:currentIndexPath.row];
     [currentMarr insertObject:self.originBannerDataList[0] atIndex:0];
     [currentMarr insertObject:self.originBannerDataList[1] atIndex:1];
     [currentMarr insertObject:self.originBannerDataList[2] atIndex:2];
     NSData *jsonData = [self toJSONData:currentMarr];
     BOOL flag = [jsonData writeToFile:[self getFilePath:@"news_list"] atomically:YES];
     if (flag) {
     NSLog(@"数据持久化成功");
     }else{
     NSLog(@"数据持久化失败");
     }
     [self _loadMovieDataList];
     */
    
    NSMutableArray *mArr = [_dataList mutableCopy];
    NewsModel *model = [mArr objectAtIndex:currentIndexPath.row];
    [mArr removeObjectAtIndex:currentIndexPath.row];
    _dataList = [mArr copy];
    // 刷新当前当前单元格
    [_tableView reloadData];
    
    
    
    NSMutableArray *tempMarr = [NSMutableArray array];
    [tempMarr addObject:model];
    [self.maskListMarr addObjectsFromArray:tempMarr];
    _maskListTableView.dataList = [self.maskListMarr copy];
    [_maskListTableView reloadData];
    
}

- (void)newsCell:(NewsCell *)newsCell currentIndexPath:(NSIndexPath *)currentIndexPath{
    
}
- (void)maskListTableView:(maskListTableView *)maskListTableView changeTheDataListForTableView:(NSArray *)changeDataList{
    
    NSMutableArray *tempMarr = [NSMutableArray array];
    tempMarr = [_dataList mutableCopy];
    [tempMarr addObjectsFromArray:changeDataList];
    _dataList = [tempMarr copy];
    // 4.刷新当前当前单元格
    [_tableView reloadData];
    
}
#pragma mark -- 懒加载
- (NSMutableArray *)maskListMarr{
    
    if (!_maskListMarr) {
        _maskListMarr = [NSMutableArray array];
    }
    return _maskListMarr;
}
#pragma mark -- 懒加载
- (NSMutableArray *)bannerMarr{
    
    if (!_bannerMarr) {
        _bannerMarr = [NSMutableArray array];
    }
    return _bannerMarr;
}

#pragma mark -- method
- (NSData *)toJSONData:(id)theData

{
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                        
                                                       options:NSJSONWritingPrettyPrinted
                        
                                                         error:&error];
    
    if ([jsonData length] != 0 && error == nil)
        
    {
        
        return jsonData;
        
    }
    
    else
        
    {
        
        return nil;
        
    }
    
}
- (NSString *)getFilePath:(NSString *)plistNameStr{
    
    /*保存数据一*/
    /*新建一个plist*/
    //获取应用程序沙盒的Documents目录
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString *newplistPath = [paths objectAtIndex:0];
    //    //得到完整的文件名
    //    NSString *filename= [newplistPath stringByAppendingPathComponent:plistNameStr];
    
    // 获取文件本地的路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistNameStr ofType:@"json"];
    
    return filePath;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

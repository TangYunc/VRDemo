//
//  ImageNewsViewController.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "ImageNewsViewController.h"
#import "ImageModel.h"
#import "ImageNewsCell.h"
#import "AlbumViewController.h"

@interface ImageNewsViewController ()

@end

@implementation ImageNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.// 1.设置标题
    self.title = @"图片新闻";
    // 显示自定义返回按钮
    self.isBackButton = YES;
    
    // 2.初始化子视图
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置单元格的大小和间距
    float itemWidth = (kScreenWidth - 50) / 4.0;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    // 设置单元格之间的间距
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    // 设置组的内填充
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 创建视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 设置背景颜色
    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    // 注册单元格类
    [_collectionView registerClass:[ImageNewsCell class] forCellWithReuseIdentifier:@"imageNewsCellId"];
    [self.view addSubview:_collectionView];
    
    // 3.加载数据 image_list.json
    [self loadData];
}

// 3.加载数据
- (void)loadData
{
    [DataService getResultDataWithFileName:@"image_list" FinishBlock:^(id result, NSError *error) {
        // 把数据转换成数据原型对象
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in result) {
            // 创建数据原型对象
            ImageModel *model = [[ImageModel alloc] initWithContentDic:dic];
            // 把数据原型对象添加到数组中
            [models addObject:model];
        }
        
        // 把数据保存到全局变量中
        _dataList = models;
        // 刷新视图
        [_collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取单元格
    ImageNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageNewsCellId" forIndexPath:indexPath];
    // 设置内容
    cell.model = _dataList[indexPath.row];
    // 让单元格自动调用layoutSubViews
    [cell setNeedsLayout];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建相册控制器
    AlbumViewController *albumVC = [[AlbumViewController alloc] init];
    // 传递内容
    albumVC.dataList = self.dataList;
    albumVC.selectedIndex = (int)indexPath.row;
    // 创建导航控制器
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:albumVC];
    navCtrl.navigationBar.barStyle = UIBarStyleBlack;
    // 通过莫泰视图弹出导航控制器
    [self presentViewController:navCtrl animated:YES completion:nil];
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

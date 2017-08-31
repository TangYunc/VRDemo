//
//  AlbumViewController.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "ImageModel.h"


@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.// 1.设置标题
    self.title = @"图片详情";
    
    // 2.设置返回按钮
    self.isBackButton = YES;
    
    // 3.创建子视图
    // 01 创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置单元格的大小
    flowLayout.itemSize = CGSizeMake(kScreenWidth + 10, kScreenHeight);
    // 设置间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    // 设置方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 02 创建视图
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-5, 0, kScreenWidth + 10, kScreenHeight) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    // 设置翻页效果
    _collectionView.pagingEnabled = YES;
    // 注册单元格类
    
    [_collectionView registerClass:[AlbumCell class] forCellWithReuseIdentifier:@"albumCellId"];
    [self.view addSubview:_collectionView];
    
    // 4.给滑动视图添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_collectionView addGestureRecognizer:tap];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 设置视图的偏移位置
    [_collectionView setContentOffset:CGPointMake(_selectedIndex * (kScreenWidth + 10), 0)];
}

#pragma mark - 重写返回按钮事件
- (void)backAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"albumCellId" forIndexPath:indexPath];
    // 设置内容
    ImageModel *model = _dataList[indexPath.row];
    cell.imageName = model.image;
    // 让系统调用layoutSubView方法
    [cell setNeedsLayout];
    return cell;
}

#pragma mark - UITouch
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 设置导航栏状态效果取反
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    // 设置状态取反效果
    [[UIApplication sharedApplication] setStatusBarHidden:![UIApplication sharedApplication].statusBarHidden withAnimation:UIStatusBarAnimationSlide];
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

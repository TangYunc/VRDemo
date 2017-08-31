//
//  WebNewsViewController.m
//  VRDemo
//
//  Created by 唐云川 on 2017/8/30.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import "WebNewsViewController.h"
#import "AlbumViewController.h"
#import "ImageModel.h"

@interface WebNewsViewController ()

@end

@implementation WebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.设置标题
    self.title = @"普通新闻";
    
    // 2.设置返回按钮
    self.isBackButton = YES;
    
    // 3.创建视图
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    // 设置代理对象
    _webView.delegate = self;
    // 创建网址路径
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    //    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    //    [_webView loadRequest:urlRequest];
    [self.view addSubview:_webView];
    
    // 4.加载数据
    [self loadData];
}
// 4.加载数据
- (void)loadData
{
    // 获取新闻内容数据
    [DataService getResultDataWithFileName:@"news_detail" FinishBlock:^(id result, NSError *error) {
        // 01 获取新闻标题
        NSString *title = result[@"title"];
        // 02 获取时间
        NSString *time = result[@"time"];
        // 03 获取来源
        NSString *source = result[@"source"];
        // 04 获取内容
        NSString *content = result[@"content"];
        // 05 获取作者
        NSString *author = result[@"author"];
        
        // 06 加载html样式模板
        NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
        NSString *htmlModelString = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
        // 07 拼接完整HTML内容
        NSString *htmlString = [NSString stringWithFormat:htmlModelString,title,time,source,content,author];
        // 08 给webView去显示加载
        // 设置baseURL：就是网页的根路径，所有在html导入的文件都会在这个路径下区查找
        NSURL *baseUrl = [[NSBundle mainBundle] resourceURL];
        [_webView loadHTMLString:htmlString baseURL:baseUrl];
        
        
    }];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 01 获取当前加载的url地址
    NSString *urlString = [request.URL absoluteString];
    // 02 如果我点击的是图片-弹出相册控制器，展示图片
    if ([urlString hasPrefix:@"click:"]) {
        // 处理我们获取的数据
        NSLog(@"%@",urlString);
        // (1)把字符串按照；分割成数组
        NSArray *imageUrls = [urlString componentsSeparatedByString:@";"];
        // (2)拿到我们点击url的内容
        NSString *clickImageUrl = [imageUrls firstObject];
        clickImageUrl = [clickImageUrl substringFromIndex:6];
        // (3)获取所有图片的数组
        NSArray *dataList = [imageUrls subarrayWithRange:NSMakeRange(1, imageUrls.count - 1)];
        // 创建一个可变数组
        NSMutableArray *models = [NSMutableArray array];
        for (NSString *imageUrl in dataList) {
            // 创建图片模型对象
            ImageModel *model = [[ImageModel alloc] init];
            model.image = imageUrl;
            // 把模型对象添加到数组中
            [models addObject:model];
        }
        // 把数据里面的元素变成模型对象
        // (4)获取点击图片在数组中的索引位置
        int selectedIndex = [dataList indexOfObject:clickImageUrl];
        // 创建相册控制器
        AlbumViewController *albumVC = [[AlbumViewController alloc] init];
        // 设置内容
        albumVC.selectedIndex = selectedIndex;
        albumVC.dataList = models;
        // 创建导航控制器
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:albumVC];
        // 设置导航栏样式
        navCtrl.navigationBar.barStyle = UIBarStyleBlack;
        // 通过模态视图弹出控制器
        [self presentViewController:navCtrl animated:YES completion:nil];
        return NO;
    }
    return YES;
}

// 加载开始
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示状态栏的加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏状态栏的加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏状态栏的加载提示
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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

//
//  DataService.h
//  WuMingNews
//
//  Created by 唐云川 on 2017/6/3.
//  Copyright © 2017年 com.guwu. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);
typedef void (^dictonaryBlock)(NSDictionary *responseObject);
// 定义一个block类型
typedef void(^FinishBlock) (id result ,NSError *error);


@interface DataService : NSObject

//加密
+(NSString *)md5:(NSString *)str;

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;
+ (void)postWithUrl:(NSString *)url paramaters:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(successBlock)success failure:(failureBlock)failure;

+(void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;
+(void)getWechatWithURL:(NSString *)url params:(NSDictionary *)params success:(successBlock)success failure:(failureBlock)failure;


/*
 通过你个文件名字进行数据的读取和解析
 */
+ (id)getResultDataWithFileName:(NSString *)fileName;

/*
 如果请求网络上面的方法封装就不是很完善，因为上面的方法在网络请求中，数据有相当大的延迟时间，程序不会一直等待数据请求完成在往下执行，如果一直等待这一条数据请求，那么这个程序就出现卡的状态
 */
+ (void)getResultDataWithFileName:(NSString *)fileName
                      FinishBlock:(FinishBlock)finishBlock;

@end

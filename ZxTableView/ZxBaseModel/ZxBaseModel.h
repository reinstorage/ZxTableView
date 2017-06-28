//
//  ZxBaseModel.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZxBaseItem.h"
#import "ZxBaseServerAPI.h"


@class ZxBaseModel;

/**
 用于ZxBaseModel回调的block定义
 */
typedef void(^ZxModelBlock) (ZxBaseModel *);

@interface ZxBaseModel : NSObject

//自动解析数据类型，可能不在同线程访问，因此设置成 atmoic
@property(assign,atomic)Class parseDataClassType;

//回调函数
@property(nonatomic,copy)ZxModelBlock completionBlock;

//网络请求
@property(nonatomic,retain)ZxBaseServerAPI *serverApi;

//网络请求参数
@property(nonatomic,retain)NSDictionary *params;

//请求地址 需要在子类init中初始化
@property(nonatomic,copy)NSString *address;

- (instancetype)initWithAddress:(NSString *)address;
- (void)handleParsedData:(ZxBaseItem *)parsedData;

- (void)loadWithShortConnection;
- (void)loadWithLongConnection;
- (void)refresh;
- (void)cancel;

@end

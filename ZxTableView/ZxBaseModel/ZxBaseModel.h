//
//  ZxBaseModel.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZxBaseItem.h"
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

-(void)handleParsedData:(ZxBaseModel *)parseData;

@end

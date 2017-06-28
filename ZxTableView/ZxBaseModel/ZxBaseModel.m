//
//  ZxBaseModel.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseModel.h"

@implementation ZxBaseModel

- (instancetype)initWithAddress:(NSString *)address{
    if (self = [super init]) {
        _address = address;
        _serverApi = [[ZxBaseServerAPI alloc]initWithServer:@"http://1.footballapp.sinaapp.com"];//这个URL应该是配置文件中的常量
    }
    return self;
}

-(BOOL)isLoading{//如果将来支持长连接,这里的逻辑会变复杂
    return self.serverApi.state == ZX_PROC_STAT_CREATED || self.serverApi.state == ZX_PROC_STAT_LOADING;
}

// 子类重载处理数据的逻辑
- (void)handleParsedData:(ZxBaseItem *)parsedData {
    
}

#pragma -mark 短链接
- (void)loadWithShortConnection{
    assert(self.address != nil && self.params != nil);
    if ([self isLoading]) {
        return;
    }
    
    [self loadInnerWithShortConnection];
}

-(void)loadInnerWithShortConnection{
    __block ZxBaseModel *wself = self;
    NSString *reauestAddress = self.address;
    
    [self.serverApi accessAPI:reauestAddress WithParams:self.params completionBlock:^(ZxBaseServerAPI *api) {
        ZxBaseModel *sself = wself;
        [sself handleShortConnectionBlock:api];
    }];
}

- (void)handleShortConnectionBlock:(ZxBaseServerAPI *)api{
    
    if (api.state == ZX_PROC_STAT_SUCCEED && !api.error) {
        [self parseData:api.jsonData];//解析数据
    }
    else if (api.state == ZX_PROC_STAT_FAILED && api.error && api.state != ZX_PROC_STAT_CANCELLED){
        //做一些错误弹窗处理
        if (self.completionBlock) {
            self.completionBlock(self);
        }
    }
    else{//取消或其他
        //做一些弹窗处理
        if (self.completionBlock) {
            self.completionBlock(self);
        }
    }
    
}

#pragma -mark 长链接
- (void)loadWithLongConnection {
    assert(self.address != nil && self.params != nil);
    if ([self isLoading]) {
        return;
    }
    [self loadInnerWithShortConnection];
}

- (void)loadInnerWithLongConnection {
    return;
}

# pragma -mark 刷新与取消
- (void)cancel {
    [self.serverApi cancel];
}

- (void)refresh {
    [self.serverApi refresh];
}

#pragma -mark 字典转对象
- (void)parseData:(NSDictionary *)data{
    __block NSDictionary *dataCopy = [[NSDictionary alloc] initWithDictionary:data];
    __block ZxBaseModel *wself = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //异步解析数据
        ZxBaseModel *sself = wself;
        __block ZxBaseItem *item = [[sself.parseDataClassType alloc] initWithData:dataCopy];
        
        //同步通知到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [sself handleParsedData:item];
            if (sself.completionBlock) {
                [sself dataParseSuccessCompletionBlock];
            }
        });
        
    });
}
//数据解析完成的回调
-(void)dataParseSuccessCompletionBlock{
    self.completionBlock(self);
}












@end

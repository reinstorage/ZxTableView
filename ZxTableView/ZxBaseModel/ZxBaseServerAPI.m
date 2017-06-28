//
//  ZxBaseServerAPI.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseServerAPI.h"

@interface ZxBaseServerAPI()

@property (nonatomic, retain) NSString *server;
@property (nonatomic, retain) NSDictionary *reqParams;
@property (nonatomic, retain) NSDictionary *files;
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, assign) CFTimeInterval netCost;
@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation ZxBaseServerAPI

@synthesize rawString = _rawString;

- (id)initWithServer:(NSString *)server{
    if (self = [super init]) {
        if (![server hasPrefix:@"http://"]) {
            server = [@"http://" stringByAppendingString:server];
        }
        
        if([server hasSuffix:@"/"]){
            server = [server substringToIndex:server.length-1];
        }
        
        self.server = server;
    }
    return self;
}

#pragma -mark accessAPI

- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
            files:(NSDictionary *)files
    requestMethod:(ZxHttpRequestMethod)method
  completionBlock:(ZxServerAPICompletionBlock)block{
    
    if (!self.manager) {
        //应该获取一个全局唯一的mananger
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    if (self.state == ZX_PROC_STAT_LOADING) {
        [self cancel];
    }
    
    self.netCost = 0;//网络请求统计
    
    //赋值
    if(![api hasPrefix:@"/"]){
        self.api = [@"/" stringByAppendingString:api];
    }
    else{
        self.api = api;
    }
    self.reqParams = params;
    self.files = files;
    self.userBlock = block;
    
    //重置状态
    self.state = ZX_PROC_STAT_CREATED;
    self.error = nil;
    self.jsonData = nil;
    self.rawData = nil;
    self.rawString = nil;
    
    //统计时间
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    //允许子类调用自己的参数,附加请求参数
    
    //发起请求
    NSString *url = [self.server stringByAppendingString:self.api];
    if (method == ZX_REQUEST_POST) {
        self.task = [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.netCost = CFAbsoluteTimeGetCurrent() - self.startTime;//统计网络请求时间
            self.rawData = (NSData *)responseObject;
            self.jsonData = [NSJSONSerialization JSONObjectWithData:self.rawData options:NSJSONReadingMutableContainers error:nil];
            self.state = ZX_PROC_STAT_SUCCEED;
            
            if (self.userBlock) {
                [self accessSuccessBlock];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    else{
        //GET
    }
}

//请求成功的回调
-(void)accessSuccessBlock{
    self.userBlock(self);
}

- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
            files:(NSDictionary *)files
  completionBlock:(ZxServerAPICompletionBlock)block{
    [self accessAPI:api
         WithParams:params
              files:files
      requestMethod:ZX_REQUEST_POST
    completionBlock:block];
}

- (void)accessAPI:(NSString *)api
       WithParams:(NSDictionary *)params
  completionBlock:(ZxServerAPICompletionBlock)block{
    [self accessAPI:api WithParams:params files:nil completionBlock:block];
}


#pragma -mark 刷新与取消
// 刷新请求
- (void)refresh{
    [self accessAPI:self.api
         WithParams:self.reqParams
              files:self.files
    completionBlock:self.userBlock];
}

//中止请求
- (void)cancel{
    if (self.state == ZX_PROC_STAT_LOADING) {
        self.state = ZX_PROC_STAT_CANCELLED;
        [self.task cancel];
    }
    else{
        //提醒
        return;
    }
}

// lazyloading
-(NSString *)rawString{
    if (_rawString) {
        return _rawString;
    }
    
    if (self.rawData) {
        _rawString = [[[NSString alloc] initWithData:self.rawData encoding:NSUTF8StringEncoding] copy];
    }
    return  self->_rawString;
}

-(void)setRawString:(NSString *)rawString{
    if (self->_rawString == rawString) {
        return;
    }
    
    self->_rawString = [rawString copy];
}


@end

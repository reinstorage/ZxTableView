//
//  ZxBaseItem.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZxBaseItem : NSObject

- (id)initWithData:(NSDictionary *)data;

// property中如有包含TBCBaseListItem对象的数组，需要设定此规则
- (void)addMappingRuleArrayProperty:(NSString*)propertyName class:(Class)cls;
// 所有需要映射的property都需要设定此规则
- (void)addMappingRuleProperty:(NSString*)propertyName pathInJson:(NSString*)path;

- (id)setData:(id)data;

@end

@interface ZxClassHelper : NSObject

+ (ZxClassHelper *)sharedInstance;

@property (nonatomic, retain) NSMutableDictionary *propertyListCache;

- (NSDictionary *)propertyList:(Class)cls;

@end

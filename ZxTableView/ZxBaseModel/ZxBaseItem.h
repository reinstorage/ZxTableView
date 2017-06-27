//
//  ZxBaseItem.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZxBaseItem : NSObject

-(id)initWithData:(NSDictionary *)data;

//property中包含TBCBaseListItem对象数组中，需要设定此规则
-(void)addMappingRuleArrayProperty:(NSString *)propertyName class:(Class)cls;

-(id)setData:(id)data;

@end

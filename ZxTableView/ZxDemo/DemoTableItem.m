//
//  DemoTableItem.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "DemoTableItem.h"

@implementation DemoTableItem

- (id)init {
    self = [super init];
    if (self) {
        [self addMappingRuleProperty:@"books" pathInJson:@"data"];
        [self addMappingRuleArrayProperty:@"books" class:[DemoTableBookItem class]];
    }
    return self;
}


@end

@implementation DemoTableBookItem

- (id)init {
    self = [super init];
    if (self) {
        [self addMappingRuleProperty:@"bookTitle" pathInJson:@"title"];
        [self addMappingRuleProperty:@"url" pathInJson:@"url"];
        [self addMappingRuleProperty:@"imageUrl" pathInJson:@"imageUrl"];
    }
    return self;
}

@end

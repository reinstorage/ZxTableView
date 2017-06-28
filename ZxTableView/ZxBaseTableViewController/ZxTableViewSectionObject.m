//
//  ZxTableViewSectionObject.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxTableViewSectionObject.h"

@implementation ZxTableViewSectionObject

-(instancetype)init{
    self = [super init];
    if (self) {
        self.headerTitle = @"";
        self.footerTitle = @"";
        self.items = [[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)initWithItemArray:(NSMutableArray *)items{
    self = [self init];
    if (self) {
        [self.items addObjectsFromArray:items];
    }
    return self;
}

@end

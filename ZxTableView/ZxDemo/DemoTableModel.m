//
//  DemoTableModel.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "DemoTableModel.h"
#import "DemoTableItem.h"

@implementation DemoTableModel

-(void)handleParsedData:(ZxBaseItem *)parsedData{
    [super handleParsedData:parsedData];
    if ([parsedData isKindOfClass:[DemoTableItem class]]) {
        self.tableViewItem = (DemoTableItem *)parsedData;
    }
}

-(void)loadWithShortConnection{
    if (!self.parseDataClassType) {
        self.parseDataClassType = [DemoTableItem class];
    }
    [super loadWithShortConnection];
}

@end

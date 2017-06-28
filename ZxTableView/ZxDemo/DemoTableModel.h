//
//  DemoTableModel.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseListModel.h"
#import "DemoTableItem.h"

@class DemoTableItem;
@interface DemoTableModel : ZxBaseListModel

@property(nonatomic,strong) DemoTableItem *tableViewItem;

@end

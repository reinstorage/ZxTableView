//
//  ZxTableViewSectionObject.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZxTableViewSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle; // UITableDataSource 协议中的 titleForHeaderInSection 方法可能会用到
@property (nonatomic, copy) NSString *footerTitle; // UITableDataSource 协议中的 titleForFooterInSection 方法可能会用到

@property (nonatomic, retain) NSMutableArray *items;

- (instancetype)initWithItemArray:(NSMutableArray *)items;

@end

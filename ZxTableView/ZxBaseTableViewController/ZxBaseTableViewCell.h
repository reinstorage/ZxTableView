//
//  ZxBaseTableViewCell.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZxTableViewBaseItem;

@interface ZxBaseTableViewCell : UITableViewCell

@property(nonatomic,retain)id object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(ZxTableViewBaseItem *)object;

@end

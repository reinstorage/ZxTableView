//
//  ZxTableViewDataSource.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZxTableViewBaseItem;

@protocol ZxTableViewDataSource <UITableViewDataSource>

@optional

- (ZxTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)tableView:(UITableView*)tableView cellClassForObject:(ZxTableViewBaseItem *)object;

@end

@interface ZxTableViewDataSource : NSObject<ZxTableViewDataSource>

@property(nonatomic,strong) NSMutableArray *sections;//二维数组每个元素都是一个SectionObject

-(void)clearAllItems;
- (void)appendItem:(ZxTableViewBaseItem *)item;

@end

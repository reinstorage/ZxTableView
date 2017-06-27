//
//  ZxTableViewDataSource.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxTableViewDataSource.h"
#import "ZxTableViewBaseItem.h"
#import "ZxBaseTableViewCell.h"
#import "ZxTableViewSectionObject.h"

#import <objc/runtime.h>

@implementation ZxTableViewDataSource

#pragma mark - ZXTableViewDataSource
- (ZxTableViewBaseItem *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sections.count > indexPath.section) {
        ZxTableViewSectionObject *sectionObject = [self.sections objectAtIndex:indexPath.section];
        if ([sectionObject.items count] > indexPath.row) {
            return [sectionObject.items objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

//这个方法 子类有机会重写,默认的cell类型是ZxBaseTableViewCell
- (Class)tableView:(UITableView*)tableView cellClassForObject:(ZxTableViewBaseItem *)object {
    return [ZxBaseTableViewCell class];
}

-(void)clearAllItems{
    self.sections = [NSMutableArray arrayWithObject:[[ZxTableViewSectionObject alloc]init]];
}

- (void)appendItem:(ZxTableViewBaseItem *)item{
    ZxTableViewSectionObject *firstSectionObject = [self.sections firstObject];
    [firstSectionObject.items addObject:item];
}

#pragma mark - UITableViewDataSource Required
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sections.count>section) {
        ZxTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZxTableViewBaseItem *object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    ZxBaseTableViewCell *cell = (ZxBaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:className];
    
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    [cell setObject:object];
    
    return cell;
}

#pragma mark - UITableViewDataSource Optional
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections ? self.sections.count : 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.sections.count > section) {
        ZxTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.headerTitle;
    }
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    if (self.sections.count > section) {
        ZxTableViewSectionObject *sectionObject = [self.sections objectAtIndex:section];
        
        BOOL isHaveFooter = sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""];
        
        if (isHaveFooter) {
            return sectionObject.footerTitle;
        }
    }
    
    return nil;
}















@end

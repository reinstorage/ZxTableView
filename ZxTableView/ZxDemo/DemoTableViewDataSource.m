//
//  DemoTableViewDataSource.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "DemoTableViewDataSource.h"

#import "DemoTableViewCell.h"

#import "ZxTableViewSectionObject.h" // 这个实际使用时应该是对应的子类
#import "ZxTableViewBaseItem.h" // 这个实际使用时应该是对应的子类

@implementation DemoTableViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        ZxTableViewSectionObject *firstSectionObject = [[ZxTableViewSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第一条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第二条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第三条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第四条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第五条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第六条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第七条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第八条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第九条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第十条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第十一条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第十二条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第十三条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            [[ZxTableViewBaseItem alloc] initWithImage:nil Title:@"第十四条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                            nil]];
        self.sections = [NSMutableArray arrayWithObject: firstSectionObject];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(ZxTableViewBaseItem *)object {
    return [DemoTableViewCell class];
}

@end

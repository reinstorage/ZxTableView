//
//  ZxTableViewBaseItem.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxTableViewBaseItem.h"

@implementation ZxTableViewBaseItem

-(instancetype)init{
    self = [self initWithImage:nil Title:nil SubTitle:nil AccessoryImage:nil];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage{
    self = [super init];
    if (self) {
        _cellHeight = CellInvalidHeight;
        _itemImage = image;
        _itemTitle = title;
        _itemSubtitle = subTitle;
        _itemAccessoryImage = accessoryImage;
    }
    return self;
}

@end

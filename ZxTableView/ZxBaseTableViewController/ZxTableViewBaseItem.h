//
//  ZxTableViewBaseItem.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT CGFloat const CellInvalidHeight;

@interface ZxTableViewBaseItem : NSObject

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, retain) NSString *itemIdentifier;
@property (nonatomic, retain) UIImage *itemImage;
@property (nonatomic, retain) NSString *itemTitle;
@property (nonatomic, retain) NSString *itemSubtitle;
@property (nonatomic, retain) UIImage *itemAccessoryImage;

- (instancetype)initWithImage:(UIImage *)image Title:(NSString *)title SubTitle:(NSString *)subTitle AccessoryImage:(UIImage *)accessoryImage;



@end

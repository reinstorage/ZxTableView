//
//  ZxBaseTableViewCell.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseTableViewCell.h"
#import "ZxTableViewBaseItem.h"
#import "UIView+ZxExtension.h"

@implementation ZxBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//子类在这个方法中解析数据
-(void)setObject:(ZxTableViewBaseItem *)object{
    
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubtitle;
    self.accessoryView = [[UIImageView alloc]initWithImage:object.itemAccessoryImage];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(ZxTableViewBaseItem *)object{
    return 44.0f;
}

@end

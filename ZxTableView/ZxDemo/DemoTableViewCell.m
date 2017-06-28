//
//  DemoTableViewCell.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


+(CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(ZxTableViewBaseItem *)object{
    return 50.f;
}
@end

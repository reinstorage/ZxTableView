//
//  ZxBaseListItem.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseListItem.h"

@implementation ZxBaseListItem
- (id)initWithData:(NSDictionary *)data {
    if (self = [super initWithData:data]) {
        self.pageNumber = [[NSString stringWithFormat:@"%@", [data objectForKey:@"page_number"]] intValue];
    }
    return self;
}
@end

//
//  DemoTableItem.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseListItem.h"


@interface DemoTableItem : ZxBaseListItem

@property (strong, nonatomic) NSMutableArray *books; // 存放了每个 cell 的标题


@end

@interface DemoTableBookItem : ZxBaseItem

@property (copy, nonatomic) NSString *bookTitle;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *imageUrl;

@end

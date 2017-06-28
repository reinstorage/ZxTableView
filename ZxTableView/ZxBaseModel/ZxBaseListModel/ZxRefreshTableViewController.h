//
//  ZxRefreshTableViewController.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxTableViewController.h"
#import "ZxBaseListModel.h"

@interface ZxRefreshTableViewController : ZxTableViewController<ZxBaseListModelProtocol>

@property (nonatomic, strong) ZxBaseListModel *listModel;

- (void)requestDidSuccess; // 子类请求完成后的处理方法。

@end

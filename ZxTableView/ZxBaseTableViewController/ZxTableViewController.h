//
//  ZxTableViewController.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZxBaseTableView.h"

@class ZxTableViewDataSource;

@protocol ZxTableViewControllerDelegate <NSObject>

@required
-(void)createDataSource;

@end

@interface ZxTableViewController : UIViewController<ZxTableViewDelegate,ZxTableViewControllerDelegate>

@property (nonatomic, strong)ZxTableViewDataSource *dataSource;
@property (nonatomic, strong)ZxBaseTableView *tableView;
@property (nonatomic, assign)UITableViewStyle tableViewStyle;//用来创建tableView

-(instancetype)initWithStyle:(UITableViewStyle)style;

@end

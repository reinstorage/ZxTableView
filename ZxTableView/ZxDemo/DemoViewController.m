//
//  ViewController.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoTableViewCell.h"
#import "DemoTableViewDataSource.h"

#import "AFNetworking.h"
#import "ZxTableViewBaseItem.h"
#import "DemoTableModel.h"

#import "MJRefresh.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createModel];
    
}

-(void)createModel{
    self.listModel = [[DemoTableModel alloc]initWithAddress:@"/mooclist.php"];
    self.listModel.delegate = self;
}

-(void)createDataSource{
    self.dataSource = [[DemoTableViewDataSource alloc] init]; // 这一步创建数据源
}

-(void)requestDidSuccess{
    for (DemoTableBookItem *book in ((DemoTableModel *)self.listModel).tableViewItem.books) {
        ZxTableViewBaseItem *item = [[ZxTableViewBaseItem alloc] init];
        item.itemTitle = book.bookTitle;
        [self.dataSource appendItem:item];
    }
}

@end

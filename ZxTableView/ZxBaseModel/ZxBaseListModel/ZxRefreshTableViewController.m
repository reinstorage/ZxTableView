//
//  ZxRefreshTableViewController.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxRefreshTableViewController.h"
#import "MJRefresh.h"

@interface ZxRefreshTableViewController ()

@end

@implementation ZxRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.isNeedPullUpToRefreshAction = YES;
    self.tableView.isNeedPullDownToRefreshAction = YES;

}

- (void)requestDidSuccess{
    
}

#pragma -mark ZxBaseListModelProtocol

-(void)loadRequestDidSuccess{
    [self requestDidSuccess];
}

-(void)refreshRequestDidSuccess{
    [self.dataSource clearAllItems];
    [self requestDidSuccess];
}

-(void)handleAfterRequestFinish{
    [self.tableView stopRefreshingAnimation];
}

-(void)didLoadLastPage{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

#pragma -mark ZxTableViewDelegate

-(void)pullUpToRefreshAction{
    [self.listModel loadNextPage];
}

- (void)pullDownToRefreshAction {
    [self.listModel refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ZxTableViewController.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxTableViewController.h"
#import "ZxTableViewDataSource.h"


@interface ZxTableViewController ()

@end


@implementation ZxTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if(self = [super init]){
        [self createDataSource];
    }
    return self;
}

//这个方法 实际上要被子类重写 生成对应的 data source
-(void)createDataSource{
    @throw [NSException exceptionWithName:@"Cann't use this method"
                                   reason:@"You can only call this method in subclass"
                                 userInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

-(void)createTableView{
    if (!self.tableView) {
        self.tableView = [[ZxBaseTableView alloc]initWithFrame:self.view.bounds style:self.tableViewStyle];
        self.tableView.ZxDelegate = self;
        self.tableView.ZxDataSource = self.dataSource;
        [self.view addSubview:self.tableView];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

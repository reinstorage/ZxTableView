//
//  ZxBaseTableView.m
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseTableView.h"
#import "ZxBaseTableViewCell.h"
#import "ZxTableViewBaseItem.h"
#import "ZxTableViewSectionObject.h"
#import "MJRefresh.h"

@implementation ZxBaseTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self =[super initWithFrame:frame style:style]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
        self.isNeedPullUpToRefreshAction = NO;
        self.isNeedPullDownToRefreshAction = NO;
    }
    return self;
}
-(void)setZxDataSource:(id<ZxTableViewDataSource>)ZxDataSource{
    if (_ZxDataSource != ZxDataSource) {
        _ZxDataSource = ZxDataSource;
        self.dataSource = ZxDataSource;
    }
}

#pragma mark 上拉加载和下拉刷新

-(void)setIsNeedPullDownToRefreshAction:(BOOL)isNeedPullDownToRefreshAction{
    if (_isNeedPullDownToRefreshAction == isNeedPullDownToRefreshAction) {
        return;
    }
    
    _isNeedPullDownToRefreshAction = isNeedPullDownToRefreshAction;
    
    __block typeof (self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            if ([weakSelf.ZxDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [weakSelf.ZxDelegate pullDownToRefreshAction];
            }
        }];
    }
}


-(void)setIsNeedPullUpToRefreshAction:(BOOL)isNeedPullUpToRefreshAction{
    if (_isNeedPullUpToRefreshAction == isNeedPullUpToRefreshAction) {
        return;
    }
    
    _isNeedPullUpToRefreshAction = isNeedPullUpToRefreshAction;
    __block typeof (self) weakSelf = self;
    
    if (_isNeedPullUpToRefreshAction) {
        self.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            if ([weakSelf.ZxDelegate respondsToSelector:@selector(pullUpToRefreshAction)]) {
                [weakSelf.ZxDelegate pullUpToRefreshAction];
            }
        }];
    }
}

- (void)stopRefreshingAnimation {
    
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)triggerRefreshing{
    [self.mj_header beginRefreshing];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<ZxTableViewDataSource> dataSource = (id<ZxTableViewDataSource>)tableView.dataSource;
    
    ZxTableViewBaseItem *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    
    //
    if (object.cellHeight == CellInvalidHeight) {//没有高度缓存
        object.cellHeight = [cls tableView:tableView rowHeightForObject:object];
    }
    
    return object.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma warning 写到在这里了
}























@end

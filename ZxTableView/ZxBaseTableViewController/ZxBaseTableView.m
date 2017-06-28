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
-(void)setZxDataSource:(id<ZxTableViewDataSource>)zxDataSource{
    if (_ZxDataSource != zxDataSource) {
        _ZxDataSource = zxDataSource;
        self.dataSource = zxDataSource;
    }
}

#pragma mark 上拉加载和下拉刷新

-(void)setIsNeedPullDownToRefreshAction:(BOOL)isEnable{
    if (_isNeedPullDownToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullDownToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullDownToRefreshAction) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([weakSelf.ZxDelegate respondsToSelector:@selector(pullDownToRefreshAction)]) {
                [weakSelf.ZxDelegate pullDownToRefreshAction];
            }
        }];
        
    }
}


-(void)setIsNeedPullUpToRefreshAction:(BOOL)isEnable{
    if (_isNeedPullUpToRefreshAction == isEnable) {
        return;
    }
    _isNeedPullUpToRefreshAction = isEnable;
    __block typeof(self) weakSelf = self;
    if (_isNeedPullUpToRefreshAction) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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

    if([self.ZxDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]){
        id<ZxTableViewDataSource> dataSource = (id<ZxTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.ZxDelegate didSelectObject:object atIndexPath:indexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else if ([self.ZxDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.ZxDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.ZxDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<ZxTableViewDataSource> dataSource = (id<ZxTableViewDataSource>)tableView.dataSource;
        ZxTableViewSectionObject *sectionObject = [((ZxTableViewDataSource *)dataSource).sections objectAtIndex:section];
        return [self.ZxDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.ZxDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]){
        return [self.ZxDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - 传递原生协议

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.ZxDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.ZxDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}


@end

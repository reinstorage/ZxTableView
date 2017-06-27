//
//  ZxBaseTableView.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/27.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZxTableViewDataSource.h"

@class ZxTableViewSectionObject;

@protocol ZxBaseTableViewDelegate <UITableViewDelegate>

@optional

/**
 选择一个cell的回调,并返回选择cell的数据结构和indexPath
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (UIView *)headerViewForSectionObject:(ZxTableViewSectionObject *)sectionObject atSection:(NSInteger)section;

// 下拉刷新触发的方法
- (void)pullDownToRefreshAction;

// 上拉加载触发的方法
- (void)pullUpToRefreshAction;

// 将来可以有 cell 的编辑，交换，左滑等回调

// 这个协议继承了UITableViewDelegate ，所以自己做一层中转，VC 依然需要实现某些代理方法。


@end

@interface ZxBaseTableView : UITableView<UITableViewDelegate>


@property (nonatomic, assign) id<ZxTableViewDataSource> ZxDataSource;

@property (nonatomic, assign)id<ZxBaseTableViewDelegate> ZxDelegate;

// 是否需要下拉刷新和上拉加载
@property (nonatomic, assign) BOOL isNeedPullDownToRefreshAction;
@property (nonatomic, assign) BOOL isNeedPullUpToRefreshAction;

- (void)stopRefreshingAnimation;
- (void)triggerRefreshing;


@end











//
//  ZxBaseListModel.h
//  ZxTableView
//
//  Created by ShawnXing on 2017/6/28.
//  Copyright © 2017年 ShawnXing. All rights reserved.
//

#import "ZxBaseModel.h"
#import "ZxBaseListItem.h"

@protocol ZxBaseListModelProtocol <NSObject>

@required
- (void)refreshRequestDidSuccess;
- (void)loadRequestDidSuccess;
- (void)didLoadLastPage;
- (void)handleAfterRequestFinish; // 请求结束后的操作，刷新tableview或关闭动画等。

@optional
- (void)didLoadFirstPage;

@end

@interface ZxBaseListModel : ZxBaseModel

@property (nonatomic, strong) ZxBaseListItem *listItem;
@property (nonatomic, weak) id<ZxBaseListModelProtocol> delegate;
@property (nonatomic, assign) BOOL isRefresh; // 如果为是，表示刷新，否则为加载。

- (void)loadPage:(int)pageNumber;
- (void)loadNextPage;
- (void)loadPreviousPage;

@end

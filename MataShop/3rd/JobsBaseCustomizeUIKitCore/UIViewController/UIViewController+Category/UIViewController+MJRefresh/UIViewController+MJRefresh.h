//
//  UIViewController+MJRefresh.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "NSObject+Extras.h"

#if __has_include(<ReactiveObjC/RACmetamacros.h>)
#import <ReactiveObjC/RACmetamacros.h>
#else
#import "RACmetamacros.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTScope.h>)
#import <ReactiveObjC/RACEXTScope.h>
#else
#import "RACEXTScope.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTKeyPathCoding.h>)
#import <ReactiveObjC/RACEXTKeyPathCoding.h>
#else
#import "RACEXTKeyPathCoding.h"
#endif

//#if __has_include(<ReactiveObjC/RACEXTRuntimeExtensions.h>)
//#import <ReactiveObjC/RACEXTRuntimeExtensions.h>
//#else
//#import "RACEXTRuntimeExtensions.h"
//#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#import "LOTAnimationMJRefreshHeader.h"
#import "MJRefreshConfigModel.h"
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MJRefresh)<BaseViewProtocol>

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigHeader;//头部的配置信息
@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigFooter;//尾部的配置信息

#pragma mark —— MJRefreshHeader
@property(nonatomic,strong)LOTAnimationMJRefreshHeader *lotAnimMJRefreshHeader;
@property(nonatomic,strong)MJRefreshNormalHeader *mjRefreshNormalHeader;
@property(nonatomic,strong)MJRefreshStateHeader *mjRefreshStateHeader;
@property(nonatomic,strong)MJRefreshHeader *mjRefreshHeader;
@property(nonatomic,strong)MJRefreshGifHeader *mjRefreshGifHeader;
#pragma mark —— MJRefreshFooter
@property(nonatomic,strong)MJRefreshAutoGifFooter *mjRefreshAutoGifFooter;
@property(nonatomic,strong)MJRefreshBackNormalFooter *mjRefreshBackNormalFooter;
@property(nonatomic,strong)MJRefreshAutoNormalFooter *mjRefreshAutoNormalFooter;
@property(nonatomic,strong)MJRefreshAutoStateFooter *mjRefreshAutoStateFooter;
@property(nonatomic,strong)MJRefreshAutoFooter *mjRefreshAutoFooter;
@property(nonatomic,strong)MJRefreshBackGifFooter *mjRefreshBackGifFooter;
@property(nonatomic,strong)MJRefreshBackStateFooter *mjRefreshBackStateFooter;
@property(nonatomic,strong)MJRefreshBackFooter *mjRefreshBackFooter;
@property(nonatomic,strong)MJRefreshFooter *mjRefreshFooter;

@end

NS_ASSUME_NONNULL_END

/**
 进页面的时候必须先走下拉刷新。当数据源有值的时候，tableview的content会被撑开，mj_footer会监视这个content，也可以理解为数据源
 数据源是否有值，是决定mj_footer 是否存在的先决条件
 **/
/**
{
    MJRefreshConfigModel *refreshConfigHeader = MJRefreshConfigModel.new;
    refreshConfigHeader.stateIdleTitle = @"下拉刷新数据";
    refreshConfigHeader.pullingTitle = @"下拉刷新数据";
    refreshConfigHeader.refreshingTitle = @"正在刷新数据";
    refreshConfigHeader.willRefreshTitle = Internationalization(@"Refreshing data");
    refreshConfigHeader.noMoreDataTitle = @"下拉刷新数据";
    
    MJRefreshConfigModel *refreshConfigFooter = MJRefreshConfigModel.new;
    refreshConfigFooter.stateIdleTitle = @"";
    refreshConfigFooter.pullingTitle = @"";
    refreshConfigFooter.refreshingTitle = @"";
    refreshConfigFooter.willRefreshTitle = @"";
    refreshConfigFooter.noMoreDataTitle = @"";
    
    self.lotAnimMJRefreshHeader.refreshConfigModel = refreshConfigHeader;
    self.refreshConfigFooter = refreshConfigFooter;//数据赋值
 
    _tableView.mj_header = self.lotAnimMJRefreshHeader;
    _tableView.mj_footer = self.mjRefreshAutoNormalFooter;
    self.view.mjRefreshTargetView = _tableView;
}
*/

/**
 {
     MJRefreshConfigModel *mJRefreshConfigModel = MJRefreshConfigModel.new;
     mJRefreshConfigModel.stateIdleTitle = @"下拉刷新数据";
     mJRefreshConfigModel.pullingTitle = @"下拉刷新数据";
     mJRefreshConfigModel.refreshingTitle = @"正在刷新数据";
     mJRefreshConfigModel.willRefreshTitle = Internationalization(@"Refreshing data");
     mJRefreshConfigModel.noMoreDataTitle = @"下拉刷新数据";
     self.refreshConfigHeader = mJRefreshConfigModel;//数据赋值
 
     _tableView.mj_header = self.mjRefreshNormalHeader;
     _tableView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
     self.view.mjRefreshTargetView = _tableView;
 }
 */

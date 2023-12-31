//
//  LOTAnimationMJRefreshFooter.h
//  DouYin
//
//  Created by Jobs on 2021/1/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JobsBlock.h"
#import "MJRefreshConfigModel.h"
#import "UIView+Measure.h"

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

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<lottie-ios/Lottie.h>)
#import <lottie-ios/Lottie.h>
#else
#import "Lottie.h"
#endif

//#if __has_include(<ReactiveObjC/RACEXTRuntimeExtensions.h>)
//#import <ReactiveObjC/RACEXTRuntimeExtensions.h>
//#else
//#import "RACEXTRuntimeExtensions.h"
//#endif

NS_ASSUME_NONNULL_BEGIN

/// 上拉加载Lottie动画
@interface LOTAnimationMJRefreshFooter : MJRefreshAutoGifFooter

@property(nonatomic,strong)MJRefreshConfigModel *refreshConfigModel;
@property(nonatomic,assign)CGSize lOTAnimationViewSize;

@end

NS_ASSUME_NONNULL_END

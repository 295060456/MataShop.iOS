//
//  UIView+SuspendView.h
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIView+Measure.h"
#import "MacroDef_Size.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SuspendView)

@property(nonatomic,weak)UIViewController *vc;
@property(nonatomic,strong)UIPanGestureRecognizer *panRcognize;

@end

NS_ASSUME_NONNULL_END

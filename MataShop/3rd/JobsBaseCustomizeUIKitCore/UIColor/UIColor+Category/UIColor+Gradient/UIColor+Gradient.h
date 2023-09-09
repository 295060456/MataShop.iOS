//
//  UIColor+Gradient.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/1.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 渐变色
@interface UIColor (Gradient)
/// ⚠️在cell上可能失灵，目前原因不明⚠️
+(UIColor *)gradientCorDataMutArr:(NSMutableArray <UIColor *>*_Nullable)CorDataMutArr
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                           opaque:(BOOL)opaque
                   targetViewRect:(CGRect)targetViewRect;

@end

NS_ASSUME_NONNULL_END

/**
 
 示例代码：
 
 UIColor *cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[RGB_COLOR(247, 131, 97),RGB_COLOR(245, 75, 100)]]
                                    startPoint:CGPointZero
                                      endPoint:CGPointZero
                                        opaque:NO
                                targetViewRect:label.frame];
 
 self.titleLabTextColor = cor;
 
 */

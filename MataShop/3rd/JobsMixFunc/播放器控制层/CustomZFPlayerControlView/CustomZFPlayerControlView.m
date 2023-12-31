//
//  ZFPlayerControlView.m
//  Shooting
//
//  Created by Jobs on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomZFPlayerControlView.h"

@interface CustomZFPlayerControlView ()

@property(nonatomic,copy)jobsByTwoIDBlock customZFPlayerControlViewBlock;

@end

@implementation CustomZFPlayerControlView

-(void)actionCustomZFPlayerControlViewBlock:(jobsByTwoIDBlock _Nullable)customZFPlayerControlViewBlock{
    self.customZFPlayerControlViewBlock = customZFPlayerControlViewBlock;
}

-(void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl{
    [self endEditing:YES];
    if (self.customZFPlayerControlViewBlock) {
        self.customZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@1);
    }
}

-(void)gestureDoubleTapped:(ZFPlayerGestureControl *)gestureControl{
    NSLog(@"");
    [self endEditing:YES];
}
//走一次
-(void)gestureBeganPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    NSLog(@"");
//    //UITableViewCell自动滚动到顶部
//    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                     atScrollPosition:UITableViewScrollPositionTop
//                             animated:YES];

}
//走多次
-(void)gestureChangedPan:(ZFPlayerGestureControl *)gestureControl
            panDirection:(ZFPanDirection)direction
             panLocation:(ZFPanLocation)location
            withVelocity:(CGPoint)velocity{
    NSLog(@"");
}
//走一次
-(void)gestureEndedPan:(ZFPlayerGestureControl *)gestureControl
          panDirection:(ZFPanDirection)direction
           panLocation:(ZFPanLocation)location{
    if (self.customZFPlayerControlViewBlock) {
        NSLog(@"%@",NSStringFromSelector(_cmd));
        self.customZFPlayerControlViewBlock(NSStringFromSelector(_cmd),@(gestureControl.panMovingDirection));
    }
}

-(void)gesturePinched:(ZFPlayerGestureControl *)gestureControl
                scale:(float)scale{
    NSLog(@"");
}

@end

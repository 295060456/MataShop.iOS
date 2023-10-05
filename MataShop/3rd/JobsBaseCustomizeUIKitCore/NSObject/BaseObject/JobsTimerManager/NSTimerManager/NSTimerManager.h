//
//  NSTimerManager.h
//  Timer
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JobsBlock.h"
#import "JobsTimerManager_DefineStructure.h"
#import "JobsTimeModel.h"
#import "NSObject+Time.h"
#import "MacroDef_Func.h"

@class NSTimerManager;

typedef enum : NSInteger {
    TimerProcessType_ready = 0,
    TimerProcessType_running,
    TimerProcessType_end
} TimerProcessType;

/**
 *  此类虽然为工具类，但是不允许用单例，因为timer需要被释放

 *  NSTimer只有被加入到runloop, 才会生效, 即NSTimer才会被真正执行
 *  scheduledTimerWithTimeInterval相比它的小伙伴们不仅仅是创建了NSTimer对象, 还把该对象加入到了当前的runloop中，runloop的模式为默认模式（NSDefaultRunLoopMode）!
 */
NS_ASSUME_NONNULL_BEGIN

@interface TimerProcessModel : NSObject

@property(nonatomic,assign)TimerProcessType timerProcessType;
@property(nonatomic,strong)NSTimerManager *data;

@end

@interface NSTimerManager : NSObject

@property(nonatomic,strong)NSInvocation *invocation;
@property(nonatomic,strong,nullable)id target;
@property(nonatomic,assign,nullable)SEL selector;
@property(nonatomic,strong,nullable)id userInfo;
@property(nonatomic,assign)ScheduledTimerType timerType;
@property(nonatomic,assign)TimerStyle timerStyle;/// 逆时针模式?顺时针模式？
@property(nonatomic,assign)CGFloat anticlockwiseTime;/// ❤️【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】
@property(nonatomic,assign,readonly)NSTimerCurrentStatus timerCurrentStatus;// 定时器当前状态

@property(nonatomic,strong)TimerProcessModel *timerProcessModel;
@property(nonatomic,assign)NSTimeInterval timeSecIntervalSinceDate;/// 推移时间，秒数
@property(nonatomic,assign)NSTimeInterval timeInterval;/// 时间间距
@property(nonatomic,assign)BOOL repeats;
@property(nonatomic,strong,nullable)NSTimer *__block nsTimer;
/// 定时器启动 手动添加定时器到RunLoop
-(void)nsTimeStartWithRunLoop:(NSRunLoop *_Nullable)runLoop;/// currentRunLoop可调用子线程；mainrunloop主线程
/// 定时器启动：newTimer + 系统自动添加到RunLoop
-(NSTimer *)nsTimeStartSysAutoInRunLoop;
/// 定时器暂停
-(void)nsTimePause;
/// 定时器继续
-(void)nsTimecontinue;
/// 销毁定时器
-(void)nsTimeDestroy;

@end

NS_ASSUME_NONNULL_END

/*  关于 - (void)fire; 方法
 *  其实他并不是真的启动一个定时器，从之前的初始化方法中我们也可以看到，建立的时候，在适当的时间，定时器就会自动启动，也即NSTimer是不准时的
 *  即  fire  方法只是提前出发定时器的执行，但不影响定时器的设定时间。
 */

/**
 
 调用示例：
 
 -(NSTimerManager *)nsTimerManager{
     if (!_nsTimerManager) {
         _nsTimerManager = NSTimerManager.new;
         /// 以下2种模式任选一种
         {/// 顺时针模式
             _nsTimerManager.timerStyle = TimerStyle_clockwise;
         }
         
 //        {/// 逆时针模式
 //            _nsTimerManager.timerStyle = TimerStyle_anticlockwise;
 //            _nsTimerManager.anticlockwiseTime = 100;
 //        }
         
         _nsTimerManager.timeInterval = .5f;
         @jobs_weakify(self)
         [_nsTimerManager actionObjectBlock:^(id data) {
             @jobs_strongify(self)
             if ([data isKindOfClass:TimerProcessModel.class]) {
                 TimerProcessModel *model = (TimerProcessModel *)data;
                 NSLog(@"❤️❤️❤️❤️❤️%f",model.data.anticlockwiseTime);
                 self.valueLab.text = [NSString stringWithFormat:@"%.2f",model.data.anticlockwiseTime];
             }
         }];
     }return _nsTimerManager;
 }

 */

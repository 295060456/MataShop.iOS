//
//  NSNotificationCenter+JobsBlock.h
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/24/23.
//

#import <Foundation/Foundation.h>
#import "MacroDef_Notification.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (JobsBlock)

@property(nonatomic,copy)void (^jobsNotificationBlock)(NSNotification *notification);

@end

NS_ASSUME_NONNULL_END
/**
 使用方法 1：
 [NSNotificationCenter.defaultCenter addObserverForName:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                 object:nil
                                                  queue:nil
                                             usingBlock:^(NSNotification * _Nonnull notification) {
     NSString *d = notification.name;
     NSLog(@"");
 }];
 =================================================================================================
 或者，使用方法 2：
 NSNotificationCenter.defaultCenter.jobsNotificationBlock = ^(NSNotification * _Nonnull notification) {
     NSString *d = notification.name;
     NSLog(@"");
 };

 // 添加观察者监听通知
 [NSNotificationCenter.defaultCenter addObserverForName:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                 object:nil
                                                  queue:nil
                                             usingBlock:NSNotificationCenter.defaultCenter.jobsNotificationBlock];
 =================================================================================================
 或者，使用方法 3：
 [NSNotificationCenter.defaultCenter addObserver:self
                                        selector:selectorBlocks(^(JobsBitsMonitorSuspendLab *_Nullable weakSelf,
                                                                  NSNotification *_Nullable arg) {
     /// upload
     NSLog(@"");
 }, self)
                                            name:GSUploadNetworkSpeedNotificationKey
                                          object:nil];
 
 */

//
//  CollectionView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "JobsBlock.h"

NS_ASSUME_NONNULL_BEGIN

/**
    1、子类如果重写-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event，
        则将会被优先执行，从而忽略UICollectionViewDelegate方法；
    2、监听reloadData的方法： 因为reloadData刷新UI是在主线程上，那么就在主线程上等待。直接在reloadData后获取主线程操作等待；
 */
@interface BaseCollectionView : UICollectionView<BaseViewProtocol>

@property(nonatomic,copy)jobsByIDBlock baseCollectionViewBlock;
/*
    用于以此为基类的UICollectionView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseCollectionView:(jobsByIDBlock)baseCollectionViewBlock;

@end

NS_ASSUME_NONNULL_END


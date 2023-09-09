//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)registerCollectionViewClass{
    // CollectionReusableView-Header
    [self registerCollectionElementKindSectionHeaderClass:UICollectionReusableView.class];
    [self registerCollectionElementKindSectionHeaderClass:BaseCollectionReusableView.class];
    [self registerCollectionElementKindSectionHeaderClass:JobsHotLabelWithMultiLineHeaderFooterView.class];
//    [self registerCollectionElementKindSectionHeaderClass:BaiShaETProjMywalletCRView.class];
//    [self registerCollectionElementKindSectionHeaderClass:BaiShaETProjTopupTipsVIew.class];
//    [self registerCollectionElementKindSectionHeaderClass:BaiShaETProjUSDTWithdrawalCRView.class];
    // CollectionReusableView—Footer
    [self registerCollectionElementKindSectionFooterClass:UICollectionReusableView.class];
    [self registerCollectionElementKindSectionFooterClass:JobsHotLabelWithMultiLineHeaderFooterView.class];
//    [self registerCollectionElementKindSectionFooterClass:BaiShaETProjVIPSubCVFooterView.class];
//    [self registerCollectionElementKindSectionFooterClass:BaiShaETProjTopupTipsVIew.class];
    // CollectionViewCell
    [self registerCollectionViewCellClass:UICollectionViewCell.class];
    [self registerCollectionViewCellClass:BaseCollectionViewCell.class];
    [self registerCollectionViewCellClass:JobsHotLabelWithMultiLineCVCell.class];
    [self registerCollectionViewCellClass:JobsCVCell.class];

//    [self registerCollectionViewCellClass:BaiShaETProjCVCellStyle1.class];
//    [self registerCollectionViewCellClass:BaiShaETProjMyWalletCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjHeaderIconCVCell.class];
//    
//    [self registerCollectionViewCellClass:BaiShaETProjVIPSubCVCell_01.class];
//    [self registerCollectionViewCellClass:BaiShaETProjVIPSubCVCell_02.class];
//    [self registerCollectionViewCellClass:BaiShaETProjVIPSubCVCell_03.class];
//    [self registerCollectionViewCellClass:BaiShaETProjVIPSubCVCell_04.class];
//    [self registerCollectionViewCellClass:BaiShaETProjVIPSubCVCell_05.class];
    
//    [self registerCollectionViewCellClass:BaiShaETProjFirstGiftVCVCell_01.class];
//    [self registerCollectionViewCellClass:BaiShaETProjFirstGiftVCVCell_02.class];
//    [self registerCollectionViewCellClass:BaiShaETProjFirstGiftVCVCell_03.class];
//    
//    [self registerCollectionViewCellClass:BaiShaETProjAmountDepositInputCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjDealProtocalCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjCoinSpeciesCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjPaymentWayCVCell.class];
//    
//    [self registerCollectionViewCellClass:BaiShaETProjCountdownCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjOrderDetailsCVCell.class];
//    [self registerCollectionViewCellClass:BaiShaETProjAmountDepositClickCVCell.class];
//    
//    [self registerCollectionViewCellClass:BaiShaETProjUSDTWithdrawalCVCell.class];
}
/// 注册 UICollectionViewCell 及其子类
-(void)registerCollectionViewCellClass:(Class)cls{
    [self registerClass:cls forCellWithReuseIdentifier:cls.description];
}
/// 注册 UICollectionElementKindSectionHeader 及其子类
-(void)registerCollectionElementKindSectionHeaderClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
    withReuseIdentifier:cls.description];
}
/// 注册 UICollectionElementKindSectionFooter 及其子类
-(void)registerCollectionElementKindSectionFooterClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
    withReuseIdentifier:cls.description];
}
/// 依据字符串取UICollectionElementKindSectionHeader
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionHeaderClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath{
    [self registerCollectionElementKindSectionHeaderClass:cls];
    UICollectionReusableView *collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:cls.description
                                                                                       forIndexPath:indexPath];
    if (!collectionReusableView) {
        collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                          withReuseIdentifier:cls.description
                                                                 forIndexPath:indexPath];
    }
    collectionReusableView.indexPath = indexPath;
    return collectionReusableView;
}
/// 依据字符串取UICollectionElementKindSectionFooter
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionFooterClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath{
    [self registerCollectionElementKindSectionFooterClass:cls];
    UICollectionReusableView *collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                withReuseIdentifier:cls.description
                                                                                       forIndexPath:indexPath];
    if (!collectionReusableView) {
        collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                          withReuseIdentifier:cls.description
                                                                 forIndexPath:indexPath];
    }
    collectionReusableView.indexPath = indexPath;
    return collectionReusableView;
}
/// 先用UICollectionViewLayout生成CollectionView。frame后面设置
+(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    return [self.alloc initWithFrame:CGRectZero
                collectionViewLayout:layout];
}
/// 一种用字符串取UICollectionViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(UICollectionViewCell *)collectionViewCellClass:(Class)cls
                                    forIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueReusableCellWithReuseIdentifier:cls.description
                                           forIndexPath:indexPath];
}

@end

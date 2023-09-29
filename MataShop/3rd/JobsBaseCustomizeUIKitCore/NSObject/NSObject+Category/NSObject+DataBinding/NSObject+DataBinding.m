//
//  NSObject+DataBinding.m
//  DouDong-II
//
//  Created by Jobs on 2021/4/22.
//

#import "NSObject+DataBinding.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation NSObject (DataBinding)

-(void)dataLinkByTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
}

-(void)dataLinkByCollectionView:(UICollectionView *)collectionView{
    collectionView.delegate = self;
    collectionView.dataSource = self;
}
#pragma mark —— @property(nonatomic,strong)id objBindingParams;
@dynamic objBindingParams;
-(id)objBindingParams{
    id ObjBindingParams = objc_getAssociatedObject(self, _cmd);
    return ObjBindingParams;
}

-(void)setObjBindingParams:(id)objBindingParams{
    objc_setAssociatedObject(self,
                             _cmd,
                             objBindingParams,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma clang diagnostic pop

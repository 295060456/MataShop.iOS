//
//  UITextField+Extend.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)
#pragma mark —— 一些功能方法
/// RAC 回调封装
-(RACDisposable *)jobsTextFieldEventFilterBlock:(JobsReturnBOOLByIDBlock)filterBlock
                             subscribeNextBlock:(jobsByIDBlock)subscribeNextBlock{
    return [[self.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return filterBlock ? filterBlock(value) : YES;
    }] subscribeNext:^(NSString * _Nullable x) {
        if (subscribeNextBlock) subscribeNextBlock(x);
    }];
}

-(NSString *)getCurrentTextFieldValueByReplacementString:(NSString *)replacementString{
    if (self.text.length >= 1) {
        return [replacementString isEqualToString:@""] ? [self.text substringToIndex:(self.text.length - 1)] : [self.text stringByAppendingString:replacementString];
    }else{
        return replacementString;
    }
}
/// 自定义系统的清除按钮
- (void)modifyClearButtonWithImage:(UIImage *)image{
    self.customSysClearBtn.normalImage = image;
    self.rightView = self.customSysClearBtn;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
}
#pragma mark —— SET | GET
@dynamic customSysClearBtn;
-(UIButton *)customSysClearBtn{
    UIButton *CustomSysClearBtn = objc_getAssociatedObject(self, _cmd);
    if (!CustomSysClearBtn) {
        CustomSysClearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CustomSysClearBtn.frame = CGRectMake(0.0f,0.0f,15.0f,15.0f);
        @jobs_weakify(self)
        [CustomSysClearBtn jobsBtnClickEventBlock:^id(UIButton *data) {
            @jobs_strongify(self)
            self.text = @"";
            return nil;
        }];
        [self setCustomSysClearBtn:CustomSysClearBtn];
    }return CustomSysClearBtn;
}

-(void)setCustomSysClearBtn:(UIButton *)customSysClearBtn{
    objc_setAssociatedObject(self,
                             _cmd,
                             customSysClearBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

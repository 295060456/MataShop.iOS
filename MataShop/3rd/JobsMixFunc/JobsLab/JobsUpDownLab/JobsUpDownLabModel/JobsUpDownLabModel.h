//
//  JobsUpDownLabModel.h
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "JobsLabBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsUpDownLabModel : JobsLabBaseModel

@end

NS_ASSUME_NONNULL_END
/**
 
 {
    JobsUpDownLabModel *upDownLabModel = JobsUpDownLabModel.new;
    upDownLabModel.upLabText = @"2.2";
    upDownLabModel.upLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    upDownLabModel.upLabTextCor = UIColor.blackColor;
    upDownLabModel.upLabBgCor = UIColor.clearColor;

    upDownLabModel.downLabText = Internationalization(@"Estimated yesterday");
    upDownLabModel.downLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    upDownLabModel.downLabTextCor = HEXCOLOR(0x524740);
    upDownLabModel.downLabBgCor = UIColor.clearColor;

    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

    upDownLabModel.space = JobsWidth(12);
 }
 
 */


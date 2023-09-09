//
//  UITableViewCell+WhiteArrows.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UITableViewCell+WhiteArrows.h"

@implementation UITableViewCell (WhiteArrows)
/// 必须 self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 打开后才可以启用
-(void)customAccessoryView:(jobsByIDBlock)customAccessoryViewBlock{
    /// 不用系统自带的箭头
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        UIButton *btn = UIButton.new;
        /// 特比注意:如果这个地方是纯view（UIView、UIIMageView...）就可以不用加size，UIButton是因为受到了UIControl，需要接收一个size，否则显示不出来
        btn.size = self.size;
        btn.normalBackgroundImage = self.img;
        @jobs_weakify(self)
        [btn btnClickEventBlock:^(id data) {
            @jobs_strongify(self)
            if (customAccessoryViewBlock) customAccessoryViewBlock(self);
        }];
        self.accessoryView = btn;
    }
}
static char *UITableViewCell_WhiteArrows_img = "UITableViewCell_WhiteArrows_img";
@dynamic img;
#pragma mark —— @property(nonatomic,strong)UIImage *img;
-(void)setImg:(UIImage *)img{
    objc_setAssociatedObject(self,
                             UITableViewCell_WhiteArrows_img,
                             img,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)img{
    UIImage *image = objc_getAssociatedObject(self, UITableViewCell_WhiteArrows_img);
    if (!image) {
        image = JobsIMG(@"WhiteRightArrow");
        objc_setAssociatedObject(self,
                                 UITableViewCell_WhiteArrows_img,
                                 image,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return image;
}
static char *UITableViewCell_WhiteArrows_size = "UITableViewCell_WhiteArrows_size";
@dynamic size;
#pragma mark —— @property(nonatomic,assign)CGSize size;
-(CGSize)size{
    CGSize Size = [objc_getAssociatedObject(self, UITableViewCell_WhiteArrows_size) CGSizeValue];
    if (CGSizeEqualToSize(Size, CGSizeZero)) {
        Size = CGSizeMake(JobsWidth(10), JobsWidth(18.3));//缺省值
        objc_setAssociatedObject(self,
                                 UITableViewCell_WhiteArrows_size,
                                 [NSValue valueWithCGSize:Size],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Size;
}

-(void)setSize:(CGSize)size{
    objc_setAssociatedObject(self,
                             UITableViewCell_WhiteArrows_size,
                             [NSValue valueWithCGSize:size],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

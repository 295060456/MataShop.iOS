//
//  UIViewController+BaseNavigationBar.m
//  UBallLive
//
//  Created by Jobs on 2020/10/21.
//

#import "UIViewController+BaseNavigationBar.h"

@implementation UIViewController (BaseNavigationBar)

static char *UIViewController_NavigationBar_navigationBar = "UIViewController_NavigationBar_navigationBar";
@dynamic navigationBar;

static char *UIViewController_NavigationBar_leftBarButtonItem_back = "UIViewController_NavigationBar_leftBarButtonItem_back";
@dynamic leftBarButtonItem_back;

static char *UIViewController_NavigationBar_bgCor = "UIViewController_NavigationBar_bgCor";
@dynamic bgCor;

static char *UIViewController_NavigationBar_jobsNavigationBarHeight = "UIViewController_NavigationBar_jobsNavigationBarHeight";
@dynamic jobsNavigationBarHeight;

static char *UIViewController_NavigationBar_isHiddenNavigationBar = "UIViewController_NavigationBar_isHiddenNavigationBar";
@dynamic isHiddenNavigationBar;

static char *UIViewController_NavigationBar_isBarTranslucent = "UIViewController_NavigationBar_isBarTranslucent";
@dynamic isBarTranslucent;

static char *UIViewController_NavigationBar_shadow = "UIViewController_NavigationBar_shadow";
@dynamic shadow;

static char *UIViewController_NavigationBar_navItem = "UIViewController_NavigationBar_navItem";
@dynamic navItem;

static char *UIViewController_NavigationBar_foregroundColorAttributeNameCor = "UIViewController_NavigationBar_foregroundColorAttributeNameCor";
@dynamic foregroundColorAttributeNameCor;

static char *UIViewController_NavigationBar_fontAttributeName = "UIViewController_NavigationBar_fontAttributeName";
@dynamic fontAttributeName;

static char *UIViewController_NavigationBar_tintColor = "UIViewController_NavigationBar_tintColor";
@dynamic tintColor;

static char *UIViewController_NavigationBar_barTintColor = "UIViewController_NavigationBar_barTintColor";
@dynamic barTintColor;

static char *UIViewController_NavigationBar_title = "UIViewController_NavigationBar_title";
@dynamic title;

static char *UIViewController_NavigationBar_shadowCor = "UIViewController_NavigationBar_shadowCor";
@dynamic shadowCor;

- (void)gotoback{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}
#pragma mark —— @property(nonatomic,strong)NavigationBar *navigationBar;
-(void)setNavigationBar:(BaseNavigationBar *)navigationBar{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_navigationBar,
                             navigationBar,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BaseNavigationBar *)navigationBar{
    BaseNavigationBar *NavBar = objc_getAssociatedObject(self, UIViewController_NavigationBar_navigationBar);
    if (!NavBar) {
        NavBar = BaseNavigationBar.new;
        //优先级:背景图 > 背景色
        NavBar.backgroundColor = self.bgCor;
        [NavBar setBackgroundImage:self.bgImage
                     forBarMetrics:UIBarMetricsDefault];//仅仅是 navigationBar 背景
        NavBar.titleTextAttributes = @{
            NSForegroundColorAttributeName:self.foregroundColorAttributeNameCor,
            NSShadowAttributeName:self.shadow,
            NSFontAttributeName:self.fontAttributeName
        };//设置导航上的title显示样式
        [NavBar setBarTintColor:JobsRedColor];//一般的业务是全局设置，因为一个App里面只有一个主题
        NavBar.tintColor = JobsBlackColor;//系统的组件着色（返回按钮——箭头图标 和 上面的字）
        NavBar.items = @[self.navItem];

        NavBar.translucent = self.isBarTranslucent;
        NavBar.hidden = self.isHiddenNavigationBar;
        [self.view addSubview:NavBar];
        [NavBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.height.mas_offset(self.jobsNavigationBarHeight);
        }];
        
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_navigationBar,
                                 NavBar,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return NavBar;
}
#pragma mark —— @property(nonatomic,strong)UIBarButtonItem *leftBarButtonItem_back;
-(UIBarButtonItem *)leftBarButtonItem_back{
    UIBarButtonItem *LeftBarButtonItem_back = objc_getAssociatedObject(self, UIViewController_NavigationBar_leftBarButtonItem_back);
    if (!LeftBarButtonItem_back) {
        if(self.navigationController.viewControllers.count > 1){
            NSString *imageName = self.gk_backStyle == GKNavigationBarBackStyleBlack ? @"btn_back_black" : @"btn_back_white";
            UIImage *backImage = JobsBuddleIMG(nil,
                                            @"Frameworks/GKNavigationBar.framework/GKNavigationBar",
                                            nil,
                                            imageName);
            LeftBarButtonItem_back = [[UIBarButtonItem alloc]initWithImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                     style:UIBarButtonItemStyleDone
                                                                    target:self
                                                                    action:@selector(gotoback)];
            objc_setAssociatedObject(self,
                                     UIViewController_NavigationBar_leftBarButtonItem_back,
                                     LeftBarButtonItem_back,
                                     OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }return LeftBarButtonItem_back;
}

- (void)setLeftBarButtonItem_back:(UIBarButtonItem *)leftBarButtonItem_back{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_leftBarButtonItem_back,
                             leftBarButtonItem_back,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *bgCor;
-(UIColor *)bgCor{
    UIColor *BgCor = objc_getAssociatedObject(self, UIViewController_NavigationBar_bgCor);
    if (!BgCor) {
        BgCor = JobsLightGrayColor;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_bgCor,
                                 BgCor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgCor;
}

-(void)setBgCor:(UIColor *)bgCor{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_bgCor,
                             bgCor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)CGFloat jobsNavigationBarHeight;
-(CGFloat)jobsNavigationBarHeight{
    CGFloat jobsNavigationBarHeight = [objc_getAssociatedObject(self, UIViewController_NavigationBar_jobsNavigationBarHeight) floatValue];
    if (jobsNavigationBarHeight == 0) {
        jobsNavigationBarHeight = JobsNavigationBarAndStatusBarHeight(nil);
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_jobsNavigationBarHeight,
                                 [NSNumber numberWithFloat:jobsNavigationBarHeight],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return jobsNavigationBarHeight;
}

-(void)setJobsNavigationBarHeight:(CGFloat)jobsNavigationBarHeight{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_jobsNavigationBarHeight,
                             [NSNumber numberWithFloat:jobsNavigationBarHeight],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isHiddenNavigationBar
-(BOOL)isHiddenNavigationBar{//默认不显示
    BOOL IsHiddenNavigationBar = [objc_getAssociatedObject(self, UIViewController_NavigationBar_isHiddenNavigationBar) boolValue];
    return IsHiddenNavigationBar;
}

-(void)setIsHiddenNavigationBar:(BOOL)isHiddenNavigationBar{
    [self.navigationController setNavigationBarHidden:isHiddenNavigationBar animated:true];
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_isHiddenNavigationBar,
                             [NSNumber numberWithBool:isHiddenNavigationBar],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isBarTranslucent;
-(BOOL)isBarTranslucent{//默认
    BOOL IsBarTranslucent = [objc_getAssociatedObject(self, UIViewController_NavigationBar_isBarTranslucent) boolValue];
    return IsBarTranslucent;
}

-(void)setIsBarTranslucent:(BOOL)isBarTranslucent{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_isBarTranslucent,
                             [NSNumber numberWithBool:isBarTranslucent],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSShadow *shadow;
-(void)setShadow:(NSShadow *)shadow{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_shadow,
                             shadow,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSShadow *)shadow{
    NSShadow *Shadow = objc_getAssociatedObject(self, UIViewController_NavigationBar_shadow);
    if (!Shadow) {
        Shadow = NSShadow.new;
        Shadow.shadowColor = self.shadowCor;
        Shadow.shadowOffset = CGSizeZero;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_shadow,
                                 Shadow,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Shadow;
}
#pragma mark —— @property(nonatomic,strong)UINavigationItem *navItem;
-(UINavigationItem *)navItem{
    UINavigationItem *NavItem = objc_getAssociatedObject(self, UIViewController_NavigationBar_navItem);
    if (!NavItem) {
        NavItem = UINavigationItem.new;
        NavItem.title = self.title;
        NavItem.leftBarButtonItem = self.leftBarButtonItem_back;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_navItem,
                                 NavItem,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return NavItem;
}

-(void)setNavItem:(UINavigationItem *)navItem{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_navItem,
                             navItem,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *foregroundColorAttributeNameCor;
-(UIColor *)foregroundColorAttributeNameCor{
    UIColor *ForegroundColorAttributeNameCor = objc_getAssociatedObject(self, UIViewController_NavigationBar_foregroundColorAttributeNameCor);
    if (!ForegroundColorAttributeNameCor) {
        ForegroundColorAttributeNameCor = JobsGreenColor;//JobsBlackColor;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_foregroundColorAttributeNameCor,
                                 ForegroundColorAttributeNameCor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ForegroundColorAttributeNameCor;
}

-(void)setForegroundColorAttributeNameCor:(UIColor *)foregroundColorAttributeNameCor{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_foregroundColorAttributeNameCor,
                             foregroundColorAttributeNameCor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIFont *fontAttributeName;
-(UIFont *)fontAttributeName{
    UIFont *FontAttributeName = objc_getAssociatedObject(self, UIViewController_NavigationBar_fontAttributeName);
    if (!FontAttributeName) {
        FontAttributeName = JobsFontRegular(18);
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_fontAttributeName,
                                 FontAttributeName,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return FontAttributeName;
}
#pragma mark —— @property(nonatomic,strong)UIColor *tintColor;
-(UIColor *)tintColor{
    UIColor *TintColor = objc_getAssociatedObject(self, UIViewController_NavigationBar_tintColor);
    if (!TintColor) {
        TintColor = JobsGreenColor;//JobsBlackColor;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_tintColor,
                                 TintColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TintColor;
}

-(void)setTintColor:(UIColor *)tintColor{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_tintColor,
                             tintColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *barTintColor;
-(UIColor *)barTintColor{
    UIColor *BarTintColor = objc_getAssociatedObject(self, UIViewController_NavigationBar_barTintColor);
    if (!BarTintColor) {
        BarTintColor = JobsGreenColor;//JobsBlackColor;
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_barTintColor,
                                 BarTintColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BarTintColor;
}

-(void)setBarTintColor:(UIColor *)barTintColor{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_barTintColor,
                             barTintColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *title;
-(NSString *)title{
    NSString *Title = objc_getAssociatedObject(self, UIViewController_NavigationBar_title);
    return Title;
}

-(void)setTitle:(NSString *)title{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_title,
                             title,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *shadowCor;
-(UIColor *)shadowCor{
    UIColor *ShadowCor = objc_getAssociatedObject(self, UIViewController_NavigationBar_shadowCor);
    if (!ShadowCor) {
        ShadowCor = RGBA_COLOR(0,
                              0,
                              0,
                              0.8);
        objc_setAssociatedObject(self,
                                 UIViewController_NavigationBar_shadowCor,
                                 ShadowCor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ShadowCor;
}

-(void)setShadowCor:(UIColor *)shadowCor{
    objc_setAssociatedObject(self,
                             UIViewController_NavigationBar_shadowCor,
                             shadowCor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

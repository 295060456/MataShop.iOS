//
//  BaseViewController.m
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark —— UIViewModelProtocol
UIViewModelProtocol_synthesize
#pragma mark —— BaseViewControllerProtocol
BaseViewControllerProtocol_synthesize

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.view endEditing:YES];
    if (JobsDebug) {
        toast([NSString stringWithFormat:@"%@%@",Internationalization(@"成功销毁了控制器"),NSStringFromClass(self.class)]);
        NSLog(@"%@",JobsLocalFunc);
        PrintRetainCount(self)
    }
}
/// new方法触发
- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}
/// new方法触发
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {

    }return self;
}

-(void)loadView{
    [super loadView];
    self.isHiddenNavigationBar = YES;
    self.setupNavigationBarHidden = YES;
    self.currentPage = 1;
    self.modalInPresentation = NO;/// 禁用下拉手势dismiss画面需要将此属性设置为YES
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     NOTE:
     View controllers presented with custom presentation controllers
     do not assume control of the status bar appearance by default
     (their -preferredStatusBarStyle and -prefersStatusBarHidden
     methods are not called).  You can override this behavior by
     setting the value of the presented view controller's
     modalPresentationCapturesStatusBarAppearance property to YES.
     
     self.modalPresentationCapturesStatusBarAppearance = YES;
     */
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
    [self setBackGround];
//    self.gk_navRightBarButtonItems = @[[UIBarButtonItem.alloc initWithCustomView:self.msgBtn],
//                                       [UIBarButtonItem.alloc initWithCustomView:self.customerServiceBtn]];
//    self.gk_navLeftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.userHeadBtn];
    self.gk_statusBarHidden = NO;
    /*
     *  #pragma mark —— 全局配置 GKNavigationBar -(void)makeGKNavigationBarConfigure
     */
//    {
//        self.gk_navBackgroundColor = JobsWhiteColor;
//        self.gk_navTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
//        self.gk_navTitleColor = AppMainCor_01;
//        self.gk_backStyle = GKNavigationBarBackStyleBlack;
//        self.gk_navLineHidden = YES;
//    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    JobsAddNotification(self,
                    @selector(languageSwitchNotification:),
                    LanguageSwitchNotification,
                    nil);
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self updateStatusBarCor:JobsOrangeColor];/// 在具体子类实现，不要写在父类
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /// 只有是在Tabbar管理的，不含导航的根控制器才开启手势（点语法会有 Property access result unused警告）
    self.isRootVC ? [self tabBarOpenPan] : [self tabBarClosePan];
    [self UIViewControllerLifeCycle:JobsLocalFunc];
#ifdef DEBUG
    /// 网络异步数据刷新UI会在viewDidAppear以后执行viewWillLayoutSubviews、viewDidLayoutSubviews
//    [self ifEmptyData];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self restoreStatusBarCor:nil];
    [self UIViewControllerLifeCycle:JobsLocalFunc];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.mjRefreshTargetView.mj_footer.y = self.view.mjRefreshTargetView.contentSize.height;
    [self UIViewControllerLifeCycle:JobsLocalFunc];
}
/**
 iOS 状态栏颜色的修改
 【全局修改】
  1、在Info.plist里面加入如下键值对：
     1.1、View controller-based status bar appearance : NO
     1.2、Status bar style : Light Content

  2、[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;// iOS 13 后方法被标注废弃

  1.2 和 2 任意选一个即可

 【局部修改】
  1、在Info.plist里面加入如下键值对：
  View controller-based status bar appearance ： YES //全局是NO、局部是YES
  2、@ interface BaseNavigationVC : UINavigationController
     2.1、在 BaseNavigationVC.m里面写入：
     - (UIViewController *)childViewControllerForStatusBarStyle {
             return self.topViewController;
     }
     2.2、在具体的需要修改的VC.m里面写入：
     -(UIStatusBarStyle)preferredStatusBarStyle{
         return UIStatusBarStyleLightContent;
     }
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark —— 一些私有方法
/// 用于检测UIViewController的生命周期
-(void)UIViewControllerLifeCycle:(NSString *)lifeCycle{
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.data = nil;
    viewModel.requestParams = lifeCycle;
    if(self.objectBlock) self.objectBlock(viewModel);
}
/// 更新状态栏颜色为自定义的颜色
- (void)updateStatusBarCor:(UIColor *_Nullable)cor{
    if(!cor)cor = JobsRedColor;
    if (@available(iOS 13.0, *)) {
        if (![self.view.subviews containsObject:self.statusBar]) {
            [self.view addSubview:self.statusBar];
        }
        self.statusBar.backgroundColor = cor;
    } else {
        UIView *statusBar = [UIApplication.sharedApplication.valueForKeyBlock(@"statusBarWindow") valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = cor;
        }
        // 手动触发 preferredStatusBarStyle 更新状态栏颜色
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
/// 恢复状态栏颜色
-(void)restoreStatusBarCor:(UIColor *_Nullable)cor{
    if (@available(iOS 13.0, *)) {
        if (![jobsGetMainWindow().subviews containsObject:self.statusBar]) {
            [self.statusBar removeFromSuperview];
        }
        if(!cor) cor = JobsWhiteColor;
        self.statusBar.backgroundColor = cor;
    } else {
        UIView *statusBar = [UIApplication.sharedApplication.valueForKeyBlock(@"statusBarWindow") valueForKey:@"statusBar"];
        if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
            statusBar.backgroundColor = UIColor.clearColor;;
        }
        // 手动触发 preferredStatusBarStyle 更新状态栏颜色
        [self setNeedsStatusBarAppearanceUpdate];
    }
}
/// 在loadView或者之前的生命周期中定义背景图片或者底色
-(void)setBackGround{
    /// 底图没有 + 底色没有
    if(!self.viewModel.bgImage && !self.viewModel.bgCor){
        self.view.backgroundColor = HEXCOLOR(0xFCFBFB);
//        NSString *corStr = self.view.backgroundColor.rgbCorStr;
        return;
    }
    /// 底图有 + 底色没有
    if(self.viewModel.bgImage && !self.viewModel.bgCor){
        self.bgImageView.alpha = 1;
        return;
    }
    /// 底图没有 + 底色有
    if(!self.viewModel.bgImage && self.viewModel.bgCor){
        self.view.backgroundColor = self.viewModel.bgCor;
//        NSString *corStr = self.view.backgroundColor.rgbCorStr;
        return;
    }
    /// 底图有 + 底色有 = 优先使用底图数据
    if(self.viewModel.bgImage && self.viewModel.bgCor){
        self.bgImageView.alpha = 1;
        return;
    }
}
#pragma mark —— 自定义模态动画推出ViewController
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    NSLog(@"%f",self.presentUpHeight);
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width,
                                           traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : self.presentUpHeight);/// 上升的高度
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
#pragma mark —— BaseProtocol
/// 接收通知相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
    NSLog(@"通知传递过来的 = %@",notification.object);
}
#pragma mark —— lazyLoad
- (UIView *)statusBar{
    if (!_statusBar) {
        _statusBar = [UIView.alloc initWithFrame:jobsGetMainWindowWithSize().windowScene.statusBarManager.statusBarFrame];
    }return _statusBar;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        _bgImageView.frame = self.view.bounds;
        _bgImageView.image = self.viewModel.bgImage;
        _bgImageView.userInteractionEnabled = YES;
//        self.view = _bgImageView; // 有时候不正确
        [self.view insertSubview:_bgImageView atIndex:0];
    }return _bgImageView;
}

-(UIViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = UIViewModel.new;
        _viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
        _viewModel.textModel.font = UIFontWeightRegularSize(16);
    }return _viewModel;
}

@end

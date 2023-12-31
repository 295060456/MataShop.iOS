//
//  MSChuBaoVC.m
//  MataShop
//
//  Created by Jobs Hi on 9/11/23.
//

#import "MSChuBaoVC.h"

@interface MSChuBaoVC ()
/// UI
@property(nonatomic,strong)BaseButton *aboutBtn;
@property(nonatomic,strong)MSChuBaoView1 *chuBaoView1;
@property(nonatomic,strong)MSChuBaoView2 *chuBaoView2;
@property(nonatomic,strong)MSChuBaoAdMarqueeView *marqueeView;
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;/// 跟随的指示器
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;/// 此属性决定依附于此的viewController
/// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewController *>*childVCMutArr;

@end

@implementation MSChuBaoVC

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    NSLog(@"%@",JobsLocalFunc);
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    
    self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
    self.viewModel.textModel.textCor = RGBA_COLOR(51, 51, 51, 1);
    self.viewModel.textModel.text = Internationalization(@"储宝");
    self.viewModel.textModel.font = UIFontWeightRegularSize(18);
    self.viewModel.bgCor = JobsCor(@"#F5F5F5");
    
    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JobsCor(@"#F5F5F5");
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.gk_navRightBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.aboutBtn];
    self.gk_navigationBar.jobsVisible = YES;
    
    self.chuBaoView1.alpha = 1;
    self.chuBaoView2.alpha = 1;
    self.marqueeView.alpha = 1;
    
    self.categoryView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateStatusBarCor:JobsCor(@"#F5F5F5")];/// 在具体子类实现，不要写在父类
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}
#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return self.titleMutArr.count;
}
/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}
#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
didClickSelectedItemAtIndex:(NSInteger)index {
     [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView
didScrollSelectedItemAtIndex:(NSInteger)index{}
//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
    NSLog(@"");
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}
#pragma mark —— lazyLoad
-(BaseButton *)aboutBtn{
    if (!_aboutBtn) {
        @jobs_weakify(self)
        _aboutBtn = [BaseButton.alloc jobsInitBtnByConfiguration:nil
                                                      background:nil
                                                  titleAlignment:UIButtonConfigurationTitleAlignmentAutomatic
                                                   textAlignment:NSTextAlignmentCenter
                                                subTextAlignment:NSTextAlignmentCenter
                                                     normalImage:nil
                                                  highlightImage:nil
                                                 attributedTitle:nil
                                         selectedAttributedTitle:nil
                                              attributedSubtitle:nil
                                                           title:Internationalization(@"关于储宝")
                                                        subTitle:nil
                                                       titleFont:UIFontWeightRegularSize(14)
                                                    subTitleFont:nil
                                                        titleCor:RGBA_COLOR(51, 51, 51, 1)
                                                     subTitleCor:nil
                                              titleLineBreakMode:NSLineBreakByWordWrapping
                                           subtitleLineBreakMode:NSLineBreakByWordWrapping
                                             baseBackgroundColor:UIColor.clearColor
                                                    imagePadding:JobsWidth(0)
                                                    titlePadding:JobsWidth(0)
                                                  imagePlacement:NSDirectionalRectEdgeNone
                                      contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter
                                        contentVerticalAlignment:UIControlContentVerticalAlignmentCenter
                                                   contentInsets:jobsSameDirectionalEdgeInsets(0)
                                               cornerRadiusValue:JobsWidth(0)
                                                 roundingCorners:UIRectCornerAllCorners
                                            roundingCornersRadii:CGSizeZero
                                                  layerBorderCor:nil
                                                     borderWidth:JobsWidth(0)
                                                   primaryAction:nil
                                                 clickEventBlock:^id(BaseButton *x) {
            @jobs_strongify(self)
            x.selected = !x.selected;
            if (self.objectBlock) self.objectBlock(x);
            [self forceComingToPushVC:MSAboutChuBaoVC.new requestParams:@""];
            return nil;
        }];
    }return _aboutBtn;
}

-(MSChuBaoView1 *)chuBaoView1{
    if(!_chuBaoView1){
        _chuBaoView1 = MSChuBaoView1.new;
        [self.view addSubview:_chuBaoView1];
        [_chuBaoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSChuBaoView1 viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.navigationBar.mas_bottom).offset(JobsWidth(5));
        }];
        [_chuBaoView1 richElementsInViewWithModel:nil];
        [_chuBaoView1 cornerCutToCircleWithCornerRadius:8];
    }return _chuBaoView1;
}

-(MSChuBaoView2 *)chuBaoView2{
    if(!_chuBaoView2){
        _chuBaoView2 = MSChuBaoView2.new;
        [self.view addSubview:_chuBaoView2];
        [_chuBaoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSChuBaoView2 viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.chuBaoView1.mas_bottom).offset(JobsWidth(5));
        }];
        [_chuBaoView2 richElementsInViewWithModel:nil];
        [_chuBaoView2 cornerCutToCircleWithCornerRadius:8];
    }return _chuBaoView2;
}

-(MSChuBaoAdMarqueeView *)marqueeView{
    if (!_marqueeView) {
        _marqueeView = [MSChuBaoAdMarqueeView.alloc initWithSize:[MSChuBaoAdMarqueeView viewSizeWithModel:nil]];
        [_marqueeView richElementsInViewWithModel:nil];
        [self.view addSubview:_marqueeView];
        [_marqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSChuBaoAdMarqueeView viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.chuBaoView2.mas_bottom).offset(JobsWidth(12));
        }];
        [_marqueeView cornerCutToCircleWithCornerRadius:JobsWidth(8)];
    }return _marqueeView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = JXCategoryTitleView.new;
        _categoryView.delegate = self;
        _categoryView.backgroundColor = JobsCor(@"#F5F5F5");
        _categoryView.titleSelectedColor = JobsCor(@"#333333");
        _categoryView.titleColor = JobsCor(@"#666666");
        _categoryView.titleFont = UIFontWeightRegularSize(14);
        _categoryView.titleSelectedFont = UIFontWeightBoldSize(16);
        _categoryView.titles = self.titleMutArr;
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollView = self.listContainerView.scrollView;// 关联cotentScrollView，关联之后才可以互相联动！！!
        _categoryView.indicators = @[self.lineView];
        _categoryView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        _categoryView.cellSpacing = JobsWidth(-20);
        [self.view addSubview:_categoryView];
        [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.marqueeView.mas_bottom).offset(0);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(listContainerViewDefaultOffset);
        }];
        [self.view layoutIfNeeded];
        NSLog(@"");
    }return _categoryView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorColor = JobsCor(@"#EA2918");
        _lineView.indicatorHeight = JobsWidth(4);
        _lineView.indicatorWidthIncrement = JobsWidth(10);
        _lineView.verticalMargin = 0;
    }return _lineView;
}
/// 此属性决定依附于此的viewController
-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [JXCategoryListContainerView.alloc initWithType:JXCategoryListContainerType_CollectionView
                                                                    delegate:self];
        _listContainerView.defaultSelectedIndex = 1;// 默认从第二个开始显示
        [self.view addSubview:_listContainerView];
        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
            make.top.equalTo(self.marqueeView.mas_bottom).offset(listContainerViewDefaultOffset);
            make.left.right.bottom.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
    }return _listContainerView;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [_childVCMutArr addObject:MSProdSelectVC.new];// 产品选购
        [_childVCMutArr addObject:MSTransactionRecordVC.new];// 交易记录
        [_childVCMutArr addObject:MSPromotionIncentiveVC.new];// 推广奖励
        [_childVCMutArr addObject:MSInterestSettleRecordVC.new];// 结息记录
    }return _childVCMutArr;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:Internationalization(@"产品选购")];
        [_titleMutArr addObject:Internationalization(@"交易记录")];
        [_titleMutArr addObject:Internationalization(@"推广奖励")];
        [_titleMutArr addObject:Internationalization(@"结息记录")];
    }return _titleMutArr;
}

@end

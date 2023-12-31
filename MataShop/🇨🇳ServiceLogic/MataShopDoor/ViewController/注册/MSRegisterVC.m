//
//  MSRegisterVC.m
//  MataShop
//
//  Created by Jobs Hi on 9/23/23.
//

#import "MSRegisterVC.h"

@interface MSRegisterVC ()
/// UI
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)BaseButton *titleBtn;
@property(nonatomic,strong)MSInputStyle2View *iPhInputView;
@property(nonatomic,strong)MSInputStyle1View *codeInputView;
@property(nonatomic,strong)MSInputStyle1View *codeVerifyInputView;
@property(nonatomic,strong)MSInputStyle3View *msgCodeInputView;
/// Data

@end

@implementation MSRegisterVC

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
    self.viewModel.bgCor = JobsClearColor;
    self.viewModel.textModel.textCor = JobsClearColor;
//    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
//    self.viewModel.textModel.text = Internationalization(@"消息详情页");
//    self.viewModel.textModel.font = UIFontWeightRegularSize(18);
    // 使用原则：底图有 + 底色有 = 优先使用底图数据
    // 以下2个属性的设置，涉及到的UI结论 请参阅父类（BaseViewController）的私有方法：-(void)setBackGround
    // self.viewModel.bgImage = JobsIMG(@"内部招聘导航栏背景图");/// self.gk_navBackgroundImage 和 self.bgImageView
//    self.viewModel.bgCor = RGBA_COLOR(255, 238, 221, 1);/// self.gk_navBackgroundColor 和 self.view.backgroundColor
//    self.viewModel.bgImage = JobsIMG(@"新首页的底图");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JobsCor(@"#FFFFFF");
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = YES;
    self.logoImageView.alpha = 1;
    self.titleBtn.alpha = 1;
    
    self.iPhInputView.alpha = 1;
    self.codeInputView.alpha = 1;
    self.codeVerifyInputView.alpha = 1;
    self.msgCodeInputView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
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
#pragma mark —— lazyLoad
-(UIImageView *)logoImageView{
    if(!_logoImageView){
        _logoImageView = UIImageView.new;
        /// 添加阴影效果
        _logoImageView.layer.shadowColor = UIColor.blackColor.CGColor; // 阴影颜色
        _logoImageView.layer.shadowOpacity = 0.5; // 阴影不透明度
        _logoImageView.layer.shadowRadius = 5.0; // 阴影半径
        _logoImageView.layer.shadowOffset = CGSizeMake(0, 4); // 阴影偏移量
        
        _logoImageView.image = JobsIMG(@"Logo");
        [self.view addSubview:_logoImageView];
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(100), JobsWidth(100)));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(JobsWidth(70));
        }];
    }return _logoImageView;
}

-(BaseButton *)titleBtn{
    if(!_titleBtn){
        @jobs_weakify(self)
        _titleBtn = [BaseButton.alloc jobsInitBtnByConfiguration:nil
                                                      background:nil
                                                  titleAlignment:UIButtonConfigurationTitleAlignmentAutomatic
                                                   textAlignment:NSTextAlignmentCenter
                                                subTextAlignment:NSTextAlignmentCenter
                                                     normalImage:nil
                                                  highlightImage:nil
                                                 attributedTitle:nil
                                         selectedAttributedTitle:nil
                                              attributedSubtitle:nil
                                                           title:Internationalization(@"欢迎来到Mata商城")
                                                        subTitle:Internationalization(@"登陆探索更多潮玩惊喜")
                                                       titleFont:UIFontWeightBoldSize(26)
                                                    subTitleFont:UIFontWeightRegularSize(16)
                                                        titleCor:JobsCor(@"#333333")
                                                     subTitleCor:JobsCor(@"#666666")
                                              titleLineBreakMode:NSLineBreakByWordWrapping
                                           subtitleLineBreakMode:NSLineBreakByWordWrapping
                                             baseBackgroundColor:UIColor.whiteColor
                                                    imagePadding:JobsWidth(0)
                                                    titlePadding:JobsWidth(8)
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
            return nil;
        }];
        [self.view addSubview:_titleBtn];
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_titleBtn.jobsSize);
            make.top.equalTo(self.logoImageView.mas_bottom).offset(JobsWidth(10));
            make.centerX.equalTo(self.view);
        }];
    }return _titleBtn;
}

-(MSInputStyle2View *)iPhInputView{
    if(!_iPhInputView){
        _iPhInputView = MSInputStyle2View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"手机号码登录");
        viewModel.textModel.text = Internationalization(@"                          请输入手机号");
        
        [_iPhInputView richElementsInViewWithModel:viewModel];
        [self.view addSubview:_iPhInputView];
        [_iPhInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSInputStyle2View viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.titleBtn.mas_bottom).offset(JobsWidth(76));
        }];
        [_iPhInputView cornerCutToCircleWithCornerRadius:[MSInputStyle1View viewSizeWithModel:nil].height / 2];
    }return _iPhInputView;
}

-(MSInputStyle1View *)codeInputView{
    if(!_codeInputView){
        _codeInputView = MSInputStyle1View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"登录密码");
        viewModel.textModel.text = Internationalization(@"              请输入登录密码");
        
        [_codeInputView richElementsInViewWithModel:viewModel];
        [self.view addSubview:_codeInputView];
        [_codeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSInputStyle1View viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.iPhInputView.mas_bottom).offset(JobsWidth(15));
        }];
        [_codeInputView cornerCutToCircleWithCornerRadius:[MSInputStyle1View viewSizeWithModel:nil].height / 2];
    }return _codeInputView;
}

-(MSInputStyle1View *)codeVerifyInputView{
    if(!_codeVerifyInputView){
        _codeVerifyInputView = MSInputStyle1View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"登录密码");
        viewModel.textModel.text = Internationalization(@"              请确认登录密码");
        
        [_codeVerifyInputView richElementsInViewWithModel:viewModel];
        [self.view addSubview:_codeVerifyInputView];
        [_codeVerifyInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSInputStyle3View viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.codeInputView.mas_bottom).offset(JobsWidth(15));
        }];
        [_codeVerifyInputView cornerCutToCircleWithCornerRadius:[MSInputStyle1View viewSizeWithModel:nil].height / 2];
    }return _codeVerifyInputView;
}

-(MSInputStyle3View *)msgCodeInputView{
    if(!_msgCodeInputView){
        _msgCodeInputView = MSInputStyle3View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"短信验证码登录");
        viewModel.textModel.text = Internationalization(@"              请输入手机短信验证码");
        
        [_msgCodeInputView richElementsInViewWithModel:viewModel];
        [self.view addSubview:_msgCodeInputView];
        [_msgCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSInputStyle3View viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.codeVerifyInputView.mas_bottom).offset(JobsWidth(15));
        }];
        [_msgCodeInputView cornerCutToCircleWithCornerRadius:[MSInputStyle1View viewSizeWithModel:nil].height / 2];
    }return _msgCodeInputView;
}

@end


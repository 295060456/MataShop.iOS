//
//  MSPasswordLoginVC.m
//  MataShop
//
//  Created by Jobs Hi on 9/22/23.
//

#import "MSPasswordLoginVC.h"

@interface MSPasswordLoginVC ()
/// UI
@property(nonatomic,strong)MSInputStyle1View *iPhInputView;
@property(nonatomic,strong)MSInputStyle1View *codeInputView;

@end

@implementation MSPasswordLoginVC

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JobsWhiteColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = NO;
    self.iPhInputView.alpha = 1;
    self.codeInputView.alpha = 1;
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
-(MSInputStyle1View *)iPhInputView{
    if(!_iPhInputView){
        _iPhInputView = MSInputStyle1View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"手机号码登录");
        viewModel.textModel.text = Internationalization(@"请输入手机号");
        
        [_iPhInputView richElementsInViewWithModel:viewModel];
        [self.view addSubview:_iPhInputView];
        [_iPhInputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([MSInputStyle1View viewSizeWithModel:nil]);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(JobsWidth(20));
        }];
        [_iPhInputView cornerCutToCircleWithCornerRadius:[MSInputStyle1View viewSizeWithModel:nil].height / 2];
    }return _iPhInputView;
}

-(MSInputStyle1View *)codeInputView{
    if(!_codeInputView){
        _codeInputView = MSInputStyle1View.new;
        
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.image = JobsIMG(@"登录密码");
        viewModel.textModel.text = Internationalization(@"密码");
        
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

@end

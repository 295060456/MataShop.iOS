//
//  MSProdSelectVC.m
//  MataShop
//
//  Created by Jobs Hi on 9/12/23.
//

#import "MSProdSelectVC.h"

@interface MSProdSelectVC ()

@end

@implementation MSProdSelectVC

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
    
//    self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
//    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
//    self.viewModel.textModel.font = UIFontWeightRegularSize(18);
//    self.viewModel.textModel.font = notoSansBold(16);
//
//    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JobsRandomColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = NO;
    [self.bgImageView removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
#pragma mark —— lazyLoad

@end

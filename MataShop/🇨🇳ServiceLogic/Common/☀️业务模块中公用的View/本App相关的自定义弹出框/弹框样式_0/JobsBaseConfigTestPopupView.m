//
//  JobsBaseConfigTestPopupView.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsBaseConfigTestPopupView.h"

@interface JobsBaseConfigTestPopupView ()

@property(nonatomic,strong)JobsUpDownLab *testPopupViewTitleLab;
@property(nonatomic,strong)UIButton *testPopupViewSureBtn;

@end

@implementation JobsBaseConfigTestPopupView

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_testPopupViewOnceToken = 0;
    static_popupView01 = nil;
}

static JobsBaseConfigTestPopupView *static_popupView01 = nil;
static dispatch_once_t static_testPopupViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_testPopupViewOnceToken, ^{
        static_popupView01 = JobsBaseConfigTestPopupView.new;
    });return static_popupView01;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.backgroundImageView.image = JobsIMG(@"测试弹窗的背景图");
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    self.testPopupViewTitleLab.alpha = 1;
    self.testPopupViewSureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(226));
}
#pragma mark —— lazyLoad
-(JobsUpDownLab *)testPopupViewTitleLab{
    if (!_testPopupViewTitleLab) {
        _testPopupViewTitleLab = JobsUpDownLab.new;
        [self addSubview:_testPopupViewTitleLab];
        [_testPopupViewTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(24));
            make.centerX.equalTo(self);
        }];
        
        {
            JobsUpDownLabModel *upDownLabModel = JobsUpDownLabModel.new;
            upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"测试弹窗"): self.viewModel.textModel.text;
            upDownLabModel.upLabTextAlignment = NSTextAlignmentCenter;
            upDownLabModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(20)
                                                weight:UIFontWeightBold];
            upDownLabModel.upLabTextCor = UIColor.blackColor;
            upDownLabModel.upLabBgCor = UIColor.clearColor;
            
            upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"相关信息"): self.viewModel.textModel.text;
            upDownLabModel.downLabTextAlignment = NSTextAlignmentCenter;
            upDownLabModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(16)
                                                  weight:UIFontWeightRegular];
            upDownLabModel.downLabTextCor = HEXCOLOR(0xB0B0B0);
            upDownLabModel.downLabBgCor = UIColor.clearColor;
            
            upDownLabModel.space = JobsWidth(12);
            
            upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
            upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
            upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
            upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
            
            [_testPopupViewTitleLab richElementsInViewWithModel:upDownLabModel];
        }
    }return _testPopupViewTitleLab;
}

-(UIButton *)testPopupViewSureBtn{
    if (!_testPopupViewSureBtn) {
        _testPopupViewSureBtn = UIButton.new;
        [_testPopupViewSureBtn handelAdjustsImageWhenHighlighted];
        _testPopupViewSureBtn.normalBackgroundImage = JobsIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.selectedBackgroundImage = JobsIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.normalTitle = Internationalization(@"确定");
        _testPopupViewSureBtn.normalTitleColor = JobsBlackColor;
        _testPopupViewSureBtn.titleFont = UIFontWeightRegularSize(18);
        [self addSubview:_testPopupViewSureBtn];
        [_testPopupViewSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-15));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(JobsWidth(190), JobsWidth(40)));
        }];
        @jobs_weakify(self)
        [_testPopupViewSureBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            NSLog(@"确定");
            x.selected = !x.selected;
            [self tf_hide];
            if(self.objectBlock) self.objectBlock(x);
        }];
    }return _testPopupViewSureBtn;
}

@end

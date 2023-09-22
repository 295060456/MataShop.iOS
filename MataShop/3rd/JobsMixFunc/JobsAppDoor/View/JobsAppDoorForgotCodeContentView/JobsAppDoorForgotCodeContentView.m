//
//  JobsAppDoorForgotCodeContentView.m
//  Casino
//
//  Created by Jobs on 2021/11/22.
//

#import "JobsAppDoorForgotCodeContentView.h"

@class JobsAppDoorDoorInputViewBaseStyle;

@interface JobsAppDoorForgotCodeContentView ()
// UI
@property(nonatomic,strong)UILabel *titleLab;// 标题
@property(nonatomic,strong)UIButton *backToLoginBtn;// 返回登录
@property(nonatomic,strong)UIButton *contactCustomerServiceBtn;// 联系客服按钮
@property(nonatomic,strong)UILabel *subTitleLab;// 副标题
@property(nonatomic,strong)JobsHotLabelWithSingleLine *hl;
// Data
//@property(nonatomic,strong)NSMutableArray <UIViewModel *>*hotLabelDataMutArr;

@end

@implementation JobsAppDoorForgotCodeContentView
#pragma mark - Lifecycle
- (void)dealloc {
    NSLog(@"%@",JobsLocalFunc);
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor2;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
#pragma mark —— BaseViewProtocol
/// 外层数据渲染
-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{
    @jobs_weakify(self)
}
#pragma mark —— 网络请求
/// 获取客服联系方式
-(void)customerContact:(jobsByIDBlock)block{

}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(Title10);
        _titleLab.textColor = JobsWhiteColor;
        _titleLab.font = UIFontWeightRegularSize(20);
        [_titleLab makeLabelByShowingType:UILabelShowingType_03];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.width - self.backToLoginBtn.width) / 2;
        _titleLab.top = JobsWidth(20);
    }return _titleLab;
}

-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = Cor1;
        _backToLoginBtn.titleLabel.font = UIFontWeightMediumSize(13);
        _backToLoginBtn.alpha = 0.7f;
        _backToLoginBtn.normalTitleColor = Cor3;
        _backToLoginBtn.normalTitle = Title1;
        _backToLoginBtn.normalImage = JobsIMG(@"用户名称");
        [_backToLoginBtn jobsBtnClickEventBlock:^(UIButton *x) {
            [self endEditing:YES];
            if (self.objectBlock) self.objectBlock(x);
        }];
        [self addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(btnWidth);
        }];
        [self layoutIfNeeded];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:JobsWidth(8)];
    }return _backToLoginBtn;
}

-(UIButton *)contactCustomerServiceBtn{
    if (!_contactCustomerServiceBtn) {
        _contactCustomerServiceBtn = UIButton.new;
        _contactCustomerServiceBtn.normalImage = JobsIMG(Internationalization(@"zaixiankefu_en"));
        @jobs_weakify(self)
        [_contactCustomerServiceBtn jobsBtnClickEventBlock:^(UIButton *x) {
            NSLog(@"返回登录");
            @jobs_strongify(self)
//            if ([NSString isNullString:self.customerContactModel.onlineUrl.customerAccount]) {
//                [self customerContact:nil];
//            }else{
//                [NSObject openURL:self.customerContactModel.onlineUrl.customerAccount];
//            }
            [self endEditing:YES];
            if (self.objectBlock) self.objectBlock(x);
        }];
        [self addSubview:_contactCustomerServiceBtn];
        [_contactCustomerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(230), JobsWidth(50)));
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(15));
            make.centerX.equalTo(self.titleLab);
        }];

    }return _contactCustomerServiceBtn;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = Internationalization(Title11);
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.textColor = JobsWhiteColor;
        _subTitleLab.font = UIFontWeightMediumSize(12);
        [_subTitleLab makeLabelByShowingType:UILabelShowingType_03];
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contactCustomerServiceBtn);
            make.top.equalTo(self.contactCustomerServiceBtn.mas_bottom).offset(JobsWidth(56));
            make.width.mas_equalTo(self.width - JobsWidth(80));
        }];
    }return _subTitleLab;
}

-(JobsHotLabelWithSingleLine *)hl{
    if (!_hl) {
        _hl = JobsHotLabelWithSingleLine.new;
        _hl.backgroundColor = JobsClearColor;
        _hl.labelShowingType = UILabelShowingType_02;
        _hl.elementDefaultSize = CGSizeMake(JobsWidth(46), JobsWidth(46));
        [self actionForHotLabel:_hl];
        [self addSubview:_hl];
        [_hl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.subTitleLab);
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(29));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(250), JobsWidth(50)));
        }];
        [self layoutIfNeeded];
        [_hl richElementsInViewWithModel:self.hotLabelDataMutArr];
    }return _hl;
}

@end


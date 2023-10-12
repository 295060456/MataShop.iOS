//
//  JobsAppDoorInputViewBaseStyle_7.m
//  Casino
//
//  Created by Jobs on 2021/11/24.
//

#import "JobsAppDoorInputViewBaseStyle_7.h"

@interface JobsAppDoorInputViewBaseStyle_7 ()
/// UI
@property(nonatomic,strong)JobsMagicTextField *textField;
@property(nonatomic,strong)UIImageView *leftIMGV;
@property(nonatomic,strong)JobsPageView *jobsPageView;
/// Data
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *doorInputViewBaseStyleModel;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*jobsPageViewDataMutArr;

@end

@implementation JobsAppDoorInputViewBaseStyle_7

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = JobsRedColor;
        [self layerBorderCor:Cor4 andBorderWidth:1];
    }return self;
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
        self.backgroundColor = JobsClearColor;
        [self layerBorderCor:Cor4 andBorderWidth:1];
    }return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— 一些私有方法
-(void)configTextField{
//    _textField.leftView;
//    _textField.leftViewMode;
    _textField.leftViewOffsetX = self.doorInputViewBaseStyleModel.leftViewOffsetX ? :  JobsWidth(17);
    _textField.placeholder = self.doorInputViewBaseStyleModel.placeHolderStr;
    _textField.placeholderColor = self.doorInputViewBaseStyleModel.placeholderColor;
    _textField.placeholderFont = self.doorInputViewBaseStyleModel.placeholderFont;
    _textField.placeHolderAlignment = self.doorInputViewBaseStyleModel.placeHolderAlignment ? : NSTextAlignmentLeft;
    _textField.placeHolderOffset = self.doorInputViewBaseStyleModel.placeHolderOffset ? : JobsWidth(20);
    _textField.keyboardType = self.doorInputViewBaseStyleModel.keyboardType;
    _textField.keyboardAppearance = self.doorInputViewBaseStyleModel.keyboardAppearance;
    _textField.returnKeyType = self.doorInputViewBaseStyleModel.returnKeyType;
    _textField.textColor = self.doorInputViewBaseStyleModel.titleStrCor;
    _textField.useCustomClearButton = self.doorInputViewBaseStyleModel.useCustomClearButton;
    _textField.isShowDelBtn = self.doorInputViewBaseStyleModel.isShowDelBtn;
    _textField.rightViewOffsetX = self.doorInputViewBaseStyleModel.rightViewOffsetX ? : JobsWidth(8);// 删除按钮的偏移量
    _textField.requestParams = self.textFieldInputModel;
    _textField.offset = self.doorInputViewBaseStyleModel.offset ? : JobsWidth(1);
    _textField.animationColor = self.doorInputViewBaseStyleModel.animationColor ? : Cor4;
    _textField.moveDistance = self.doorInputViewBaseStyleModel.moveDistance ? : JobsWidth(35);
    _textField.fieldEditorOffset = self.doorInputViewBaseStyleModel.fieldEditorOffset ? : JobsWidth(50);
}

-(void)textFieldBlock:(JobsMagicTextField *)textField
       textFieldValue:(NSString *)value{
    
    self.textFieldInputModel.resString = value;
    self.textFieldInputModel.PlaceHolder = self.doorInputViewBaseStyleModel.placeHolderStr;

    textField.requestParams = self.textFieldInputModel;
    
    if (self.objectBlock) self.objectBlock(textField);// 对外统一传出TF
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsWidth(345), JobsWidth(30));
}

-(void)richElementsInViewWithModel:(JobsAppDoorInputViewBaseStyleModel *_Nullable)doorInputViewBaseStyleModel{
    self.doorInputViewBaseStyleModel = doorInputViewBaseStyleModel ? : JobsAppDoorInputViewBaseStyleModel.new;
    self.leftIMGV.alpha = 1;
    self.jobsPageView.alpha = 1;
    self.textField.alpha = 1;
    [self configTextField];
}
#pragma mark —— JobsDoorInputViewProtocol
-(void)changeTextFieldAnimationColor:(BOOL)toRegisterBtnSelected{
    self.textField.animationColor = toRegisterBtnSelected ? Cor4 : Cor4;
}

-(JobsMagicTextField *_Nullable)getTextField{
    return _textField;
}

-(NSString *_Nullable)getTextFieldValue{
    return _textField.text;
}
#pragma mark —— lazyLoad
-(UIImageView *)leftIMGV{
    if (!_leftIMGV) {
        _leftIMGV = UIImageView.new;
        _leftIMGV.image = self.doorInputViewBaseStyleModel.leftViewIMG;
        [self addSubview:_leftIMGV];
        [_leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(JobsWidth(17));
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(JobsWidth(12), JobsWidth(16)));
        }];
    }return _leftIMGV;
}

-(NSMutableArray<UIViewModel *> *)jobsPageViewDataMutArr{
    if (!_jobsPageViewDataMutArr) {
        _jobsPageViewDataMutArr = NSMutableArray.array;
        
        {
            UIViewModel *jobsPageViewModel = UIViewModel.new;
            jobsPageViewModel.textModel.text = Internationalization(@"請選擇區號");
            jobsPageViewModel.textModel.textCor = HEXCOLOR(0xC4C4C4);
            jobsPageViewModel.bgCor = JobsClearColor;
            jobsPageViewModel.textModel.font = UIFontWeightRegularSize(16);
            [_jobsPageViewDataMutArr addObject:jobsPageViewModel];
        }
        
        {
            UIViewModel *jobsPageViewModel = UIViewModel.new;
            jobsPageViewModel.textModel.text = @"+87";
            jobsPageViewModel.textModel.textCor = HEXCOLOR(0xC4C4C4);
            jobsPageViewModel.bgCor = JobsClearColor;
            jobsPageViewModel.textModel.font = UIFontWeightRegularSize(16);
            [_jobsPageViewDataMutArr addObject:jobsPageViewModel];
        }
        
        {
            UIViewModel *jobsPageViewModel = UIViewModel.new;
            jobsPageViewModel.textModel.text = @"+88";
            jobsPageViewModel.textModel.textCor = HEXCOLOR(0xC4C4C4);
            jobsPageViewModel.bgCor = JobsClearColor;
            jobsPageViewModel.textModel.font = UIFontWeightRegularSize(16);
            [_jobsPageViewDataMutArr addObject:jobsPageViewModel];
        }
        
    }return _jobsPageViewDataMutArr;
}

-(JobsPageView *)jobsPageView{
    if (!_jobsPageView) {
        _jobsPageView = JobsPageView.new;
        _jobsPageView.backgroundColor = JobsClearColor;
        [_jobsPageView richElementsInViewWithModel:self.jobsPageViewDataMutArr];
        [self addSubview:_jobsPageView];
        [_jobsPageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftIMGV.mas_right).offset(JobsWidth(20));
            make.centerY.equalTo(self);
            make.height.mas_equalTo(JobsWidth(16));
            make.width.mas_equalTo([UIView widthByData:self.jobsPageViewDataMutArr[0]]);
        }];
    }return _jobsPageView;
}

-(JobsMagicTextField *)textField{
    if (!_textField) {
        _textField = JobsMagicTextField.new;
        _textField.delegate = self;
        @jobs_weakify(self)
        [_textField jobsTextFieldEventFilterBlock:^BOOL(NSString * _Nullable value) {
            @jobs_strongify(self)
            JobsAppDoorInputViewTFModel *textFieldInputModel = (JobsAppDoorInputViewTFModel *)self.textField.requestParams;
            if ([textFieldInputModel.PlaceHolder isEqualToString:Internationalization(@"Telephone")]) {// 手机号码
                if ([self checkTelNum:value]) {
                    return YES;
                }else{
                    if (![self telNotUpTo:value]) {
                        self.textField.text = [value substringWithRange:NSMakeRange(0, value.length - 1)];
                    }return NO;
                }
            }return NO;
        } subscribeNextBlock:^(NSString * _Nullable x) {
            @jobs_strongify(self)
            NSLog(@"输入的字符为 = %@",x);
            [self textFieldBlock:self.textField
                  textFieldValue:x];
        }];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-JobsWidth(17));
            make.left.equalTo(self.jobsPageView.mas_right).offset(JobsWidth(2));
        }];
    }return _textField;
}

@end

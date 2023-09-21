//
//  JobsUpDownLab.m
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "JobsUpDownLab.h"

@interface JobsUpDownLab (){
    CGFloat leftTextHeight;
    CGFloat rightTextHeight;
}
// UI
@property(nonatomic,strong)UIButton *upBtn;// 用Button的目的是可以兼容承接图片
@property(nonatomic,strong)UIButton *downBtn;// 用Button的目的是可以兼容承接图片
// Data
@property(nonatomic,strong)JobsUpDownLabModel *upDownLabModel;

@end

@implementation JobsUpDownLab

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    
    [_upBtn removeFromSuperview];
    _upBtn = nil;
    
    [_downBtn removeFromSuperview];
    _downBtn = nil;
    
    self.upDownLabModel = model;
    if (self.upDownLabModel) {
        /// 计算高度
        [self textHeight];
        
        self.upBtn.normalTitle = self.upDownLabModel.upLabText;
        if (self.upDownLabModel.isUpLabMultiLineShows) {/// 单行ByWidth  多行ByFont
            [self.upBtn makeBtnLabelByShowingType:UILabelShowingType_05];
        }else{
            [self.upBtn buttonAutoFontByWidth];
        }
        
        self.downBtn.normalTitle = self.upDownLabModel.downLabText;
        if (self.upDownLabModel.isDownLabMultiLineShows) {/// 单行ByWidth  多行ByFont
            [self.downBtn makeBtnLabelByShowingType:UILabelShowingType_05];
        }else{
            [self.downBtn buttonAutoFontByWidth];
        }
    }
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
#pragma mark —— 计算高
    CGFloat upLabTextHeight = 0.f;
    /// 如果没有自定义的宽，那么就按照单行处理
    if(model.upLabWidth){
        upLabTextHeight = [model.upLabText jobsTextHeightWithFont:model.upLabFont
                                                       lineHeight:0
                                                     controlWidth:model.upLabWidth].textHeight;
    }else{
        /// 单行
        upLabTextHeight = model.upLabFont.lineHeight;
    }
    
    CGFloat downLabTextHeight = 0.f;
    /// 如果没有自定义的宽，那么就按照单行处理
    if(model.downLabWidth){
        downLabTextHeight = [model.downLabText jobsTextHeightWithFont:model.downLabFont
                                                           lineHeight:0
                                                         controlWidth:model.downLabWidth].textHeight;
    }else{
        /// 单行
        downLabTextHeight = model.downLabFont.lineHeight;
    }
    
    CGFloat height1 = upLabTextHeight + downLabTextHeight + model.space;/// 计算值
    CGFloat height2 = model.upLabHeight + model.downLabHeight + model.space;/// 自己定义的值

#pragma mark —— 计算宽
    CGFloat upLabTextWidth = 0.f;
    if(model.upLabNumberOfLines){//
        
    }
    

    
    CGFloat width1 ;/// 计算值
    CGFloat width2 = model.upLabWidth + model.downLabWidth + model.space;/// 自己定义的值
    
    return CGSizeMake(MAX(width1, width2), MAX(height1, height2));
    
    /// 只是想得出：这个文本的Size
    
//    CGFloat textHeight = [model.upLabText sizeWithAttributes:@{NSFontAttributeName: model.upLabFont}].height;
    
//    CGFloat w = [model.upLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
//                                                                calcLabelHeight_Width:CalcLabelWidth
//                                                                                 font:model.upLabFont
//                                                         boundingRectWithHeight_Width:(textHeight + model.space)];
//    return CGSizeMake(w,
//                      textHeight + model.space);
}
#pragma mark —— 一些私有方法
/// 根据字符串以及其对应的行宽（行高）、行高和字体字号，计算该文本占用的高度（宽度）
-(void)textHeight{
//    leftTextHeight = [self.upDownLabModel.upLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
//                                                                                   calcLabelHeight_Width:CalcLabelHeight
//                                                                                                    font:self.upDownLabModel.upLabFont
//                                                                            boundingRectWithHeight_Width:[JobsUpDownLab viewSizeWithModel:nil].width];
//    
//    rightTextHeight = [self.upDownLabModel.downLabText getContentHeightOrWidthWithParagraphStyleLineSpacing:0
//                                                                                      calcLabelHeight_Width:CalcLabelHeight
//                                                                                                       font:self.upDownLabModel.downLabFont
//                                                                               boundingRectWithHeight_Width:[JobsUpDownLab viewSizeWithModel:nil].width];
//    
//    leftTextHeight = self.upDownLabModel.rate == 0.5 ? leftTextHeight : [JobsUpDownLab viewSizeWithModel:nil].height * self.upDownLabModel.rate;
//    rightTextHeight = self.upDownLabModel.rate == 0.5 ? rightTextHeight : [JobsUpDownLab viewSizeWithModel:nil].height * (1 - self.upDownLabModel.rate);
//    NSLog(@"");
}
#pragma mark —— 一些公有方法
-(UIButton *)getUpBtn{
    return _upBtn;
}

-(UIButton *)getDownBtn{
    return _downBtn;
}
#pragma mark —— lazyLoad
-(UIButton *)upBtn{
    if (!_upBtn) {
        _upBtn = UIButton.new;
        
    
        
        if (self.upDownLabModel.upLabAttributedText) {
            _upBtn.normalAttributedTitle = self.upDownLabModel.upLabAttributedText;
        }else{
            _upBtn.titleLabel.textAlignment = self.upDownLabModel.upLabTextAlignment;
            _upBtn.titleFont = self.upDownLabModel.upLabFont;
            _upBtn.normalTitle = self.upDownLabModel.upLabText;
            _upBtn.normalTitleColor = self.upDownLabModel.upLabTextCor;
        }
        
        switch (self.upDownLabModel.downLabTextAlignment) {
            case NSTextAlignmentLeft:{
                _upBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            }break;
            case NSTextAlignmentCenter:{
                _upBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            }break;
            case NSTextAlignmentRight:{
                _upBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            }break;
                
            default:
                break;
        }
        _upBtn.normalImage = self.upDownLabModel.upLabImage;
        _upBtn.normalBackgroundImage = self.upDownLabModel.upLabBgImage;
        _upBtn.backgroundColor = self.upDownLabModel.upLabBgCor;
        
        [self addSubview:_upBtn];
        [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!self.upDownLabModel.isDownLabMultiLineShows) {
                /// 单行显示定高
                make.height.mas_equalTo(leftTextHeight);
            }
            /// 水平方向
            switch (self.upDownLabModel.upLabLevelAlign) {
                case JobsUpDownLabAlign_TopLeft:{
                    make.left.equalTo(self);
                }break;
                case JobsUpDownLabAlign_MiddleLine:{
                    make.centerX.width.equalTo(self);
                }break;
                case JobsUpDownLabAlign_BottomRight:{
                    make.right.equalTo(self);
                }break;
                default:
                    break;
            }
            /// 垂直方向
            switch (self.upDownLabModel.upLabVerticalAlign) {
                case JobsUpDownLabAlign_TopLeft:{
                    make.top.equalTo(self);
                }break;
                case JobsUpDownLabAlign_MiddleLine:{//
                    make.bottom.equalTo(self.mas_centerY);
                }break;
                case JobsUpDownLabAlign_BottomRight:{
                    make.bottom.equalTo(self.downBtn.mas_top).offset(-self.upDownLabModel.space / 2);
                }break;
                default:
                    break;
            }
        }];
    }return _upBtn;
}

-(UIButton *)downBtn{
    if (!_downBtn) {
        _downBtn = UIButton.new;
        
        if (self.upDownLabModel.downLabAttributedText) {
            _downBtn.normalAttributedTitle = self.upDownLabModel.downLabAttributedText;
        }else{
            _downBtn.titleLabel.textAlignment = self.upDownLabModel.downLabTextAlignment;
            _downBtn.titleFont = self.upDownLabModel.downLabFont;
            _downBtn.normalTitle = self.upDownLabModel.downLabText;
            _downBtn.normalTitleColor = self.upDownLabModel.downLabTextCor;
        }
        
        switch (self.upDownLabModel.downLabTextAlignment) {
            case NSTextAlignmentLeft:{
                _downBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            }break;
            case NSTextAlignmentCenter:{
                _downBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            }break;
            case NSTextAlignmentRight:{
                _downBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            }break;
                
            default:
                break;
        }
        
        _downBtn.normalImage = self.upDownLabModel.downLabImage;
        _downBtn.normalBackgroundImage = self.upDownLabModel.downLabBgImage;
        _downBtn.backgroundColor = self.upDownLabModel.downLabBgCor;
    
        [self addSubview:_downBtn];
        [_downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!self.upDownLabModel.isDownLabMultiLineShows) {
                /// 单行显示定高
                make.height.mas_equalTo(rightTextHeight);
            }
            /// 水平方向
            switch (self.upDownLabModel.downLabLevelAlign) {
                case JobsUpDownLabAlign_TopLeft:{
                    make.left.equalTo(self);
                }break;
                case JobsUpDownLabAlign_MiddleLine:{
                    make.centerX.width.equalTo(self);
                }break;
                case JobsUpDownLabAlign_BottomRight:{
                    make.right.equalTo(self);
                }break;
                default:
                    break;
            }
            /// 垂直方向
            switch (self.upDownLabModel.downLabVerticalAlign) {
                case JobsUpDownLabAlign_TopLeft:{
                    make.top.equalTo(self.upBtn.mas_bottom).offset(self.upDownLabModel.space);
                }break;
                case JobsUpDownLabAlign_MiddleLine:{
                    make.top.equalTo(self.mas_centerY);
                }break;
                case JobsUpDownLabAlign_BottomRight:{
                    make.bottom.equalTo(self);
                }break;
                default:
                    break;
            }
        }];
    }return _downBtn;
}

@end

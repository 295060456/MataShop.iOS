//
//  JobsHotLabelWithMultiLineCollectionReusableView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/25.
//

#import "JobsHotLabelWithMultiLineHeaderFooterView.h"

@interface JobsHotLabelWithMultiLineHeaderFooterView ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)BaseButton *subTitleBtn;

@end

@implementation JobsHotLabelWithMultiLineHeaderFooterView

@synthesize viewModel = _viewModel;

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}
#pragma mark —— BaseViewProtocol
/// 由具体的子类进行覆写
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeZero;
}
/// 由具体的子类进行覆写
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    self.backgroundColor = self.viewModel.bgCor;
    self.titleLab.alpha = 1;
    self.subTitleBtn.alpha = 1;
}
#pragma mark —— 一些公共方法
-(UILabel *)getTitleLab{
    return self.titleLab;
}

-(BaseButton *)getSubTitleBtn{
    return self.subTitleBtn;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.viewModel.textModel.offsetXForEach);
            make.top.bottom.equalTo(self);
        }];
    }
    
    if (self.viewModel.textModel.attributedText) {
        _titleLab.attributedText = self.viewModel.textModel.attributedText;
    }else{
        _titleLab.text = self.viewModel.textModel.text;
        _titleLab.font = self.viewModel.textModel.font;
        _titleLab.textColor = self.viewModel.textModel.textCor;
        _titleLab.textAlignment = self.viewModel.textModel.textAlignment;
        [_titleLab makeLabelByShowingType:self.viewModel.textModel.labelShowingType];/// 一行显示。不定宽、定高、定字体。宽度自适应 【单行：ByFont】
    }return _titleLab;
}

-(BaseButton *)subTitleBtn{
    if (!_subTitleBtn) {
        _subTitleBtn = BaseButton.new;
        [self addSubview:_subTitleBtn];
        [_subTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(self.viewModel.subTextModel.offsetXForEach);
            make.top.bottom.equalTo(self);
        }];
    }
    
    _subTitleBtn.normalImage = self.viewModel.image;
    _subTitleBtn.normalBackgroundImage = self.viewModel.bgImage;
    _subTitleBtn.normalTitle = self.viewModel.subTextModel.text;
    _subTitleBtn.normalTitleColor = self.viewModel.subTextModel.textCor;
    _subTitleBtn.normalAttributedTitle = self.viewModel.subTextModel.attributedText;
    
    _subTitleBtn.selectedImage = self.viewModel.selectedImage;
    _subTitleBtn.selectedBackgroundImage = self.viewModel.bgSelectedImage;
    _subTitleBtn.selectedTitle = self.viewModel.subTextModel.text;
    _subTitleBtn.selectedTitleColor = self.viewModel.subTextModel.textCor;
    _subTitleBtn.selectedAttributedTitle = self.viewModel.subTextModel.attributedText;
    
    _subTitleBtn.titleFont = self.viewModel.subTextModel.font;
    _subTitleBtn.titleAlignment = self.viewModel.subTextModel.textAlignment;
    _subTitleBtn.lineBreakMode = self.viewModel.subTextModel.lineBreakMode;
    
    [_subTitleBtn makeBtnLabelByShowingType:self.viewModel.labelShowingType];
    [_subTitleBtn layoutButtonWithEdgeInsetsStyle:self.viewModel.buttonEdgeInsetsStyle
                                  imageTitleSpace:self.viewModel.imageTitleSpace];
    return _subTitleBtn;
}

@end

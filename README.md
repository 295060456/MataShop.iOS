# Mata商城iOS原生版本
## 一些潜在的Bug

<details id="iOS 归档 UIImage类型 失败">
 <summary><strong>iOS 归档 UIImage类型 失败</strong></summary>

```objective-c
我想用归档来存放用户数据Model，但是归档 UIImage类型 失败。目前没有找到破解办法
```
</details>

<details id="WMZBannerView">
 <summary><strong>WMZBannerView</strong></summary>

```objective-c
WMZBannerView 完全停止更新，且文字过长会出现问题。跑马灯功能需要另辟蹊径
```
</details>

<details id="iPhone 15">
 <summary><strong>iPhone 15</strong></summary>

```objective-c
iPhone 15全系列机型因为才上市，暂时还没有拿到最新的机型屏幕数据以及Identifier

应持续关注：
https://www.theiphonewiki.com/wiki/Models
对 UIDevice+XMUtils.h 和 MacroDef_Size.h 进行更新
```
</details>

## 几点重要说明

<details id="iOS Xcode 代码块">
 <summary><strong>iOS Xcode 代码块</strong></summary>

* 要想快，用快捷键调取代码块。集成方式：

```javascript
https://github.com/JobsKit/JobsCodeSnippets
```
</details>

<details id="UIButton">
 <summary><strong>UIButton</strong></summary>

* 兼容新Api，如果还是按照以前的方式创建，你会发现UIButton不正常出现（请看下面的示例代码）
```javascript
苹果在后续的Api中推出了 UIButtonConfiguration 来设置UIButton，但是这个新Api会存在几大问题
1、大多数开发者对这个Api不熟悉
2、用了新Api以后，老的Api的一些调用方式可能不会起效果
3、大多数时候，我们会涉及到富文本。而富文本和普通的文本之间对于控件有优先级。富文本的优先级最高
4、因为要做兼容处理，但是 UIButtonConfiguration 的设置环节非常繁琐

所以，为了应对以上的问题，可以快捷键（init.JobsBtn）调代码块来设置 UIButton
得出的 UIButton 是没有约束的，需要自己在外界加
具体的内部实现，请关注@implementation UIButton (UI)
资料来源：
Chat GPT 3.5 
https://www.jianshu.com/p/12426709420e
```
</details>

<details id="其他">
 <summary><strong>其他</strong></summary>

* 用 JobsDefineAllEnumHeader.h 管理全局的结构体定义

```
App内所有的结构体定义，都写在 JobsDefineAllEnumHeader.h 文件里面进行统一的全局管理。不要单独的写在某个文件里面
```
</details>

<details id="示例代码">
 <summary><strong>示例代码</strong></summary>

* Masonry约束动画
```objective-c
-(MSMineView2 *)view2{
    if(!_view2){
        _view2 = MSMineView2.new;
        [_view2 richElementsInViewWithModel:nil];
        [self addSubview:_view2];
        [_view2 jobsMasonryBeforeBlock:^(MASConstraintMaker * _Nonnull make) {
            // 添加第一个 _view2 的约束
            make.width.mas_equalTo(0);
            make.height.mas_equalTo([MSMineView2 viewSizeWithModel:nil].height);
            make.right.equalTo(self).offset(JobsWidth(-10));
            make.top.equalTo(self).offset(JobsWidth(10));
        }
                     masonryAfterBlock:^(MASConstraintMaker * _Nonnull make) {
            // 添加第二个 _view2 的约束
            make.size.mas_equalTo([MSMineView2 viewSizeWithModel:nil]);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(JobsWidth(10));
        }];
        [_view2 cornerCutToCircleWithCornerRadius:[MSMineView2 viewSizeWithModel:nil].height / 2];
    }return _view2;
}
```
* 用新Api创建一个带富文本的UIButton
```objective-c
@property(nonatomic,strong)BaseButton *titleBtn;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextMutArr;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richTextConfigMutArr;
 
 -(BaseButton *)titleBtn{
     if(!_titleBtn){
         @jobs_weakify(self)
         _titleBtn = [BaseButton.alloc jobsInitBtnByConfiguration:nil
                                                        background:nil
                                                    titleAlignment:UIButtonConfigurationTitleAlignmentCenter
                                                     textAlignment:NSTextAlignmentCenter
                                                  subTextAlignment:NSTextAlignmentCenter
                                                       normalImage:nil
                                                    highlightImage:nil
                                                   attributedTitle:nil
                                           selectedAttributedTitle:nil
                                                attributedSubtitle:[self richTextWithDataConfigMutArr:self.richTextConfigMutArr]
                                                             title:Internationalization(@"请支付")
                                                          subTitle:nil//Internationalization(@"观看完整教学视频需支付99Mata值")
                                                         titleFont:UIFontWeightBoldSize(18)
                                                      subTitleFont:nil
                                                          titleCor:JobsCor(@"#333333")
                                                       subTitleCor:nil
                                                titleLineBreakMode:NSLineBreakByWordWrapping
                                             subtitleLineBreakMode:NSLineBreakByWordWrapping
                                               baseBackgroundColor:UIColor.whiteColor
                                                      imagePadding:JobsWidth(0)
                                                      titlePadding:JobsWidth(10)
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
         [self addSubview:_titleBtn];
         [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(JobsWidth(72));
             make.top.equalTo(self).offset(JobsWidth(20));
             make.centerX.equalTo(self);
         }];
         [_titleBtn makeBtnLabelByShowingType:UILabelShowingType_03];
     }return _titleBtn;
 }

 -(NSMutableArray<NSString *> *)richTextMutArr{
     if (!_richTextMutArr) {
         _richTextMutArr = NSMutableArray.array;
         [_richTextMutArr addObject:Internationalization(@"观看完整教学视频需支付")];
         [_richTextMutArr addObject:Internationalization(@"99")];
         [_richTextMutArr addObject:Internationalization(@"Mata值")];
     }return _richTextMutArr;
 }

 -(NSMutableArray<RichTextConfig *> *)richTextConfigMutArr{
     if (!_richTextConfigMutArr) {
         _richTextConfigMutArr = NSMutableArray.array;
         {
             RichTextConfig *config_01 = RichTextConfig.new;
             config_01.font = UIFontWeightRegularSize(14);
             config_01.textCor = JobsCor(@"#666666");
             config_01.targetString = self.richTextMutArr[0];
             config_01.paragraphStyle = self.jobsParagraphStyleCenter;
             [_richTextConfigMutArr addObject:config_01];
         }
         
         {
             RichTextConfig *config_02 = RichTextConfig.new;
             config_02.font = UIFontWeightRegularSize(14);
             config_02.textCor = JobsCor(@"#BA9B77");
             config_02.targetString = self.richTextMutArr[1];
             config_02.paragraphStyle = self.jobsParagraphStyleCenter;
             [_richTextConfigMutArr addObject:config_02];
         }
         
         {
             RichTextConfig *config_03 = RichTextConfig.new;
             config_03.font = UIFontWeightRegularSize(14);
             config_03.textCor = JobsCor(@"#666666");
             config_03.targetString = self.richTextMutArr[2];
             config_03.paragraphStyle = self.jobsParagraphStyleCenter;
             [_richTextConfigMutArr addObject:config_03];
         }
     }return _richTextConfigMutArr;
 }
```
</details>

## 打开苹果的反馈助理

* 浏览器打开并输入 
```javascript
applefeedback://
```

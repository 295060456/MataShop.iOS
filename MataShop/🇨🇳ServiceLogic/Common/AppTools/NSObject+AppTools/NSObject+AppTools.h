//
//  NSObject+AppTools.h
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import <Foundation/Foundation.h>

#import "AppToolsProtocol.h"
#import "NSObject+UserInfo.h"
#import "NSObject+Extras.h"
#import "UIView+Extras.h"

#import "AppDelegate.h"
#import "JobsAppDoorVC.h"
#import "AppInternationalizationVC.h"
//#import "CasinoUpgradePopupView.h"
#import "JobsHotLabelWithSingleLine.h"

#import "DDNetworkingHeader.h"
#import "UIViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)
<
AppToolsProtocol
,UITextViewDelegate
>
/// UI
@property(nonatomic,strong)UIButton *联系客服;
@property(nonatomic,strong)UIButton *立即注册;
@property(nonatomic,strong)UILabel *separateLab;/// 分割线
@property(nonatomic,strong)UITextView *connectionTipsTV;/// 承接富文本:如需幫助，請聯繫專屬客服
/// Data
@property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;
@property(nonatomic,strong)NSMutableArray<NSString *> *jxCategoryViewTitleMutArr;
// 关于富文本:如需幫助，請聯繫專屬客服
@property(nonatomic,strong)NSMutableAttributedString *attributedStringData;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextMutArr;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richTextConfigMutArr;
#pragma mark —— 弹出框。为了防止业务层的变化，弹出框定义在NSObject层
/// Debug模式下的弹出框 及其相关的数据封装。在外层进行调用，[ 需要被展现的视图 popupShowScaleWithView:popupView];
//-(JobsBaseConfigTestPopupView *)JobsTestPopView:(NSString *)string;
/// 在外层进行调用，[ 需要被展现的视图 popupShowScaleWithView:popupView];
//-(JobsBaseConfigTestPopupView *)jobsTestPopView:(UIViewModel *_Nullable)viewModel;
/// 测试和业务密切相关的弹窗 ：在外层进行调用，[ 需要被展现的视图 popupShowScaleWithView:popupView];
/// @param popViewClass 被测试的弹窗视图
/// @param viewModel 此视图所绑定的数据。传nil则使用testPopViewData的数据、传UIViewModel.new则使用popViewClass预埋的数据
-(UIView<BaseViewProtocol> *)jobsPopView:(Class<BaseViewProtocol> _Nullable)popViewClass
                               viewModel:(UIViewModel *_Nullable)viewModel;
#pragma mark —— 网络通讯方面的
/// 获取客服联系方式
-(void)getCustomerContact:(jobsByIDBlock _Nullable)block;
/// 银行列表
-(void)getBankcardBanklist:(jobsByIDBlock _Nullable)block;
/// 获取文件服务器地址
-(void)getDownloadStationGetFileServerUrl:(jobsByIDBlock _Nullable)block;
/// 检查平台维护开关
-(void)checkPlatformMaintenanceSwitch:(jobsByIDBlock _Nullable)block;
/// 获取当前用户的基本信息(不包含 余额，打码量，可提现金额,洗码金额)
-(void)getUserInfo:(jobsByIDBlock _Nullable)block;
/// 检查人人代开关
-(void)getPlatformConfigCheckPeopleProxySwitch:(jobsByIDBlock _Nullable)block;
/// 获取当前用户的余额,打码量,可提现金额,洗码金额,分润金额
-(void)getUserGetMoney:(jobsByIDBlock _Nullable)successBlock
          failureBlock:(jobsByIDBlock _Nullable)failureBlock;
/// 查询当前登录用户WM余额
-(void)getWmGetWmBalance:(jobsByIDBlock _Nullable)successBlock
            failureBlock:(jobsByIDBlock _Nullable)failureBlock;
/// iOS最新版本检查
-(void)getDownloadStationGetIosNewestVersion:(jobsByIDBlock _Nullable)block;
/// 公告/活动
-(void)getNoticeNewest:(jobsByIDBlock _Nullable)block;
/// 获取移动端logo
-(void)getDownloadStationGetLogImageUrlApp:(jobsByIDBlock _Nullable)block;
/// 获取用户已绑定银行卡
-(void)withdrawBanklist:(jobsByIDBlock)block;

@end

NS_ASSUME_NONNULL_END

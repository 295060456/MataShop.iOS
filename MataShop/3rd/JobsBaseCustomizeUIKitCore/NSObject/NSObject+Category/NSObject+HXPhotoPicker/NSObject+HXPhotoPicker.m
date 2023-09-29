//
//  NSObject+HXPhotoPicker.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/20.
//

#import "NSObject+HXPhotoPicker.h"

@implementation HXPhotoPickerModel

@end

@implementation NSObject (HXPhotoPicker)

/// 弹出系统相册选择页面
-(void)invokeSysPhotoAlbumSuccessBlock:(jobsByIDBlock _Nullable)successBlock
                             failBlock:(jobsByIDBlock _Nullable)failBlock{
    /// 请求相册权限
//    @jobs_weakify(self)
    [ECPrivacyCheckGatherTool requestPhotosAuthorizationWithCompletionHandler:^(BOOL granted) {
        if (granted) {
            if ([self isKindOfClass:UIViewController.class]) {
                UIViewController *viewController = (UIViewController *)self;
                [viewController hx_presentSelectPhotoControllerWithManager:self.photoManager
                                                                   didDone:^(NSArray<HXPhotoModel *> *allList,
                                                                             NSArray<HXPhotoModel *> *photoList,
                                                                             NSArray<HXPhotoModel *> *videoList,
                                                                             BOOL isOriginal,
                                                                             UIViewController *viewController,
                                                                             HXPhotoManager *manager) {
//                    @jobs_strongify(self)
                    HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                    photoPickerModel.allList = allList;
                    photoPickerModel.photoList = photoList;
                    photoPickerModel.videoList = videoList;
                    photoPickerModel.isOriginal = isOriginal;
                    photoPickerModel.vc = viewController;
                    photoPickerModel.photoManager = manager;
                    if (successBlock) successBlock(photoPickerModel);
                } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
//                    @jobs_strongify(self)
                    HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                    photoPickerModel.vc = viewController;
                    photoPickerModel.photoManager = manager;
                    if (failBlock) failBlock(photoPickerModel);
                }];
            }
        }else{
            [WHToast toastMsg:@"保存图片需要过去您的相册权限,请前往设置打开"];
        }
    }];
}
/// 调取系统相机进行拍摄
-(void)invokeSysCameraSuccessBlock:(jobsByIDBlock _Nullable)successBlock
                         failBlock:(jobsByIDBlock _Nullable)failBlock{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        /// 请求相机📷权限
//        @jobs_weakify(self)
        [ECPrivacyCheckGatherTool requestCameraAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                if ([self isKindOfClass:UIViewController.class]) {
                    UIViewController *viewController = (UIViewController *)self;
                    [viewController hx_presentCustomCameraViewControllerWithManager:self.photoManager
                                                                               done:^(HXPhotoModel *model,
                                                                                      HXCustomCameraViewController *viewController) {
//                        @jobs_strongify(self)
                        HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                        photoPickerModel.customCameraVC = viewController;
                        photoPickerModel.photoModel = model;
                        if (successBlock) successBlock(photoPickerModel);
                    } cancel:^(HXCustomCameraViewController *viewController) {
                        NSSLog(@"取消了");
//                        @jobs_strongify(self)
                        HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                        photoPickerModel.customCameraVC = viewController;
                        if (failBlock) failBlock(photoPickerModel);
                    }];
                }
            }else{
                [WHToast toastMsg:Internationalization(@"授权失败,无法使用相机.请在设置-隐私-相机中允许访问相机")];
            }
        }];
    }else{
        [WHToast toastMsg:Internationalization(@"此设备不支持相机!")];
    }
}
#pragma mark —— @property(nonatomic,strong)HXPhotoManager *photoManager;//选取图片的数据管理类
@dynamic photoManager;
-(HXPhotoManager *)photoManager{
    HXPhotoManager *PhotoManager = objc_getAssociatedObject(self, _cmd);
    if (!PhotoManager) {
        PhotoManager = [HXPhotoManager.alloc initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        PhotoManager.configuration.localFileName = [self.appDisplayName stringByAppendingString:@"Models"];
        PhotoManager.configuration.type = HXConfigurationTypeWXChat;
        PhotoManager.configuration.showOriginalBytes = YES;
        PhotoManager.configuration.showOriginalBytesLoading = YES;
        PhotoManager.configuration.videoMaximumSelectDuration = -1;
        PhotoManager.configuration.limitVideoSize = 100 * 1024 * 1024;
        PhotoManager.configuration.selectVideoLimitSize = YES;
        PhotoManager.configuration.selectVideoBeyondTheLimitTimeAutoEdit = NO;
        PhotoManager.configuration.specialModeNeedHideVideoSelectBtn = NO;
        PhotoManager.configuration.videoMaxNum = 1;
        PhotoManager.configuration.maxNum = 9;
        PhotoManager.configuration.photoMaxNum = 9;
        PhotoManager.configuration.selectTogether = NO;
        /// ❤️导航栏用系统自带的，防止外界关闭了导航栏的bug❤️
        PhotoManager.viewWillAppear = ^(UIViewController *viewController) {
            /// 只会影响 viewWillAppear 和 viewWillDisappear 两个生命周期
            [viewController.navigationController setNavigationBarHidden:NO animated:NO];
        };
        objc_setAssociatedObject(self,
                                 _cmd,
                                 PhotoManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PhotoManager;
}

-(void)setPhotoManager:(HXPhotoManager *)photoManager{
    objc_setAssociatedObject(self,
                             _cmd,
                             photoManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block historyPhotoDataMutArr;//与之相对应的是self.photoManager.afterSelectedArray
@dynamic historyPhotoDataMutArr;
-(NSMutableArray<HXPhotoModel *> *)historyPhotoDataMutArr{
    NSMutableArray <HXPhotoModel *>*HistoryPhotoDataMutArr = objc_getAssociatedObject(self, _cmd);
    if (!HistoryPhotoDataMutArr) {
        /// < 保存本地的方法 >
        /// 保存本地的方法都是在主线程调用
        /// 获取保存在本地文件的模型数组
        /// @param addData 是否添加到manager的数据中
        HistoryPhotoDataMutArr = [NSMutableArray arrayWithArray:[self.photoManager getLocalModelsInFileWithAddData:YES]];
        objc_setAssociatedObject(self,
                                 _cmd,
                                 HistoryPhotoDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return HistoryPhotoDataMutArr;
}

-(void)setHistoryPhotoDataMutArr:(NSMutableArray<HXPhotoModel *> *)historyPhotoDataMutArr{
    objc_setAssociatedObject(self,
                             _cmd,
                             historyPhotoDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block photosDataMutArr;
@dynamic photosDataMutArr;
-(NSMutableArray<HXPhotoModel *> *)photosDataMutArr{
    NSMutableArray <HXPhotoModel *>*PhotosDataMutArr = objc_getAssociatedObject(self, _cmd);
    if (!PhotosDataMutArr) {
        PhotosDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 _cmd,
                                 PhotosDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PhotosDataMutArr;
}

-(void)setPhotosDataMutArr:(NSMutableArray<HXPhotoModel *> *)photosDataMutArr{
    objc_setAssociatedObject(self,
                             _cmd,
                             photosDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block videosDataMutArr;
@dynamic videosDataMutArr;
-(NSMutableArray<HXPhotoModel *> *)videosDataMutArr{
    NSMutableArray <HXPhotoModel *>*VideosDataMutArr = objc_getAssociatedObject(self, _cmd);
    if (!VideosDataMutArr) {
        VideosDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 _cmd,
                                 VideosDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return VideosDataMutArr;
}

-(void)setVideosDataMutArr:(NSMutableArray<HXPhotoModel *> *)videosDataMutArr{
    objc_setAssociatedObject(self,
                             _cmd,
                             videosDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

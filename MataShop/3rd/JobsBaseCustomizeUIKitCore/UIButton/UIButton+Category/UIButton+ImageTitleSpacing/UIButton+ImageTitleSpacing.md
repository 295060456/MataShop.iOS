# 高度自定义的按钮

*注意事项*

```objective-c
#warning UIControlStateSelected 不要用 只锁定 UIControlStateNormal 因为不同的按钮状态会刷新按钮界面，导致self.titleLabel 和 self.imageView 位置大小错乱，很难以调整，看不懂他底层的调用方案

#warning 每一次因为selected不同而需要更换title和image 都必须调用layoutButtonWithEdgeInsetsStyle:imagePadding: 进行刷新
```

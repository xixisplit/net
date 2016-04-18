# net
 图片轮播器

这个轮播器的实现 方式不是用 UIScrollView 做的不是左右滚动. 就是 一个 UIView
--------***轮播器头文件***----------

@class ShufflingView;
@protocol ShufflingViewDelegate <NSObject>

*  轮播器的代理方法,用于监听点击轮播器图片的时候.返回当前被点击的数组的 index;

-(void)ClickImageView:(ShufflingView*)shufflingView imageNameArrayIndex:(int)Index;
@optional

*
*可选代理.此代理会在每次更换图片的时候调用.会传出当前图片数组所属的 index 下标

-(void)shufflingView:(ShufflingView*)shufflingView presentImageNameArrayindex:(int)index;

@end

@interface ShufflingView : UIView

*  轮播器图片的数组.数组元素为图片的字符串路径

@property(nonatomic,strong)NSArray *imageNameArray;

*  轮播器的轮播速度.建议3秒以上

@property(nonatomic,assign)CGFloat  animateDelay;


*指定显示某个图片的下标

@property(nonatomic,assign)int presentIndex;


*  可选属性 图片放大倍数/默认为1.2倍;

@property(nonatomic,assign) CGFloat amplification;


*  轮播器控件的代理

@property(nonatomic,weak)id\<ShufflingViewDelegate\>delegate;


--------------------------分割线--------------------------------

--------***自定义 tabar 控件头文件***----------

@class XXTabBarView;

@protocol  XXTabBarViewDelegate<NSObject>

-(void)XXTabBarView:(XXTabBarView*)tabBarView didClickTaBarItemIndex:(int)index;

@end
@interface XXTabBarView : UIView


 *  tabar 图片名数组
 
@property(nonatomic,copy)NSArray <NSString *> *tabarIconArray;

 *  图片选中状态的数组

@property(nonatomic,copy)NSArray<NSString *> *tabarBackIconArray;


 *  tabar文字数组;

@property(nonatomic,copy)NSArray<NSString*> *tabarTitleArray;


 *  文字默认颜色;

@property(nonatomic,strong)UIColor *textColor;

 *  文字高亮颜色
 
@property(nonatomic,strong)UIColor *tectHightColor;


 *  tabbar 背景颜色
 
@property(nonatomic,strong)UIColor *tabBarbackgroundColor;


 *  image大小.可选属性 默认为图片大小
 
@property(nonatomic)CGPoint tabarImageSize;


 *  默认选中某个 item. 默认第0个.可以在 OK 之前设置.

@property(nonatomic,assign)int defaultItem;



 *  布局方法.在addsubViews最后添加到视图之前调用.

-(void)OK;

 *调用此方法可以跳转到某个 item;

-(void)selectedIteme:(int)index;


@property(nonatomic,weak)id\<XXTabBarViewDelegate\>delegate;

@end

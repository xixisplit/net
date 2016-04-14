# net
 图片轮播器

这个轮播器的实现 方式不是用 UIScrollView 做的不是左右滚动. 就是 UIImageView 

很简单
外部属性和代理方法如下.

#import <UIKit/UIKit.h>

@class ShufflingView;
@protocol ShufflingViewDelegate <NSObject>
/**
 *
 *  轮播器的代理方法,用于监听点击轮播器图片的时候.返回当前被点击的图片的数组的 index;
 */
-(void)ClickImageView:(ShufflingView*)shufflingView imageNameArrayIndex:(int)Index;
@optional
/**
 *
 *可选代理.此代理会在每次更换图片的时候调用.会传出当前图片数组所属的 index 下标
 */
-(void)shufflingView:(ShufflingView*)shufflingView presentImageNameArrayindex:(int)index;

@end

@interface ShufflingView : UIView

/**
 *  轮播器图片的数组.数组元素为图片的字符串路径
 */
@property(nonatomic,strong)NSArray *imageNameArray;
/**
 *  轮播器的轮播速度.建议3秒以上
 */
@property(nonatomic,assign)CGFloat  animateDelay;

/**
 *  轮播器空间的代理
 */
@property(nonatomic,weak)id<ShufflingViewDelegate>delegate;


@end

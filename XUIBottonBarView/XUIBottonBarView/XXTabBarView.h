//
//  XXTabBarView.h
//  XUIBottonBarView
//
//  Created by 陈曦 on 16/4/15.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, XXTabBarViewItemIconAnimationType) {

    XXTabBarViewItemIconAnimationTypeLeftRotation    = 1 << 0,
    XXTabBarViewItemIconAnimationTypeRightRotation   = 1 << 1,

};

@class XXTabBarView;

@protocol  XXTabBarViewDelegate<NSObject>

-(void)XXTabBarView:(XXTabBarView*)tabBarView didClickTaBarItemIndex:(int)index;

@end
@interface XXTabBarView : UIView

/**
 *  tabar的背景图.可选.图片大小为 tabar 的大小,如果设置了背景图.背景色就会透明;
 */
@property(nonatomic,weak)UIImage *backgroundImage;
/**
 *  tabar 图片名数组;
 */
@property(nonatomic,copy)NSArray <NSString *> *tabarIconArray;
/**
 *  图片选中状态的数组
 */
@property(nonatomic,copy)NSArray<NSString *> *tabarBackIconArray;

/**
 *  tabar文字数组;
 */
@property(nonatomic,copy)NSArray<NSString*> *tabarTitleArray;

/**
 *  文字默认颜色;
 */
@property(nonatomic,strong)UIColor *textColor;
/**
 *  文字高亮颜色
 */
@property(nonatomic,strong)UIColor *tectHightColor;

/**
 *  tabbar 背景颜色
 */
@property(nonatomic,strong)UIColor *tabBarbackgroundColor;

/**
 *  image大小.可选属性 默认为图片大小  此属性可以解决icon图片过大的问题.
 */
@property(nonatomic)CGPoint tabarImageSize;

/**
 *  默认选中某个 item. 默认第0个.如果设置此属性.并不能让 tabarView 跟着跳转.需要设置 self.selectedIndex;
 */
@property(nonatomic,assign)int defaultItem;

/**
 *  点击图标的动画效果.默认无效果.可选属性
 */
@property(nonatomic,assign)XXTabBarViewItemIconAnimationType animationType;

/**
 *  布局方法.在addsubViews最后添加到视图之前调用.
 */
-(void)OK;
/**
 *调用此方法可以跳转到某个 item;
 */
-(void)selectedIteme:(int)index;



@property(nonatomic,weak)id<XXTabBarViewDelegate>delegate;

@end

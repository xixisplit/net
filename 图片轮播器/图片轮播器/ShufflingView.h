//
//  ShufflingView.h
//  轮播器
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShufflingView;
@protocol ShufflingViewDelegate <NSObject>
/**
 *
 *  轮播器的代理方法,用于监听点击轮播器图片的时候.返回当前被点击的数组的 index;
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
 *指定显示某个图片的下标
 */
@property(nonatomic,assign)int presentIndex;

/**
 *  图片放大倍数/默认为1.2倍;
 */
@property(nonatomic,assign) CGFloat amplification;

/**
 *  轮播器控件的代理
 */
@property(nonatomic,weak)id<ShufflingViewDelegate>delegate;


@end

//
//  headView.h
//  日历 demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class headView;

@protocol headViewDelegate <NSObject>
//控件按钮被点击的回调
-(void)headView:(headView *)headView ClickButton:(UIButton *)button andclickbuttontag:(int)tag;

@end

@interface headView : UIView

@property(nonatomic,assign) long years;
@property(nonatomic,assign) long month;

@property(nonatomic,weak)id<headViewDelegate>delegate;


-(void)setMonthLabel:(NSDate*)date;

@end

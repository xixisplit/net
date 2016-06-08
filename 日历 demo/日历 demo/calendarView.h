//
//  calendarView.h
//  日历 demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class calendarView;
typedef struct _defaultTime {
    int year;
    int month;
    int day;
} defaultTime;

@protocol calendarViewDelegate <NSObject>

-(void)calendarView:(calendarView *)calendarView andClickDateButton:(UIButton*)button andClickDay:(int)day andMonth:(int)month andYear:(int)year;
@end
@interface calendarView : UIView
{
//成员变量
@public
    defaultTime _defaultTime;
}

@property(nonatomic,strong)UIColor *hightColor;

/**
 *  默认显示的月份
 */
@property(nonatomic,strong)NSDate *SpecifyMonth;

@property(nonatomic ,assign) NSInteger timeZone;
@property(nonatomic,weak)id<calendarViewDelegate>delegate;
/**
 * 调用此方法.默认几月几号被选中高亮
 */
-(void)defaultTimeMakeYear:(int)year month:(int)month day:(int)day;
/**
 *  下一个月
 */
-(void)next;
/**
 *  上一个月
 */
-(void)on;

/**
 *  根据年月日返回date 类型
 * 时分秒为12.12.12
 */
- (NSDate *)getDate:(int)year month:(int)month day:(int)day;
@end

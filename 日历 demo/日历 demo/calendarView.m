//
//  calendarView.m
//  日历 demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "calendarView.h"
#import "headView.h"

@interface calendarView () <headViewDelegate>

@property(nonatomic, assign) long weekNumber; //获取星期对应的长整形字符串
@property(nonatomic, assign) long day; //获取日期对应的长整形字符串
@property(nonatomic, assign) long year;  //获取年对应的长整形字符串
@property(nonatomic, assign) long month; //获取月对应的长整形字符串
@property(nonatomic, assign) long hour; //获取小时对应的长整形字符串
@property(nonatomic, assign) long minute; //获取月对应的长整形字符串
@property(nonatomic, assign) long second; //获取秒对应的长整形字符串

@property(nonatomic, assign) long monthlength; //月份天数

@property(nonatomic, assign) long labelMaxHeight; //星期控件的最大 Y 值

@property(nonatomic, strong) NSDate *showDate; // 当前显示月份的日期

@property(nonatomic, strong) headView *headView;

@property(nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation calendarView

- (NSMutableArray *)buttonArray {

  if (_buttonArray == nil) {
    _buttonArray = [NSMutableArray array];
  }

  return _buttonArray;
}
- (void)setTimeZone:(NSInteger)timeZone {

  _timeZone = 60 * 60 * timeZone;
}

//获取日期
- (void)getCalendar {

  // 获取当前时间
  NSDate *date;

  if (self.SpecifyMonth) {

    date = self.SpecifyMonth;

  } else{
 date = [NSDate date];
}
self.showDate = date;

    NSLog(@"%@",date);
//获取当前月份
NSCalendar *calendar = [[NSCalendar alloc]
    initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; //设置成中国阳历
NSDateComponents *comps = [[NSDateComponents alloc] init];
NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |
                      NSCalendarUnitDay | NSCalendarUnitWeekday |
                      NSCalendarUnitHour | NSCalendarUnitMinute |
                      NSCalendarUnitSecond; // 获取日历单位

comps = [calendar components:unitFlags fromDate:date];

self.weekNumber =
    [self weekdayStringFromDate:date]; //获取星期对应的长整形字符串
self.day = [comps day];                //获取日期对应的长整形字符串
self.year = [comps year];              //获取年对应的长整形字符串
self.month = [comps month];            //获取月对应的长整形字符串
                                       //    测试特殊属性
//      self.year = 2017;     //获取年对应的长整形字符串
//      self.month = 1;   //获取月对应的长整形字符串
// 测试属性
self.hour = [comps hour];     //获取小时对应的长整形字符串
self.minute = [comps minute]; //获取月对应的长整形字符串
self.second = [comps second]; //获取秒对应的长整形字符串
                              //    NSLog(@"%ld-星期/d,%ld-日,%ld-年,%ld-月,%ld-小时,%ld-分,%ld-秒",self.weekNumber,self.day,self.year,self.month,self.hour,self.minute,self.second);

headView *headview =
    [[headView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                               self.frame.size.width / 7)];
headview.backgroundColor = [UIColor orangeColor];
headview.years = self.year;
headview.month = self.month;
headview.delegate = self;

[self addSubview:headview];

self.headView = headview;

[self setweekView];
}

- (void)layoutSubviews {
    

  [self getCalendar];

  [self setUI];

    
}

- (void)setweekView {
  //画周几的格子
  for (int i = 0; i < 7; i++) {
    UILabel *weekLabel = [[UILabel alloc] init];
    weekLabel.frame = CGRectMake(
        (self.frame.size.width - (int)self.frame.size.width / 7 * 7) / 2 +
            (int)self.frame.size.width / 7 * i,
        self.headView.frame.size.height, (int)self.frame.size.width / 7,
        (int)self.frame.size.width / 7);

    if (i == 0) {
      weekLabel.text = @"周日";

    } else {

      weekLabel.text = [NSString stringWithFormat:@"周%d", i];
    };
    weekLabel.textAlignment = NSTextAlignmentCenter;

    weekLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:weekLabel];
    if (i == 1) {

      self.labelMaxHeight =
          weekLabel.frame.origin.y + weekLabel.frame.size.height;
    }
  }
}
- (void)setUI {
  NSDate *monthOneDay;
  // 1.获取的当前月份周几开始
  if (self.SpecifyMonth) {
    monthOneDay = self.SpecifyMonth;
  } else {

    monthOneDay =
        [NSDate dateWithTimeIntervalSinceNow:-(self.day - 1) + self.timeZone];
  }
    NSLog(@"%@",monthOneDay);
    
  int monthOneDayWeekDay = [self weekdayStringFromDate:monthOneDay];
    NSLog(@"周%d开始", monthOneDayWeekDay);
  // 2.获取本月有几天
  self.monthlength = [self getNumberOfDaysAMonth:monthOneDay];
  //  NSLog(@"本月有% ld天", self.monthlength);

  //创建日期格子

  int line = (int)(self.monthlength + monthOneDayWeekDay) / 7;
  if (((int)(self.monthlength + monthOneDayWeekDay) / 7) % 7 != 0) {
    line = line + 1;
  }
  if (monthOneDayWeekDay == 7) {
    line = line - 1;
  }
  //    创建日期格子
  //格子编号
  int GridNumber = 0;
  int DayNumber = 0;
  for (int i = 0; i < 6; i++) {

    for (int j = 0; j < 7; j++) {
      GridNumber++;
      float w = (int)self.frame.size.width / 7;
      float h = w;
      float x = j * w;
      float y = i * w;

      UIButton *button = [[UIButton alloc]
          initWithFrame:CGRectMake(2 + x, y + self.labelMaxHeight, w, h)];
        button.clipsToBounds = YES;

        button.layer.cornerRadius = 10;
        button.layer.masksToBounds = YES;
        
      [self.buttonArray addObject:button];
      [button addTarget:self
                    action:@selector(ClickDateButton:)
          forControlEvents:UIControlEventTouchUpInside];

      [self addSubview:button];
      button.backgroundColor = [UIColor blueColor];

      if (monthOneDayWeekDay == 7) {
        DayNumber++;

          
        [button setTitle:[NSString stringWithFormat:@"%d", DayNumber]
                forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;
        if (DayNumber > self.monthlength) {

          [button setTitle:@"" forState:UIControlStateNormal];

          button.userInteractionEnabled = NO;
        }
      } else {

        if (GridNumber > monthOneDayWeekDay) {
          DayNumber++;
          if (DayNumber <= self.monthlength) {
            NSLog(@"%d", _defaultTime.day);

            [button setTitle:[NSString stringWithFormat:@"%d", DayNumber]
                    forState:UIControlStateNormal];
          }
        }
      }
      if (i < line) {
        button.hidden = NO;
      } else {
        button.hidden = YES;
      }
        
        if (self.year == _defaultTime.year &&
            self.month == _defaultTime.month &&
            DayNumber == _defaultTime.day) {
            button.backgroundColor = self.hightColor;
        }

    }
  }
}

//根据日期返回周几
- (int)weekdayStringFromDate:(NSDate *)inputDate {

  NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"7", @"1", @"2",
                                                @"3", @"4", @"5", @"6", nil];

  NSCalendar *calendar = [[NSCalendar alloc]
      initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

  NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

  [calendar setTimeZone:timeZone];

  NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;

  NSDateComponents *theComponents =
      [calendar components:calendarUnit fromDate:inputDate];

  return [[weekdays objectAtIndex:theComponents.weekday] intValue];
}

#pragma mark - 代理方法
// headView 代理方法
- (void)headView:(headView *)headView ClickButton:(UIButton *)button andclickbuttontag:(int)tag{

  if (tag == 1) {
    //上一个月

    self.showDate =
        [self getPriousorLaterDateFromDate:self.showDate withMonth:-1];

  } else {
    //下一个月
    self.showDate =
        [self getPriousorLaterDateFromDate:self.showDate withMonth:1];
  }

  [self.headView setMonthLabel:self.showDate];
//  NSLog(@"-----%@", self.showDate);

  //根据下一个界面的月份日期.更新成员变量------------------------

  //    NSLog(@"%@",date);
  //获取当前月份
  NSCalendar *calendar =
      [[NSCalendar alloc] initWithCalendarIdentifier:
                              NSCalendarIdentifierGregorian]; //设置成中国阳历
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |
                        NSCalendarUnitDay | NSCalendarUnitWeekday |
                        NSCalendarUnitHour | NSCalendarUnitMinute |
                        NSCalendarUnitSecond; // 获取日历单位

  comps = [calendar components:unitFlags fromDate:self.showDate];

  self.weekNumber =
      [self weekdayStringFromDate:self.showDate]; //获取星期对应的长整形字符串
  self.day = [comps day];       //获取日期对应的长整形字符串
  self.year = [comps year];     //获取年对应的长整形字符串
  self.month = [comps month];   //获取月对应的长整形字符串
  self.hour = [comps hour];     //获取小时对应的长整形字符串
  self.minute = [comps minute]; //获取月对应的长整形字符串
  self.second = [comps second]; //获取秒对应的长整形字符串
  self.monthlength = [self getNumberOfDaysAMonth:self.showDate];

  //-------------------更新成员变量------------------------
  //清除原有 button 内容

  for (int i = 0; i < self.buttonArray.count; i++) {
    UIButton *but = self.buttonArray[i];
    [but setTitle:@"" forState:UIControlStateNormal];
  }
  NSString *string = [NSString
      stringWithFormat:@"%ld%02ld%02ld%02d%02d%02d", self.year, self.month,
                       self.day, 12, 12, 12];
  //获取到下一个月的时间
  NSDate *date = [self getbeijingTime:string];
  int monthOneDayWeekDay = [self weekdayStringFromDate:date];
//  NSLog(@"周日开始计算第%d天", monthOneDayWeekDay);

  // 2.获取本月有几天
  self.monthlength = [self getNumberOfDaysAMonth:date];
//  NSLog(@"本月有% ld天", self.monthlength);
  int line = (int)(self.monthlength + monthOneDayWeekDay) / 7;
  if (((int)(self.monthlength + monthOneDayWeekDay)) % 7 != 0) {
    line = line + 1;
  }
//  NSLog(@"%d排", line);

  if (monthOneDayWeekDay == 7) {
    line = line - 1;
  }
  int hiddenButtonNumber = line * 7;

  //创建日期格子
  int daynumber = 0;

  for (int i = 0; i < self.buttonArray.count; i++) {

    UIButton *button = self.buttonArray[i];
    button.backgroundColor = [UIColor blueColor];

    button.hidden = NO;
    if (i >= hiddenButtonNumber) {

      button.hidden = YES;
    }
    if (monthOneDayWeekDay == 7) {
      daynumber++;

      [button setTitle:[NSString stringWithFormat:@"%d", daynumber]
              forState:UIControlStateNormal];
      button.userInteractionEnabled = YES;
      if (daynumber > self.monthlength) {

        [button setTitle:@"" forState:UIControlStateNormal];

        button.userInteractionEnabled = NO;
      }
    } else {

      if (i >= monthOneDayWeekDay && daynumber < self.monthlength) {
        daynumber++;

        [button setTitle:[NSString stringWithFormat:@"%d", daynumber]
                forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;

      } else {

        [button setTitle:@"" forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
      }
    }
    if (self.year == _defaultTime.year && self.month == _defaultTime.month &&
        daynumber == _defaultTime.day) {
//      NSLog(@"---重要----%d", daynumber);
      button.backgroundColor = self.hightColor;
    }
  }
}

#pragma mark - 时间工具方法
// 根据数字字符串返回东八区时间

- (NSDate *)getbeijingTime:(NSString *)timeString {

  NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];

  [inputFormatter
      setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];

  NSDate *inputDate = [inputFormatter dateFromString:timeString];

  //    NSLog(@"date= %@", inputDate);
  NSDate *date =
      [[NSDate alloc] initWithTimeInterval:60 * 60 * 8 sinceDate:inputDate];

  return date;
}

//获取上一个月或下一个月的时间
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date
                               withMonth:(int)month

{
  NSDateComponents *comps = [[NSDateComponents alloc] init];

  [comps setMonth:month];

  NSCalendar *calender = [[NSCalendar alloc]
      initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

  NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];

  return mDate;
}

//获取当前月份总天数
- (NSInteger)getNumberOfDaysAMonth:(NSDate *)date {
  NSCalendar *calendar =
      [[NSCalendar alloc] initWithCalendarIdentifier:
                              NSCalendarIdentifierGregorian]; // 指定日历的算法
  NSDate *currentDate = date;
  // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
  NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                 inUnit:NSCalendarUnitMonth
                                forDate:currentDate];
  return range.length;
}

#pragma mark - 日期的点击回调
- (void)ClickDateButton:(UIButton *)button {

  NSString *string = [button titleForState:UIControlStateNormal];

  if (string != nil) {

    NSLog(@"点击了日期%@", string);
    if ([self.delegate respondsToSelector:@selector(calendarView:
                                              andClickDateButton:
                                                     andClickDay:
                                                        andMonth:
                                                         andYear:)]) {
      [self.delegate calendarView:self
               andClickDateButton:button
                      andClickDay:[string intValue]
                         andMonth:(int)self.month
                          andYear:(int)self.year];
    }

    for (UIButton *button in self.buttonArray) {

      button.backgroundColor = [UIColor blueColor];
    }

    if (self.hightColor) {

      button.backgroundColor = self.hightColor;
    }
  }
}

#pragma mark - 类方法.设置默认高亮时间
- (void)defaultTimeMakeYear:(int)year month:(int)month day:(int)day {
  _defaultTime.year = year;
  _defaultTime.month = month;
  _defaultTime.day = day;
}
#pragma mark - 对象方法,显示指定月份

- (NSDate *)getDate:(int)year month:(int)month day:(int)day {
  NSString *string =
      [NSString stringWithFormat:@"%d%02d%02d%02d%02d%02d", year, month, day,
                                 12, 12, 12];
  //获取到下一个月的时间
  NSDate *date = [self getbeijingTime:string];

  return date;
}
-(void)next{

    [self headView:nil ClickButton:nil andclickbuttontag:2];

}
-(void)on{

    [self headView:nil ClickButton:nil andclickbuttontag:1];

}
//返回指定字符串日期和今天的关系.返回-为过去的天数.0为今天.1以上为后面的天

// 返回0为当天.-为过去的日期. 正为后面的日期
//调用方式----*******---------
//NSLog(@"%d", [self stringWithDateString:@"2016-06-09 00:00"]);

-(int)stringWithDateString:(NSString *)timeString{

    // 需求.根据时间.判断.是否是今天或者明天或者后天
    //获取到当天的时间.
    
    NSDate *newdate =
    [[NSDate alloc] initWithTimeInterval:60 * 60 * 8 sinceDate:[NSDate date]];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; //设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond; // 获取日历单位
    
    comps = [calendar components:unitFlags fromDate:newdate];

    int day = (int)[comps day];                //获取日期对应的长整形字符串
    int year = (int)[comps year];              //获取年对应的长整形字符串
    int month = (int)[comps month];            //获取月对应的长整形字符串


    //根据字符串返回一个时间类型;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter
     setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *inputDate = [inputFormatter dateFromString:timeString];
    NSDate *date =
    [[NSDate alloc] initWithTimeInterval:60 * 60 * 8 sinceDate:inputDate];
    NSLog(@"传入%@",date);

//    2016-06-07 00:00
    NSDate *newsdate = [inputFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 08:00",year,month,day]];
    
    NSLog(@"当天%@",newsdate);
    //对比2个时间的差值.-
    
   NSTimeInterval timeint = [date timeIntervalSinceDate:newsdate];

    return timeint/86400;
}
@end

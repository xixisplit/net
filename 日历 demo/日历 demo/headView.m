//
//  headView.m
//  日历 demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "headView.h"

@interface headView ()

@property(nonatomic, strong) UILabel *monthlabel;

@end
@implementation headView


- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    [self setUI];
  }
  return self;
}

- (void)setUI {

  UILabel *label = [[UILabel alloc] init];

  label.backgroundColor = [UIColor cyanColor];

  self.monthlabel = label;
  [self addSubview:label];

  UIButton *OnButton =
      [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];

    [OnButton setBackgroundColor:[UIColor brownColor]];
  OnButton.tag = 1;
  [OnButton setTitle:@"上月" forState:UIControlStateNormal];

  [OnButton addTarget:self
                action:@selector(clickButton:)
      forControlEvents:UIControlEventTouchUpInside];

  UIButton *NextButton = [[UIButton alloc]
      initWithFrame:CGRectMake(self.frame.size.width - 100, 0, 100, 50)];
    [NextButton setBackgroundColor:[UIColor brownColor]];
    
  [NextButton setTitle:@"下月" forState:UIControlStateNormal];
  NextButton.tag = 2;

  [NextButton addTarget:self
                 action:@selector(clickButton:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:OnButton];
    [self addSubview:NextButton];
}

- (void)clickButton:(UIButton *)button {
    if([self.delegate respondsToSelector:@selector(headView:ClickButton:andclickbuttontag:)]){
    
        [self.delegate headView:self ClickButton:button andclickbuttontag:(int)button.tag];
    }
    
}
- (void)layoutSubviews {

  self.monthlabel.text =
      [NSString stringWithFormat:@"%ld年%ld月", self.years, self.month];
  [self.monthlabel sizeToFit];
  self.monthlabel.center = self.center;
    

}

-(void)setMonthLabel:(NSDate *)date{
    //获取当前月份
    NSCalendar *calendar =
    [[NSCalendar alloc] initWithCalendarIdentifier:
     NSCalendarIdentifierGregorian]; //设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |
    NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond; // 获取日历单位

    comps = [calendar components:unitFlags fromDate:date];
    
    self.years = [comps year];     //获取年对应的长整形字符串
    self.month = [comps month];   //获取月对应的长整形字符串

    [self.monthlabel setText:    [NSString stringWithFormat:@"%ld年%ld月", self.years, self.month]];
    
//    self.monthlabel.text =

 [self.monthlabel sizeToFit];
    self.monthlabel.center = self.center;
   
}

@end

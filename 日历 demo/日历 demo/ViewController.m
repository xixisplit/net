//
//  ViewController.m
//  日历 demo
//
//  Created by 陈曦 on 16/6/7.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "ViewController.h"
#import "calendarView.h"




@interface ViewController ()<calendarViewDelegate>


@property(nonatomic,strong)calendarView *calendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view, typically from a nib.
    calendarView *view = [[calendarView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.timeZone = 8;
    view.backgroundColor = [UIColor redColor];
    view.hightColor = [UIColor greenColor];
    [view defaultTimeMakeYear:2016 month:6 day:8];
//
//    NSDate *date = [view getDate:2017 month:1 day:1];
//    view.SpecifyMonth = date;
    
    view.delegate = self;
    self.calendar = view;
    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(175, 600, 50, 50)];
    
    [self.view addSubview:button];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarView:(calendarView *)calendarView andClickDateButton:(UIButton *)button andClickDay:(int)day andMonth:(int)month andYear:(int)year{

    NSLog(@"被点击的日期-%d年-%d月-%d日",year,month,day);
    

}

-(void)clickButton{
    NSLog(@"123");

    [self.calendar on];
}
@end

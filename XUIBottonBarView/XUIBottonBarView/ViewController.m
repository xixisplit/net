//
//  ViewController.m
//  XUIBottonBarView
//
//  Created by 陈曦 on 16/4/15.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "ViewController.h"

#import "N1.h"
#import "N2.h"
#import "N3.h"
#import "N4.h"
#import "XXTabBarView.h"
#import "nav.h"

@interface ViewController () <XXTabBarViewDelegate>

@property(nonatomic, weak) XXTabBarView *tabbar;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  N1 *n1 = [[N1 alloc] init];
  N2 *n2 = [[N2 alloc] init];
  N3 *n3 = [[N3 alloc] init];
  N4 *n4 = [[N4 alloc] init];

  n1.title = @"n1";
  n2.title = @"n2";
  n3.title = @"n3";
  n4.title = @"n4";

  nav *nav1 = [[nav alloc] initWithRootViewController:n1];
  nav *nav2 = [[nav alloc] initWithRootViewController:n2];
  nav *nav3 = [[nav alloc] initWithRootViewController:n3];
  nav *nav4 = [[nav alloc] initWithRootViewController:n4];

  [self addChildViewController:nav1];
  [self addChildViewController:nav2];
  [self addChildViewController:nav3];
  [self addChildViewController:nav4];

  UIButton *button =
      [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 30, 30)];
  button.backgroundColor = [UIColor blueColor];

  [button addTarget:self
                action:@selector(Click)
      forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:button];
}

- (void)Click {

  int rnd = arc4random_uniform(4);

  NSLog(@"%d", rnd);

  [self.tabbar selectedIteme:rnd];
  self.selectedIndex = rnd;
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  XXTabBarView *bar = [[XXTabBarView alloc] initWithFrame:self.tabBar.bounds];
  self.tabbar = bar;


  bar.delegate = self;
    
  bar.tabarTitleArray = @[ @"资讯", @"好友", @"发现", @"我" ];
  bar.tabBarbackgroundColor = [UIColor colorWithRed:240.0 / 255.0
                                              green:240.0 / 255.0
                                               blue:240.0 / 255.0
                                              alpha:1.0];

  bar.textColor = [UIColor colorWithRed:90.0 / 255.0
                                  green:90.0 / 255.0
                                   blue:90.0 / 255.0
                                  alpha:1.0];
  bar.tectHightColor = [UIColor colorWithRed:54.0 / 255.0
                                       green:114.0 / 255.0
                                        blue:181.0 / 255.0
                                       alpha:1.0];

  //    bar.tabarImageSize = CGPointMake(25, 30);
// 默认选中某个 item. 默认第0个.如果设置此属性.并不能让 tabarView 跟着跳转.需要设置 self.selectedIndex;
    bar.defaultItem = 3;
    self.selectedIndex = 3;
//--------------------
    
  bar.tabarIconArray = @[
    @"tab_icon_news_normal",
    @"tab_icon_friend_normal",
    @"tab_icon_quiz_normal",
    @"tab_icon_more_normal"
  ];

  bar.tabarBackIconArray = @[
    @"tab_icon_news_press",
    @"tab_icon_friend_press",
    @"tab_icon_quiz_press",
    @"tab_icon_more_press"
  ];


    bar.animationType = XXTabBarViewItemIconAnimationTypeLeftRotation;
    

  [bar OK];
  [self.tabBar addSubview:bar];
  [bar bringSubviewToFront:self.tabBar];
}

- (void)XXTabBarView:(XXTabBarView *)tabBarView
    didClickTaBarItemIndex:(int)index {

  NSLog(@"%d", index);
  self.selectedIndex = index;
}

@end

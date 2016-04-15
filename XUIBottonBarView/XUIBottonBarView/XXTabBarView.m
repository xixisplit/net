//
//  XXTabBarView.m
//  XUIBottonBarView
//
//  Created by 陈曦 on 16/4/15.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "XXTabBarView.h"
#import "XXtabBarButton.h"

@interface XXTabBarView ()

@property(nonatomic, weak) UIButton *selectedButton;

@end

@implementation XXTabBarView



- (void)addbottomBarButtonWithImage:(NSString *)normal
                           selected:(NSString *)selected {
    
    self.backgroundColor = [UIColor blackColor];
    
  XXtabBarButton *button = [[XXtabBarButton alloc] init];
  [button setTitle:normal forState:UIControlStateNormal];

  [button addTarget:self
                action:@selector(ClickButton:)
      forControlEvents:UIControlEventTouchUpInside];

  [self addSubview:button];
}

- (void)ClickButton:(UIButton *)button {

  NSLog(@"%ld", (long)button.tag);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat w = self.bounds.size.width / self.subviews.count;
  CGFloat h = self.bounds.size.height;
  CGFloat y = 0;
  for (int i = 0; i < self.subviews.count; i++) {
    CGFloat x = i * w;
    UIButton *button = self.subviews[i];
    // 为每个按钮绑定一个tag
    button.tag = i;
      
    button.frame = CGRectMake(x, y, w, h);

    if (i == 0) {
      button.selected = YES;
      self.selectedButton = button;
    }
  }
}

@end

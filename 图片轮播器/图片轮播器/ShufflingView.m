//
//  ShufflingView.m
//  轮播器
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "ShufflingView.h"

@interface ShufflingView ()

@property(nonatomic, assign) int startIndex;

@property(nonatomic, assign) int endIndex;

@property(nonatomic, strong) UIView *view;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UIImageView *imageViewOne;

@property(nonatomic, assign) CGRect selfrect;

@property(nonatomic, strong) NSTimer *timer;

@property(nonatomic,assign) CGFloat magnification;

@end

@implementation ShufflingView

- (void)setImageNameArray:(NSArray *)imageNameArray {

  _imageNameArray = imageNameArray;
    
    if (self.amplification) {
        self.magnification = self.amplification;
    }else{
        self.magnification = 1.2;
    }

  [self setView];
}

- (void)setView {
  UIView *view = [[UIView alloc] initWithFrame:self.frame];
  [self addSubview:view];

  view.userInteractionEnabled = YES;

  self.view = view;
  self.view.clipsToBounds = YES;

  self.startIndex = 1;

  // 第一个 imageView;

  UIImageView *imageView = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:self.imageNameArray[0]]];

  self.imageView = imageView;

  imageView.frame = self.view.frame;

  [self.view addSubview:imageView];

  NSString *imageName = self.imageNameArray[1];

  // 第二个 imageView
  UIImageView *imageviewOne =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];

  imageviewOne.alpha = 0.0;

  imageviewOne.bounds = CGRectMake(0, 0, self.view.frame.size.width * self.magnification,
                                   self.view.frame.size.height * self.magnification);

  imageviewOne.center = self.view.center;

  self.imageViewOne = imageviewOne;

  [self.view addSubview:imageviewOne];

  NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.animateDelay
                                                    target:self
                                                  selector:@selector(shuffling)
                                                  userInfo:nil
                                                   repeats:YES];

  self.timer = timer;

  UIButton *button = [[UIButton alloc] initWithFrame:self.view.frame];
  [button addTarget:self
                action:@selector(ClickImage:)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
  }
  return self;
}

- (void)ClickImage:(UITapGestureRecognizer *)recognizer {

  //    NSLog(@"点击了图片.现在的图片 tag
  //    是%@",self.imageNameArray[self.endstartIndex]);
  if (self.delegate) {

    [self.delegate ClickImageView:self imageNameArrayIndex:self.endIndex];
  }
}

- (void)shuffling {

  self.startIndex++;
  if (self.startIndex > self.imageNameArray.count - 1) {
    self.startIndex = 0;
  }

  self.endIndex = self.startIndex - 1;
  if (self.endIndex < 0) {
    self.endIndex = (int)self.imageNameArray.count - 1;
  }
  self.imageView.alpha = 1.0;

  if ([self.delegate respondsToSelector:@selector(shufflingView:
                                            presentImageNameArrayindex:)]) {

    [self.delegate shufflingView:self presentImageNameArrayindex:self.endIndex];
  }

  NSString *imageName = self.imageNameArray[self.startIndex];

  ;
  NSString *imageName1 = self.imageNameArray[self.endIndex];

  [UIView animateWithDuration:1.0
      animations:^{
        self.imageView.alpha = 0.0;
        self.imageView.center = self.view.center;
        self.imageView.bounds =
            CGRectMake(0, 0, self.view.frame.size.width * self.magnification,
                       self.view.frame.size.height * self.magnification);
        self.imageViewOne.alpha = 1.0;
        self.imageViewOne.bounds = self.view.frame;

      }
      completion:^(BOOL finished) {

        self.imageViewOne.image = [UIImage imageNamed:imageName];
        self.imageView.image = [UIImage imageNamed:imageName1];
        self.imageViewOne.bounds =
            CGRectMake(0, 0, self.view.frame.size.width * self.magnification,
                       self.view.frame.size.height * self.magnification);
        self.imageViewOne.alpha = 0.0;
        self.imageView.frame = self.view.bounds;
        self.imageView.alpha = 1.0;

      }];
}

//重写 set 方法.在赋值的时候.做跳转的动画
- (void)setPresentIndex:(int)presentIndex {

  if (self.endIndex == presentIndex) {

      NSLog(@"相同.直接跳出去");
      
    return;
  }

  _presentIndex = presentIndex;
  //关闭定时器
  [self.timer invalidate];
  self.timer = nil;

  NSLog(@"当前%d,目标%d", self.endIndex, presentIndex);

  self.imageViewOne.alpha = 0.0;

  self.imageView.image =
      [UIImage imageNamed:self.imageNameArray[self.endIndex]];
  self.imageViewOne.image =
      [UIImage imageNamed:self.imageNameArray[presentIndex]];
  self.startIndex = presentIndex;

  [UIView animateWithDuration:0.5
      animations:^{

        self.imageView.alpha = 0.0;
        self.imageView.center = self.view.center;
        self.imageView.bounds =
            CGRectMake(0, 0, self.view.frame.size.width * self.magnification,
                       self.view.frame.size.height * self.magnification);
        self.imageViewOne.alpha = 1.0;
        self.imageViewOne.bounds = self.view.frame;

      }
      completion:^(BOOL finished) {

        self.timer =
            [NSTimer scheduledTimerWithTimeInterval:self.animateDelay
                                             target:self
                                           selector:@selector(shuffling)
                                           userInfo:nil
                                            repeats:YES];

      }];

  // 当前图片下标
}

@end

//
//  ShufflingView.m
//  轮播器
//
//  Created by 陈曦 on 16/4/14.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "ShufflingView.h"

@interface ShufflingView ()

@property(nonatomic, assign) int index;


@property(nonatomic,assign) int indexs;

@property(nonatomic, strong) UIView *view;

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UIImageView *imageViewOne;

@property(nonatomic, assign) CGRect selfrect;

@property(nonatomic,strong) NSTimer *timer;


@end

@implementation ShufflingView


-(void)setImageNameArray:(NSArray *)imageNameArray{

    _imageNameArray=imageNameArray;
    
    [self setView];
}

-(void)setView{
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:view];
    
    view.userInteractionEnabled = YES;
    
    self.view = view;
    self.view.clipsToBounds = YES;
    
    self.index = 1;
    
    
    
    // 第一个 imageView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageNameArray[0]]];
    
    self.imageView = imageView;
    
    imageView.frame = self.view.frame;
    
    
    [self.view addSubview:imageView];
    
    
    NSString *imageName = self.imageNameArray[1];
    
    // 第二个 imageView
    UIImageView *imageviewOne =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    imageviewOne.alpha = 0.0;
    
    imageviewOne.bounds = CGRectMake(0, 0, self.view.frame.size.width * 1.2,
                                     self.view.frame.size.height * 1.2);
    
    imageviewOne.center = self.view.center;
    
    self.imageViewOne = imageviewOne;
    
    [self.view addSubview:imageviewOne];
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.animateDelay target:self selector:@selector(shuffling) userInfo:nil repeats:YES];
    
    self.timer = timer;
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:self.view.frame];
    [button addTarget:self action:@selector(ClickImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    }
  return self;
}


-(void)ClickImage:(UITapGestureRecognizer*)recognizer{
    
//    NSLog(@"点击了图片.现在的图片 tag 是%@",self.imageNameArray[self.indexs]);
    if (self.delegate) {
        
        [self.delegate ClickImageView:self imageNameArrayIndex:self.indexs];
    }
    
}

- (void)shuffling {

    self.index++;
    if (self.index > self.imageNameArray.count-1) {
        self.index = 0;
    }
    
    self.indexs = self.index -1;
    if (self.indexs < 0) {
        self.indexs = (int)self.imageNameArray.count-1;
    }
    self.imageView.alpha = 1.0;


    if ([self.delegate respondsToSelector:@selector(shufflingView:presentImageNameArrayindex:)]) {
        
        [self.delegate shufflingView:self presentImageNameArrayindex:self.indexs];
    }
    
    NSString *imageName = self.imageNameArray[self.index];
    
    ;
    NSString *imageName1 = self.imageNameArray[self.indexs];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.alpha = 0.0;
        self.imageView.center = self.view.center;
        self.imageView.bounds =CGRectMake(0, 0, self.view.frame.size.width * 1.2,
                                          self.view.frame.size.height * 1.2);
        self.imageViewOne.alpha = 1.0;
        self.imageViewOne.bounds = self.view.frame;
        
    } completion:^(BOOL finished) {
        
        self.imageViewOne.image = [UIImage imageNamed:imageName];
        self.imageView.image = [UIImage imageNamed:imageName1];
        self.imageViewOne.bounds = CGRectMake(0, 0, self.view.frame.size.width * 1.2,
                                              self.view.frame.size.height * 1.2);
        self.imageViewOne.alpha = 0.0;
        self.imageView.frame = self.view.bounds;
        self.imageView.alpha = 1.0;

        
    }];
    
    
    }


@end

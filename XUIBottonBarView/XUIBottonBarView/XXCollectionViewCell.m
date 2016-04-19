//
//  XXCollectionViewCell.m
//  XUIBottonBarView
//
//  Created by 陈曦 on 16/4/18.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "XXCollectionViewCell.h"
#import "XXTabBarView.h"
@interface XXCollectionViewCell ()

@property(nonatomic,strong)XXTabBarView * tabBar;

@end

@implementation XXCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        [self set];
        
        
    }
    return self;
}


-(void)set{
    
    UIImage *image = [UIImage imageNamed:self.imageName];
    UIImage *himage = [UIImage imageNamed:self.HightImageName];
    
    UIImageView *imageView =
    [[UIImageView alloc] initWithImage:image highlightedImage:himage];
    
    imageView.center =
    CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 - 5);
    [self addSubview:imageView];
    

    
}
@end

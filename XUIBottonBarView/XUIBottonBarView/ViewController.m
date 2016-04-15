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

@interface ViewController ()

@property(nonatomic,weak)XXTabBarView* tabbar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    N1 *n1 = [[N1 alloc]init];
    N2 *n2 = [[N2 alloc]init];
    N3 *n3 = [[N3 alloc]init];
    N4 *n4 = [[N4 alloc]init];
    
    n1.title = @"n1";
    n2.title = @"n2";
    n3.title = @"n3";
    n4.title = @"n4";
    
    nav *nav1 = [[nav alloc]initWithRootViewController:n1];
    nav *nav2 = [[nav alloc]initWithRootViewController:n2];
    nav *nav3 = [[nav alloc]initWithRootViewController:n3];
    nav *nav4 = [[nav alloc]initWithRootViewController:n4];
    
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
    



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    

    XXTabBarView *xxbar = [[XXTabBarView alloc]init];
    for (int i = 0; i<self.viewControllers.count; i++) {
        
        [xxbar addbottomBarButtonWithImage:[NSString stringWithFormat:@"%d",i] selected:nil];
    }
    
    xxbar.frame = self.tabBar.bounds;
    
    [self.tabBar addSubview:xxbar];
    [xxbar bringSubviewToFront:self.tabBar];

}

@end

//
//  UIBezierPath+UIBezierPath_RoundedCorners.h
//  卡片浏览器 demo
//
//  Created by 陈曦 on 16/6/2.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (UIBezierPath_RoundedCorners)

+(UIBezierPath *)IrregularRoundedCornersRightTop:(float)rightTop
                                    andRightBelow:(float)rightBelow
                                     andLeftBelow:(float)leftBelow
                                       andLeftTop:(float)leftTop
                                    andViewFrame:(CGRect)ViewFrame;


/**
 *    使用示例
 UIBezierPath *maskPath = [UIBezierPath IrregularRoundedCornersRightTop:10 andRightBelow:15 andLeftBelow:20 andLeftTop:25 andViewFrame:view2.frame];
 
 CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
 maskLayer.frame = view2.bounds;
 maskLayer.path = maskPath.CGPath;
 view2.layer.mask = maskLayer;
 */

@end

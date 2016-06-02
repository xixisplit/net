//
//  UIBezierPath+UIBezierPath_RoundedCorners.m
//  卡片浏览器 demo
//
//  Created by 陈曦 on 16/6/2.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "UIBezierPath+UIBezierPath_RoundedCorners.h"

@implementation UIBezierPath (UIBezierPath_RoundedCorners)

+(UIBezierPath *)IrregularRoundedCornersRightTop:(float)rightTop
                                    andRightBelow:(float)rightBelow
                                     andLeftBelow:(float)leftBelow
                                       andLeftTop:(float)leftTop
                                     andViewFrame:(CGRect)ViewFrame {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    //起点
    [maskPath moveToPoint:CGPointMake(ViewFrame.origin.x - leftTop, 0)];
    // 1-2 直线
    [maskPath addLineToPoint:CGPointMake(ViewFrame.size.width-rightTop, 0)];
    // 2-3 弧线 //终点//控制点
    [maskPath addQuadCurveToPoint:CGPointMake(ViewFrame.size.width, rightTop)
                     controlPoint:CGPointMake(ViewFrame.size.width, 0)];
    // 3-4 直线
    [maskPath addLineToPoint:CGPointMake(ViewFrame.size.width, ViewFrame.size.height-rightBelow)];
    // 4-5 弧线
    [maskPath addQuadCurveToPoint:CGPointMake(ViewFrame.size.width-rightBelow, ViewFrame.size.height)
                     controlPoint:CGPointMake(ViewFrame.size.width, ViewFrame.size.height)];
    // 5-6 直线
    [maskPath addLineToPoint:CGPointMake(leftBelow, ViewFrame.size.height)];
    // 6-7 弧线
    [maskPath addQuadCurveToPoint:CGPointMake(0, ViewFrame.size.height-leftBelow)
                     controlPoint:CGPointMake(0, ViewFrame.size.height)];
    // 7-8 直线
    [maskPath addLineToPoint:CGPointMake(0, leftTop)];
    // 8-1 弧线
    
    [maskPath addQuadCurveToPoint:CGPointMake(leftTop, 0)
                     controlPoint:CGPointMake(0, 0)];
    
    return maskPath;
}



@end

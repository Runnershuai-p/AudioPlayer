//
//  UIView+POPUPAnimation.m
//  ActionSheet
//
//  Created by shuai pan on 2017/3/13.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "UIView+POPUPAnimation.h"

#define CT_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define CT_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
//动画偏移量
static CGFloat offset = 0.0f;




@implementation UIView (POPUPAnimation)

//弹出view
- (void)popUpAnimationView:(CGFloat)height {
//初始位置设置
    self.frame = CGRectMake(0, CT_HEIGHT, CT_WIDTH,height);
    self.alpha = 1;
    [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGFloat animation_h = height + offset;
        CGRect frame = CGRectMake(0, CT_HEIGHT-animation_h, CT_WIDTH,animation_h);
        self.frame = frame;
    } completion:^(BOOL finished) {
        CGFloat animation_h = height ;

        CGRect frame = CGRectMake(0, CT_HEIGHT-animation_h, CT_WIDTH,animation_h);
        
        [UIView animateWithDuration:0.15f animations:^{
            self.frame = frame;
        }];
    }];
}

//关闭view
- (void)closeAnimationView{
    self.alpha = 1;
    [UIView animateWithDuration:0.15f delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGFloat animation_h = CGRectGetHeight(self.frame) + offset;
        CGRect frame = CGRectMake(0, CT_HEIGHT-animation_h, CT_WIDTH,animation_h);
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        CGFloat animation_h = CGRectGetHeight(self.frame) - offset;
        CGRect frame = CGRectMake(0, CT_HEIGHT, CT_WIDTH, animation_h);
        [UIView animateWithDuration:0.35f animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            self.frame = CGRectZero;
            self.alpha = 0;
        }];
    }];
}

@end

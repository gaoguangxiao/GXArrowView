//
//  EDMaskView.m
//  GXArrowView
//
//  Created by 高广校 on 2024/3/21.
//

#import "EDMaskView.h"

@implementation EDMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        
        
       
    }
    return self;
}

- (void)setAlphaRect:(CGRect)rect {
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.8;
    [self.layer addSublayer:fillLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:rect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    fillLayer.path = path.CGPath;
}

- (void)dealloc
{
//    NSLog(@"dealloc: %@",self);
}
@end

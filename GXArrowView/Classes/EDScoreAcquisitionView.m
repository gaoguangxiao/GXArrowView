//
//  EDScoreAcquisitionView.m
//  EarlyDetection
//
//  Created by 高广校 on 2024/4/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import "EDScoreAcquisitionView.h"
#import <GGXSwiftExtension/GGXSwiftExtension-Swift.h>
#import <Masonry/Masonry.h>
#import "UIImage+Bundle.h"
#import "EDScoreEnoughView.h"
#import <GXArrowView/GXArrowView-Swift.h>
@interface EDScoreAcquisitionView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) GXTaskDownTimer *taskTimer;
@end

@implementation EDScoreAcquisitionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)share
{
    EDScoreAcquisitionView *view = [[EDScoreAcquisitionView alloc]initWithFrame:CGRectMake(0, 0, UIDevice.width, UIDevice.height)];
//    view.frame = CGRectMake(0, 0, UIDevice.width, UIDevice.height);
    [UIApplication.rootWindow addSubview:view];
//    [view openKeyborad];
//    view.hintLabel.hidden = YES;
//    view.baseView.alpha = 0.7;
    [UIView animateWithDuration:0.3 animations:^{
//        view.baseView.alpha = 1.0;
//        [view openKeyborad];
    }];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor alloc]initWithHex:0x000000 alpha:0.75];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
        [self.bgView addGestureRecognizer:tap];
    }
    return self;
}

- (void)setContentView:(UIView *)contentView {
//-(void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
//    [self addSubview:contentView];
//    contentView.frame = rect;
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(31, 31));
        make.centerX.mas_equalTo(0);
    }];
}

- (void)setacquisitionScore:(NSString *)score vanishCount:(double)count{
    
    self.taskTimer = [GXTaskDownTimer new];
    __weak typeof(self) weakSelf = self;
    [self.taskTimer initIdleTimerWithRetaminCount:count block:^(double retain) {
//        NSLog(@"倒计时：%f",retain);
        if (retain <= 0) {
            weakSelf.taskTimer = nil;
            [weakSelf hidden];
        }
    }];
     
    if ([score integerValue] == 0) {
        //已达上限
        EDScoreEnoughView *contentView = [[EDScoreEnoughView alloc]init];
        //添加内容视图
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@51);
            make.right.equalTo(@-51);
            make.height.mas_equalTo(178);
            make.centerY.mas_equalTo(0);
        }];
        self.contentView = contentView;
        contentView.blockHidden = ^{
            //隐藏
            [weakSelf hidden];
        };
    } else {
        //有积分
        EDScoreContentView *contentView = [[EDScoreContentView alloc]init];
        //添加内容视图
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@51);
            make.right.equalTo(@-51);
            make.height.mas_equalTo(321);
            make.centerY.mas_equalTo(0);
        }];
        self.contentView = contentView;
        contentView.blockHidden = ^{
            //隐藏
            [weakSelf hidden];
        };
        [contentView setacquisitionScore:score];
    }
}
- (void)hidden {
    [self tapBackgroundClick];
}

- (void)didCloseClick {
    [self tapBackgroundClick];
}

- (void)tapBackgroundClick {
    
    if (self.bgView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
//            collectionView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        } completion:^(BOOL finished) {
//            backgroundView.hidden();
            [self removeFromSuperview];
//            backgroundView = nil;
        }];
    }
}

- (void)dealloc
{
//    NSLog(@"-dealloc%@",self);
}
/// 内容视图
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor alloc]initWithHex:0x000000 alpha:0.75];//:0x000000];
    }
    return _bgView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamedInBundle:@"ed_gx_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(didCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
//- (EDScoreContentView *)contentView {
//    if (!_contentView) {
//        _contentView = [[EDScoreContentView alloc]init];
//    }
//    return _contentView;
//}

@end

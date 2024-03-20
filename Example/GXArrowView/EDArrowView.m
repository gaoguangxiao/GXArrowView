//
//  EDArrowView.m
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import "EDArrowView.h"
#import "Masonry.h"
#import "EDPellCollectionSelect.h"
#import "EDPellselectModel.h"

#import <GXArrowView-umbrella.h>
@interface EDArrowView ()

@property (nonatomic, strong) UIButton *yearBtn;

@property (nonatomic, strong) UILabel *yearLab;

@property (nonatomic, strong) UIImageView *yearImg;
@end

@implementation EDArrowView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.yearBtn];
        [self.yearBtn addSubview:self.yearLab];
        [self.yearBtn addSubview:self.yearImg];
        
        [self.yearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [self.yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.right.mas_equalTo(self.yearImg.mas_left).offset(-5);
        }];
        
        [self.yearImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        
//        self.yearLab.text = @"2023";
    }
    return self;
}

- (void)setYearData:(NSArray *)yearData {
    _yearData = yearData;
    
    //设置默认显示
    self.yearLab.text = yearData.firstObject;
}

#pragma mark - Event Response
- (void)didYearClick:(UIButton *)sender {
    
//    [NSBundle gx_pellBundle];
//    UINib *cellnib = [UINib nibWithNibName:NSStringFromClass([EDPellselectColCell class]) bundle:[NSBundle gx_pellBundle]];
//    return;
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
        self.yearImg.transform = CGAffineTransformMakeRotation(M_PI);
        [self showPellView:sender];
    } else {
        self.yearImg.transform = CGAffineTransformIdentity;
        [self hiddenPellView];
    }
}

- (void)showPellView:(UIView *)view {
    
    NSMutableArray *pellArray = [NSMutableArray new];
    [self.yearData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EDPellselectModel *m = [EDPellselectModel new];
        m.title = obj;
//        m.isSelected = idx == 0;
        m.isSelected = [m.title isEqualToString:self.yearLab.text];
        [pellArray addObject:m];
    }];
    //展示蒙层弹框
    
    //view 以那个视图为基准 导航视图
    UIView *superView = self.superview;
    CGRect rect = [superView convertRect:superView.bounds toView:nil];
    rect.origin.y = rect.origin.y + 44;
    [EDPellCollectionSelect addPellTableViewSelectData:pellArray rect:rect action:^(EDPellselectModel * _Nonnull model) {
        self.yearBtn.selected = NO;
        self.yearLab.text = model.title;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelecteYear:)]) {
            [self.delegate didSelecteYear:model.title];
        }
    } hidden:^{
        self.yearBtn.selected = NO;
    } animated:YES];
}

- (void)hiddenPellView {
    
    [EDPellCollectionSelect hiden];
}

#pragma mark - getter
- (UIButton *)yearBtn {
    if (!_yearBtn) {
        _yearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yearBtn addTarget:self action:@selector(didYearClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _yearBtn;
}

- (UILabel *)yearLab {
    if (!_yearLab) {
        _yearLab= [[UILabel alloc]init];
        _yearLab.text = @"2024";
        _yearLab.textColor = UIColor.whiteColor;
        _yearLab.font = [UIFont systemFontOfSize:14];
    }
    return  _yearLab;
}

- (UIImageView *)yearImg {
    if (!_yearImg) {
        _yearImg = [UIImageView new];
        _yearImg.image = [UIImage imageNamed:@"eschool_polygon"];
    }
    return _yearImg;
}
@end

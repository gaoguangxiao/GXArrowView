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
            make.right.mas_equalTo(self.yearImg.mas_left);
        }];
        
        [self.yearImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
//            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        
        self.yearLab.text = @"2023";
    }
    return self;
}

//- ()

#pragma mark - Event Response
- (void)didYearClick:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
        self.yearImg.transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        self.yearImg.transform = CGAffineTransformIdentity;
    }
    
    //展示蒙层弹框
    [EDPellCollectionSelect addPellTableViewSelectWithWindowFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 300) selectData:@[@"2021",@"2022",@"2023"] locationY:100 action:^(NSInteger index) {
    
        NSLog(@"位置：%ld",index);
        
    } animated:YES];
    
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

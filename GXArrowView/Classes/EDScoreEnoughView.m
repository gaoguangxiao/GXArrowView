//
//  EDScoreEnoughView.m
//  GXArrowView
//
//  Created by 高广校 on 2024/4/22.
//

#import "EDScoreEnoughView.h"
#import <Masonry/Masonry.h>
#import <GGXSwiftExtension/GGXSwiftExtension-Swift.h>

@interface EDScoreEnoughView ()

/// 主标题
@property (nonatomic, strong) UILabel *titleLab;

/// 副标题
@property (nonatomic, strong) UILabel*subTitleLab;

/// 按钮
@property (nonatomic, strong) UIButton *okBtn;
@end

@implementation EDScoreEnoughView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 7;
        
        [self addSubview:self.titleLab];
        [self addSubview:self.subTitleLab];
        [self addSubview:self.okBtn];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(42);
//            make.left.mas_equalTo(30);
//            make.right.mas_equalTo(-30);
            make.centerX.mas_equalTo(0);
            make.height.mas_equalTo(25);
        }];
        
        [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(6);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@47);
            make.right.equalTo(@-47);
            make.height.equalTo(@48);
            make.bottom.equalTo(@-18);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setacquisitionScore:(NSString *)score {
//    self.scorelab.text = [NSString stringWithFormat:@"+%@积分",score];
//    +100积分
}

- (void)didOkClick {
 
    //关闭视图
    if (self.blockHidden) {
        self.blockHidden();
    }
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.textColor = [UIColor hex:0x201F27];
        _titleLab.text = @"今日积分已达上限!";
    }
    return _titleLab;
}
- (UILabel *)subTitleLab {
    if (!_subTitleLab) {
        _subTitleLab = [UILabel new];
        _subTitleLab.textColor = [UIColor hex:0x201F27];
        _subTitleLab.font = [UIFont systemFontOfSize:15];
        _subTitleLab.text = @"明日再来哦~";
    }
    return _subTitleLab;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"好的" forState:UIControlStateNormal];
        [_okBtn setBackgroundColor:[UIColor hex:0xCF3E2D]];
        [_okBtn addTarget:self action:@selector(didOkClick) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.layer.cornerRadius = 7;
    }
    return _okBtn;
}
@end

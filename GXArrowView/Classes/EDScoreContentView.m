//
//  EDScoreContentView.m
//  GXArrowView
//
//  Created by 高广校 on 2024/4/19.
//

#import "EDScoreContentView.h"
#import <Masonry/Masonry.h>
#import <GGXSwiftExtension/GGXSwiftExtension-Swift.h>
#import "UIImage+Bundle.h"

@interface EDScoreContentView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *scorelab;

@property (nonatomic, strong) UIButton *okBtn;

@end

@implementation EDScoreContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 7;
        
        [self addSubview:self.imageView];
        [self addSubview:self.scorelab];
        [self addSubview:self.okBtn];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(53);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.height.mas_equalTo(130);
        }];
        
        [self.scorelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(18);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@47);
            make.right.equalTo(@-47);
            make.height.equalTo(@48);
            make.bottom.equalTo(@-27);
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
    self.scorelab.text = [NSString stringWithFormat:@"+%@积分",score];
//    +100积分
}

- (void)dealloc
{
//    NSLog(@"-dealloc%@",self);
}

- (void)didOkClick {
 
    //关闭视图
    if (self.blockHidden) {
        self.blockHidden();
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamedInBundle:@"ed_gx_score"];
        _imageView.image = image;
    }
    return _imageView;
}

- (UILabel *)scorelab {
    if (!_scorelab) {
        _scorelab = [UILabel new];
        _scorelab.textColor = [UIColor hex:0xFD7720];
        _scorelab.font = [UIFont boldSystemFontOfSize:24];
    }
    return _scorelab;
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

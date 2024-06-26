//
//  EDPellCollectionSelect.m
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import "EDPellCollectionSelect.h"
#import "Masonry/Masonry.h"
#import "EDPellselectColCell.h"
#import "EDPellselectModel.h"
#import "NSBundle+Pell.h"
#import "EDMaskView.h"
#import <GGXSwiftExtension/GGXSwiftExtension-Swift.h>

@interface EDPellCollectionSelect ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,copy) NSArray <EDPellselectModel *>*selectData;

@property (nonatomic,copy) void(^action)(EDPellselectModel *model);

/// hidden
@property (nonatomic,copy) void(^hidden)(void);

@property (nonatomic, strong) UICollectionView *collectionView;

///蒙版 顶部遮罩 不透明可点击取消
@property (nonatomic, strong) EDMaskView *maskTopView;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLab;

@end

EDPellCollectionSelect * backgroundView;

@implementation EDPellCollectionSelect

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
        [self addSubview:self.maskTopView];
//        [self addSubview:self.maskView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.collectionView];
        [self.contentView addSubview:self.resetBtn];
        [self.contentView addSubview:self.confirBtn];
        
        self.maskTopView.frame = frame;

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(130);
        }];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(17);
            make.height.mas_equalTo(18);
            make.left.mas_equalTo(29);
        }];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        
        // 内容 200
        [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.collectionView.mas_bottom).offset(24);
            make.left.mas_equalTo(self.titleLab.mas_left);
            make.bottom.mas_equalTo(self.confirBtn.mas_bottom);
            make.right.mas_equalTo(self.confirBtn.mas_left).offset(-40);
            make.width.mas_equalTo(self.confirBtn.mas_width);
            make.height.mas_equalTo(self.confirBtn.mas_height);
        }];
        
        [self.confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.resetBtn.mas_top);
            make.left.mas_equalTo(self.resetBtn.mas_right).offset(40);
            make.bottom.mas_equalTo(-22);
            make.right.mas_equalTo(-33);
            make.width.mas_equalTo(self.resetBtn.mas_width);
//            make.height.mas_equalTo(33);
        }];
        
        self.selectTitleColor = [UIColor whiteColor];
        self.selectBackgroundColor = [UIColor colorFrom:@"#D13D2D" alpha:1.0];
        
        self.normalTitleColor = [UIColor colorFrom:@"#222426" alpha:1.0];
        self.normalBackgroundColor = [UIColor colorFrom:@"#EDEDED" alpha:1.0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
        [self.maskTopView addGestureRecognizer:tap];
        
    }
    return self;
}

+ (void)addPellTableViewSelectData:(NSArray *)selectData
                                       rect:(CGRect)rect
                            action:(void(^)(EDPellselectModel *model))action
                            hidden:(void(^)(void))hidden animated:(BOOL)animate
{
    if (backgroundView != nil) {
        [EDPellCollectionSelect hiden];
    }
    UIWindow *win = [UIApplication rootWindow];
    
    backgroundView = [[EDPellCollectionSelect alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.hidden  = hidden;
    backgroundView.selectData = selectData;
    [win addSubview:backgroundView];
    
    // 计算行数
    NSInteger row = backgroundView.selectData.count/4 + (backgroundView.selectData.count%4 > 0 ? 1: 0);
    // item高度 以及间距
    CGFloat contentHeight = row * 35 + (row - 1) * 10;
    // 计算总高度
    CGFloat allHeight = contentHeight + 42 + 85;
    
    [backgroundView.maskTopView setAlphaRect:CGRectMake(0, 0, win.width, rect.origin.y)];

    //高度计算
    [backgroundView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rect.origin.y);
        make.height.mas_equalTo(allHeight);
    }];
    [backgroundView.collectionView reloadData];
    
    if (animate == YES) {
        backgroundView.contentView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.contentView.alpha = 1.0;
        }];
    }
}

- (void)tapBackgroundClick
{
    [EDPellCollectionSelect hiden];
}

+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
//            collectionView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        } completion:^(BOOL finished) {
            backgroundView.hidden();
            [backgroundView removeFromSuperview];
            backgroundView = nil;
        }];
    }
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"EDPellselectColCell";
    EDPellselectColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    EDPellselectModel *model = self.selectData[indexPath.row];
    cell.pellLab.text = model.title;
    if (model.isSelected) {
        cell.pellLab.textColor = self.selectTitleColor;
        cell.pellLab.backgroundColor = self.selectBackgroundColor;
    } else {
        cell.pellLab.textColor = self.normalTitleColor;
        cell.pellLab.backgroundColor = self.normalBackgroundColor;
    }
    cell.pellLab.layer.cornerRadius = 3;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float itemWidth = (UIScreen.mainScreen.bounds.size.width - 29 * 2 - 20 * 3) / 4;
    return CGSizeMake(itemWidth, 35);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    EDPellselectModel *selectModel = self.selectData[indexPath.row];
    
    //重置 默认选择第一个
    [self.selectData enumerateObjectsUsingBlock:^(EDPellselectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([selectModel.title isEqualToString:obj.title]) {
            obj.isSelected = !obj.isSelected;
        } else {
            obj.isSelected = NO;
        }
    }];
    // 刷新
    [self.collectionView reloadData];
}

#pragma mark - Event Response
- (void)didResetClick {
    
    //重置 默认选择第一个
    [self.selectData enumerateObjectsUsingBlock:^(EDPellselectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = idx == 0;
    }];
 
    [self.collectionView reloadData];
}

- (void)didConfirClick {

    [EDPellCollectionSelect hiden];
    
    EDPellselectModel *seletedModel = nil;
    
    for (EDPellselectModel *m in self.selectData) {
        if (m.isSelected) {
            seletedModel = m;
            break;
        }
    }
    self.action(seletedModel);
}

/// 内容视图
#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView){
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        flowLayout.headerReferenceSize = CGSizeMake(mainscreenwidth, 0);//头部
//        flowLayout.footerReferenceSize = CGSizeMake(mainscreenwidth, 30);
        _collectionView= [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 100) collectionViewLayout:flowLayout];
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;

        _collectionView.backgroundColor = [UIColor whiteColor];

        _collectionView.contentInset = UIEdgeInsetsMake(0, 29, 0, 29);
    
        UINib *cellnib = [UINib nibWithNibName:NSStringFromClass([EDPellselectColCell class]) bundle:[NSBundle gx_pellBundle]];
        [_collectionView registerNib:cellnib forCellWithReuseIdentifier:@"EDPellselectColCell"];
    }
    return _collectionView;
}

- (EDMaskView *)maskTopView {
    if (!_maskTopView) {
        _maskTopView = [EDMaskView new];
    }
    return _maskTopView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"年份: ";
        _titleLab.font = [UIFont boldSystemFontOfSize:13];
//        _titleLab.textColor = [UIColor crazy_hex:@"#222426"];
    }
    return _titleLab;
}
- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[[UIColor alloc]initWithHex:@"#919192" :1.0] forState:UIControlStateNormal];
        _resetBtn.layer.cornerRadius = 3;
        [_resetBtn setBackgroundColor:[UIColor colorFrom:@"#EDEDED" alpha:1.0]];//:EDEDED]];//crazy_hex:@"#EDEDED"]];
        [_resetBtn addTarget:self action:@selector(didResetClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _resetBtn;
}

- (UIButton *)confirBtn {
    if (!_confirBtn) {
        _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _confirBtn.layer.cornerRadius = 3;
        [_confirBtn setBackgroundColor:[UIColor colorFrom:@"#D13D2D" alpha:1.0]];
        [_confirBtn addTarget:self action:@selector(didConfirClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirBtn;
}
@end

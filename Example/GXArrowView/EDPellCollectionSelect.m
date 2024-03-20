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

@interface EDPellCollectionSelect ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,copy) NSArray *selectData;
@property (nonatomic,copy) void(^action)(NSInteger index);

@property (nonatomic, strong) UICollectionView *collectionView;

//重置
@property (nonatomic, strong) UIButton *resetBtn;
//取消
@property (nonatomic, strong) UIButton *confirBtn;
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
        [self addSubview:self.resetBtn];
        
        //colliew
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //    flowLayout.headerReferenceSize = CGSizeMake(mainscreenwidth, 0);//头部
    //    flowLayout.footerReferenceSize = CGSizeMake(mainscreenwidth, 30);
        
        CGFloat height = 300;
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        [self addSubview:self.collectionView];
        
        UINib *cellnib = [UINib nibWithNibName:NSStringFromClass([EDPellselectColCell class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:cellnib forCellWithReuseIdentifier:@"EDPellselectColCell"];
        
        // 内容 200

        
        //设置代理
        self.collectionView.delegate = backgroundView;
        self.collectionView.dataSource = backgroundView;
        self.collectionView.showsVerticalScrollIndicator=NO;
    }
    return self;
}

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       locationY:(CGFloat)locationY
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate
{
    if (backgroundView != nil) {
        [EDPellCollectionSelect hiden];
    }
    UIWindow *win = [self getKeyWindow];
    
    backgroundView = [[EDPellCollectionSelect alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    [win addSubview:backgroundView];
    

//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(win).offset(locationY);
//        make.left.equalTo(win).offset(frame.origin.x);
//        make.width.equalTo(@(frame.size.width));
//        make.height.equalTo(@(height));
//    }];
    
    
    //other
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
 
       
    if (animate == YES) {
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
          backgroundView.alpha = 0.5;
//           collectionView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}

+ (void)tapBackgroundClick
{
    [EDPellCollectionSelect hiden];
}

+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
//            UIWindow * win = [[[UIApplication sharedApplication] windows] firstObject];
//            tableView.frame = CGRectMake(win.bounds.size.width - 35 , 64, 0, 0);
//            collectionView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        } completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
//            [collectionView removeFromSuperview];
//            collectionView = nil;
            backgroundView = nil;
        }];
    }
   
}

+ (UIWindow*) getKeyWindow
{
    if(@available(iOS 13.0, *)) {
        for(UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
            if(scene.activationState == UISceneActivationStateForegroundActive) {
                if(@available(iOS 15.0, *)) {
                    return scene.keyWindow;
                }else{
                    for(UIWindow* window in scene.windows) {
                        if(window.isKeyWindow) {
                            return window;
                        }
                    }
                }
            }
        }
    }else{
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
//}
//定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"EDPellselectColCell";
    EDPellselectColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.pellLab.text = @"1221年";
//    if (self.type == EQuestionPeriodsEnter) {
//        cell.model = self.periodsModel.guest[indexPath.item];
//    }else
//    {
//        cell.model = self.talkModel.expertList[indexPath.item];
//    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //展示四个
    return CGSizeMake(collectionView.frame.size.width/4, 35);
    
}
//定义每个UICollectionView 的间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//    
//}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

/// 内容视图
#pragma mark - getter
//- (UICollectionView *)collectionView
//{
//    if (!_collectionView){
//        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        flowLayout.headerReferenceSize = CGSizeMake(mainscreenwidth, 0);//头部
//        flowLayout.footerReferenceSize = CGSizeMake(mainscreenwidth, 30);
//        UICollectionView  *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainscreenwidth, mainscreenhight-NAVIGATIONBAR_HEIGHT-SAFEBOTTOMAREA_HEIGHT) collectionViewLayout:flowLayout];
//        [self addSubview:collectionView];
//        //设置代理
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.showsVerticalScrollIndicator=NO;
//        
//        collectionView.backgroundColor = [UIColor whiteColor];
//        
//        //注册cell和ReusableView（相当于头部）
//        UINib *cellnib = [UINib nibWithNibName:NSStringFromClass([EQuestionSubmitImgCell class]) bundle:[NSBundle mainBundle]];
//        [collectionView registerNib:cellnib forCellWithReuseIdentifier:@"EQuestionSubmitImgCell"];
//        
//        
//        _collectionView = collectionView;
//        
//    }
//    return _collectionView;
//}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    }
    return  _resetBtn;
}

- (UIButton *)confirBtn {
    if (!_confirBtn) {
        _confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        
    }
    return _confirBtn;
}
@end

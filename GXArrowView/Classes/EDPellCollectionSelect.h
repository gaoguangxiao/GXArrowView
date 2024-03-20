//
//  EDPellCollectionSelect.h
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EDPellselectModel;

NS_ASSUME_NONNULL_BEGIN

@interface EDPellCollectionSelect : UIView

+ (void)addPellTableViewSelectData:(NSArray *)selectData
                                       rect:(CGRect)rect
                            action:(void(^)(EDPellselectModel *model))action
                            hidden:(void(^)(void))hidden animated:(BOOL)animate;

//重置
@property (nonatomic, strong) UIButton *resetBtn;
//取消
@property (nonatomic, strong) UIButton *confirBtn;

@property (nonatomic, strong) UIColor *selectBackgroundColor;

@property (nonatomic, strong) UIColor *selectTitleColor;

@property (nonatomic, strong) UIColor *normalBackgroundColor;

@property (nonatomic, strong) UIColor *normalTitleColor;

/// 隐藏
+ (void)hiden;
@end

NS_ASSUME_NONNULL_END

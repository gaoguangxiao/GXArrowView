//
//  EDScoreAcquisitionView.h
//  EarlyDetection
//
//  Created by 高广校 on 2024/4/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDScoreContentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EDScoreAcquisitionView : UIView

+ (instancetype)share;

- (void)hidden;

@property (nonatomic, strong) UIView *contentView;

/// 获得的积分
/// - Parameter score: <#score description#>
- (void)setacquisitionScore:(NSString *)score vanishCount:(double)count;

@end

NS_ASSUME_NONNULL_END



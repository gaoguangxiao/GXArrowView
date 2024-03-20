//
//  EDArrowView.h
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EDArrowViewDelegate <NSObject>

- (void)didSelecteYear:(NSString *)year;

@end

@interface EDArrowView : UIView

@property (nonatomic, weak) id<EDArrowViewDelegate>delegate;
/// 年份数据
@property (nonatomic, copy) NSArray *yearData;
@end

NS_ASSUME_NONNULL_END

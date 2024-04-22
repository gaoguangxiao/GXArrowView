//
//  EDScoreContentView.h
//  GXArrowView
//
//  Created by 高广校 on 2024/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDScoreContentView : UIView


/// 获得的积分
/// - Parameter score: <#score description#>
- (void)setacquisitionScore:(NSString *)score;

@property (nonatomic, copy) void(^blockHidden)(void);
@end

NS_ASSUME_NONNULL_END

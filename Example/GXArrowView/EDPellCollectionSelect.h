//
//  EDPellCollectionSelect.h
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EDPellCollectionSelect : UIView

+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       locationY:(CGFloat)locationY
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animate;

@end

NS_ASSUME_NONNULL_END

//
//  EDPellselectModel.h
//  EarlyDetection
//
//  Created by 高广校 on 2024/3/19.
//  Copyright © 2024 BYSD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define Color_UnS [UIColor crazy_hex:@"#EDEDED"]

@interface EDPellselectModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END

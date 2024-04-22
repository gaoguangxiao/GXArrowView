//
//  UIImage+Bundle.m
//  GXArrowView
//
//  Created by 高广校 on 2024/4/19.
//

#import "UIImage+Bundle.h"
#import <GGXSwiftExtension/GGXSwiftExtension-Swift.h>

@implementation UIImage (Bundle)

+ (UIImage *)imageNamedInBundle:(NSString *)name {    
    NSBundle *bundle = [NSBundle resourceBunldeWithBundleName:@"GXArrowView"];
    if (@available(iOS 13.0, *)) {
        return [UIImage imageNamed:name inBundle:bundle withConfiguration:nil];
    } else {
        // Fallback on earlier versions
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    }
}
@end

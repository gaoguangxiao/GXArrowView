//
//  NSBundle+Pell.m
//  GXArrowView
//
//  Created by 高广校 on 2024/3/20.
//

#import "NSBundle+Pell.h"

@implementation NSBundle (Pell)

+ (NSBundle *)gx_pellBundle {
    NSString *bundleName = @"GXArrowView";
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resource_bundle = [NSBundle mainBundle];
    if (bundleURL) {
        resource_bundle = [NSBundle bundleWithURL:bundleURL];
    }else{
        //找Frameworks
        bundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        //找仓库framework位置
        bundleURL = [bundleURL URLByAppendingPathComponent:bundleName];
        bundleURL = [bundleURL URLByAppendingPathExtension:@"framework"];
        //找bundle位置
        //实例bunble对象
        NSBundle *moduleBundle = [NSBundle bundleWithURL:bundleURL];
        if (moduleBundle) {
            return moduleBundle;
        }
    }
    NSURL *url = [resource_bundle URLForResource:@"TZImagePickerController" withExtension:@"bundle"];
    NSBundle *tziImageResource = [NSBundle bundleWithURL:url];
    return tziImageResource;
}

@end

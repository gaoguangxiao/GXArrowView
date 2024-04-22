//
//  GGXViewController.m
//  GXArrowView
//
//  Created by gaoguangxiao125@sina.com on 03/19/2024.
//  Copyright (c) 2024 gaoguangxiao125@sina.com. All rights reserved.
//

#import "GGXViewController.h"
#import "EDArrowView.h"
#import "GXArrowView/GXArrowView-umbrella.h"
#import <Masonry.h>
@interface GGXViewController ()

@end

@implementation GGXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //增加年度筛选
//    EDArrowView *arrowView = [[EDArrowView alloc]init];
//    // 2024 最近20年获取的数组
//    NSMutableArray *years = [NSMutableArray new];
//    for (NSInteger i = 2024; i > 2000; i--) {
//        [years addObject:[NSString stringWithFormat:@"%ld",i]];
//    }
//    arrowView.yearData = years;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowView];
 
    //积分弹框
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"积分" style:UIBarButtonItemStyleDone target:self action:@selector(testScore)];
}

- (void)testScore {
    EDScoreAcquisitionView *view = [EDScoreAcquisitionView share];
    [view setacquisitionScore:@"100" vanishCount:3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


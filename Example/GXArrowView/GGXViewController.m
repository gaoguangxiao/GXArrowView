//
//  GGXViewController.m
//  GXArrowView
//
//  Created by gaoguangxiao125@sina.com on 03/19/2024.
//  Copyright (c) 2024 gaoguangxiao125@sina.com. All rights reserved.
//

#import "GGXViewController.h"
#import "EDArrowView.h"
@interface GGXViewController ()

@end

@implementation GGXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"ad");
    //增加年度筛选
    EDArrowView *arrowView = [[EDArrowView alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:arrowView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

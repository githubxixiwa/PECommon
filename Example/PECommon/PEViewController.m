//
//  PEViewController.m
//  PECommon
//
//  Created by 838600214@qq.com on 11/10/2020.
//  Copyright (c) 2020 838600214@qq.com. All rights reserved.
//

#import "PEViewController.h"
#import "PECommon.h"

@interface PEViewController ()

@end

@implementation PEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIViewController *vc = self.view.viewController;
    self.view.width = kScreenWidth;
    self.view.backgroundColor = PEHexColor(@"#666666");
    self.view.backgroundColor = PERandomColor;
    PEWeakify(self)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

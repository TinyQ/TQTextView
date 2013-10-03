//
//  TQViewController.m
//  TQTextViewDemo
//
//  Created by fuqiang on 13-10-3.
//  Copyright (c) 2013年 fuqiang. All rights reserved.
//

#import "TQViewController.h"
#import "TQTextView.h"

@interface TQViewController ()

@end

@implementation TQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TQTextView *textView = [[TQTextView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    textView.placeholder = @"请输入内容";
    textView.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:textView];
}

@end

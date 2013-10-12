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
    self.view.backgroundColor = [UIColor grayColor];
    
    TQTextView *textView = [[TQTextView alloc] initWithFrame:CGRectMake(0, 40, 320, 200)];
    textView.placeholder = @"请输入内容";
    textView.font = [UIFont systemFontOfSize:16];
    textView.maxTextLength = 11;
    [self.view addSubview:textView];
}

@end

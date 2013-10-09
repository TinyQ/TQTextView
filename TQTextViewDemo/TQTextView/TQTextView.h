//
//  TQTextView.h
//  TQTextViewDemo
//
//  Created by fuqiang on 13-10-3.
//  Copyright (c) 2013年 fuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQTextView : UITextView

@property (nonatomic, copy)         NSString   *placeholder;            // default is nil.
@property (nonatomic, strong)       UIColor    *placeholderColor;       // default is [UIColor grayColor];.
@property (nonatomic)               CGPoint     placeholderPoint;       // default is (8,8)
@property (nonatomic)               NSInteger   maxTextLength;          // default is 0.

@end

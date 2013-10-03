//
//  TQTextView.m
//  TQTextViewDemo
//
//  Created by fuqiang on 13-10-3.
//  Copyright (c) 2013年 fuqiang. All rights reserved.
//

#import "TQTextView.h"

@implementation TQTextView

- (id)init
{
    self = [super init];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if (self.text.length == 0 && ([[self placeholder] length] != 0))
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);
        CGRect rect = CGRectMake(8, 8, self.bounds.size.width, 20);
        
        [self.placeholder drawInRect:rect withFont:self.font];
    }
}

- (void)addTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    [self setNeedsDisplay];
}

@end

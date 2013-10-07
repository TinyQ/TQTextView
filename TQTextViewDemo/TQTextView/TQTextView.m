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
    [self removeTextChangeObserver];
}

- (void)addTextChangeObserver
{
    self.placeholderColor = [UIColor grayColor];
    self.placeholderPoint = CGPointMake(8, 8);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)removeTextChangeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if ([[self text] length] == 0 && ([[self placeholder] length] != 0))
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
        CGRect rect = CGRectMake(self.placeholderPoint.x, self.placeholderPoint.y, self.bounds.size.width, self.font.lineHeight);

        [self.placeholder drawInRect:rect withFont:self.font];
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self textChanged:nil];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self textChanged:nil];
}

- (void)setPlaceholderPoint:(CGPoint)placeholderPoint
{
    _placeholderPoint = placeholderPoint;
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if(([[self placeholder] length] == 0) || ([[self text] length] > 1))
    {
        return;
    }
    
    [self setNeedsDisplay];
}

@end

//
//  TQTextView.m
//  TQTextViewDemo
//
//  Created by fuqiang on 13-10-3.
//  Copyright (c) 2013年 fuqiang. All rights reserved.
//

#import "TQTextView.h"

#define OSVersionIsAtLeastiOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

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
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIFont *font = self.placeholderFont ? self.placeholderFont : self.font;
    
    if (self.placeholder && self.placeholder.length > 0 && self.text.length == 0)
    {
        CGRect rect = CGRectMake(self.placeholderPoint.x,
                                 self.placeholderPoint.y,
                                 self.bounds.size.width - self.placeholderPoint.x,
                                 self.bounds.size.height - self.placeholderPoint.y);
        if (OSVersionIsAtLeastiOS7)
        {
            NSDictionary* attributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:self.placeholderColor};
            [self.placeholder drawInRect:rect withAttributes:attributes];
        }
        else
        {
            CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
            [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
        }
    }
}

#pragma mark - Set Method

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderPoint:(CGPoint)placeholderPoint
{
    _placeholderPoint = placeholderPoint;
    
    [self setNeedsDisplay];
}

- (void)textChanged:(NSNotification *)notification
{
    if (self.placeholder.length != 0)
    {
        [self setNeedsDisplay];
    }
}

@end

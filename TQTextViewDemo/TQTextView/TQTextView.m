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
    self.maxTextLength    = 0;
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
    
    //placeholder
    if (([[self text] length] == 0) && ([[self placeholder] length] != 0))
    {
        CGContextSetFillColorWithColor(context, self.placeholderColor.CGColor);
        CGRect rect = CGRectMake(self.placeholderPoint.x, self.placeholderPoint.y, self.bounds.size.width - self.placeholderPoint.x, self.bounds.size.height - self.placeholderPoint.y);
        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    if (self.maxTextLength > 0)
    {
        UIFont *font = [UIFont systemFontOfSize:17];
        NSInteger i = self.maxTextLength - [[self text] length];
        NSString *lengthStr = [NSString stringWithFormat:@"%d",i];
        CGSize size =  [lengthStr sizeWithFont:font];
        CGRect rect = CGRectMake(self.bounds.size.width - size.width - 10 , self.bounds.size.height - font.lineHeight, size.width, font.lineHeight);
        UIColor *color = i < 0 ? [UIColor redColor] : [UIColor grayColor];
        CGContextSetFillColorWithColor(context, color.CGColor);
        
        [lengthStr drawInRect:rect withFont:font];
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

- (void)setMaxTextLength:(NSInteger)maxTextLength
{
    _maxTextLength = maxTextLength;
    
    [self textChanged:nil];
}

- (void)textChanged:(NSNotification *)notification
{
    if (self.maxTextLength > 0 || ([[self placeholder] length] != 0))
    {
        [self setNeedsDisplay];
    }
}

@end

//
//  BingoTile.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//



#import "BingoTile.h"
#import <QuartzCore/QuartzCore.h>

@implementation BingoTile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    
        self.songText = [[UITextView alloc] init];
        self.songText.delegate = self;
        [self.songText setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.songText setFont:[UIFont systemFontOfSize:10.0]];
        self.songText.textColor = [UIColor lightGrayColor];
        self.songText.backgroundColor = [UIColor clearColor];
        self.songText.tag = 1;
        self.songText.text = SONG_PLACEHOLDER_TEXT;
        self.songText.textAlignment = NSTextAlignmentCenter;
        self.songText.scrollEnabled = NO;
        self.songText.autocorrectionType = UITextAutocorrectionTypeNo;
        
        self.artistText = [[UITextView alloc] init];
        self.artistText.delegate = self;
        [self.artistText setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.artistText setFont:[UIFont systemFontOfSize:10.0]];
        self.artistText.textColor = [UIColor lightGrayColor];
        self.artistText.backgroundColor = [UIColor clearColor];
        self.artistText.tag = 2;
        self.artistText.textAlignment = NSTextAlignmentCenter;
        self.artistText.text = ARTIST_PLACEHOLDER_TEXT;
        self.artistText.scrollEnabled = NO;
        self.artistText.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [self addSubview:self.songText];
        [self addSubview:self.artistText];
        
        NSDictionary *layoutviews = NSDictionaryOfVariableBindings(_artistText, _songText);
        
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[_artistText]-2-|" options:0 metrics:0 views:layoutviews]];
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[_songText]-2-|" options:0 metrics:0 views:layoutviews]];
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_songText]-0-[_artistText]-2-|" options:0 metrics:nil views:layoutviews]];

        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.songText
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.artistText
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                      constant:0.0]];
        
        CGColorRef redBorderColor = CGColorRetain([[UIColor redColor] CGColor] );
        self.layer.borderColor = redBorderColor;
        self.layer.borderWidth = 1.0;
    }
    return self;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([@"\n" isEqualToString:text]) {
      [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextFieldStarted" object:self userInfo:nil];
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor redColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    [self updateTextViewText:textView];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [self updateTextViewText:textView];
    return YES;
}

-(void) updateTextViewText:(UITextView*)textView {
    
    [textView setEditable:YES];
    if(textView.text.length == 0 || [textView.text isEqualToString:SONG_PLACEHOLDER_TEXT] || [textView.text isEqualToString:ARTIST_PLACEHOLDER_TEXT]){
        textView.textColor = [UIColor lightGrayColor];
        if(textView.tag == 1) {
            self.songText.text = SONG_PLACEHOLDER_TEXT;
        } else {
            self.artistText.text = ARTIST_PLACEHOLDER_TEXT;
        }
        [textView resignFirstResponder];
    } else {
        textView.textColor = [UIColor redColor];
    }
}


@end

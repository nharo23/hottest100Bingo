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
        self.backgroundColor = [UIColor whiteColor];
        
        self.artistText = [[UITextField alloc] init];
        self.artistText.delegate = self;
        self.artistText.backgroundColor = [UIColor greenColor];
        [self.artistText setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.artistText setFont:[UIFont systemFontOfSize:10.0]];
        
        self.songText = [[UITextField alloc] init];
        self.songText.delegate = self;
        [self.songText setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.songText.backgroundColor = [UIColor purpleColor];
        self.songText.backgroundColor = [UIColor purpleColor];
        
        [self addSubview:self.artistText];
        [self addSubview:self.songText];
        
        NSDictionary *layoutviews = NSDictionaryOfVariableBindings(_artistText, _songText);
        
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_artistText]-5-|" options:0 metrics:0 views:layoutviews]];
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_songText]-5-|" options:0 metrics:0 views:layoutviews]];
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_artistText]-3-[_songText]-3-|" options:0 metrics:nil views:layoutviews]];

        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.songText
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.artistText
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                      constant:0.0]];
        
        self.layer.borderWidth = 1.0;
//        self.layer setBorderColor:<#(CGColorRef)#>
    }
    return self;
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    return YES;
//}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end

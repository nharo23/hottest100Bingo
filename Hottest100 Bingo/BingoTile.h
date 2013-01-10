//
//  BingoTile.h
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//
#define TILE_WIDTH MIN((SCREEN_WIDTH/4.2),(SCREEN_HEIGHT/4.2))
#define TILE_HEIGHT MIN((SCREEN_WIDTH/4.2),(SCREEN_HEIGHT/4.2))

#define SONG_PLACEHOLDER_TEXT @"Enter song name"
#define ARTIST_PLACEHOLDER_TEXT @"Enter artist name"

#import <UIKit/UIKit.h>

@interface BingoTile : UIView <UITextViewDelegate, UIGestureRecognizerDelegate>

@property(nonatomic,strong) UITextView *artistText;
@property(nonatomic, strong) UITextView *songText;
@property(nonatomic, strong) UIImageView *crossedOutImage;

-(void) updateTextViewText:(UITextView*)textView;

-(void) toggleXImage;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;

@end

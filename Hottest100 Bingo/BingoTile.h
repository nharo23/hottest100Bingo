//
//  BingoTile.h
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//
#define TILE_WIDTH MIN((SCREEN_WIDTH/4.2),(SCREEN_HEIGHT/4.2))
#define TILE_HEIGHT MIN((SCREEN_WIDTH/4.2),(SCREEN_HEIGHT/4.2))

#import <UIKit/UIKit.h>

@interface BingoTile : UIView <UITextFieldDelegate>

@property(nonatomic,strong) UITextField *artistText;
@property(nonatomic, strong) UITextField *songText;


@end

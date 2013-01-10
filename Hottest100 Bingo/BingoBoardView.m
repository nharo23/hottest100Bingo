//
//  BingoBoardView.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 10/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//

#import "BingoBoardView.h"
#import "BingoTile.h"
#define NUMBER_OF_TILES 16
#define BINGO_MARGIN 8

@implementation BingoBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBoard];
        [self setupOneTwoThree];
    }
    return self;
}

-(void) setupBoard {
    for (int i = 0; i < NUMBER_OF_TILES; i++) {
        
        int tableXPos =((fmodf(i, 4)*TILE_WIDTH) + BINGO_MARGIN);
        int tableYPos =((floor(i / 4)*TILE_HEIGHT) + BINGO_MARGIN);
        BingoTile *bingoTile = [[BingoTile alloc] initWithFrame:CGRectMake(tableXPos, tableYPos, TILE_WIDTH, TILE_HEIGHT)];
        [self addSubview:bingoTile];
    }
}
-(void) setupOneTwoThree {
    UITextField* numberOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 380, 320, 12)];
    numberOneTextField.delegate = self;
    numberOneTextField.backgroundColor = [UIColor yellowColor];
    
    UITextField* numberTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 400, 320, 12)];
    numberTwoTextField.delegate = self;
    numberTwoTextField.backgroundColor = [UIColor blueColor];
    
    UITextField* numberThreeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 420, 320, 12)];
    numberThreeTextField.delegate = self;
    numberThreeTextField.backgroundColor = [UIColor grayColor];
    
    [self addSubview:numberOneTextField];
    [self addSubview:numberTwoTextField];
    [self addSubview:numberThreeTextField];
    
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextFieldStarted" object:self userInfo:nil];
    NSLog(@"Rob");
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


@end

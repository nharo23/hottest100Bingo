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

#define NUMBER_ONE_HINT @"Enter your number one prediction"
#define NUMBER_TWO_HINT @"Enter your number two prediction"
#define NUMBER_THREE_HINT @"Enter your number three prediction"

@interface BingoBoardView()
@property UITextField* numberOneTextField;
@property UITextField* numberTwoTextField;
@property UITextField* numberThreeTextField;
@end

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
    self.numberOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 340, 280, 30)];
    self.numberOneTextField.delegate = self;
    self.numberOneTextField.textAlignment = NSTextAlignmentCenter;
    self.numberOneTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberOneTextField.text = NUMBER_ONE_HINT;
    self.numberOneTextField.textColor = [UIColor lightGrayColor];
    self.numberOneTextField.tag = 2;
    
    self.numberTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 380, 280, 30)];
    self.numberTwoTextField.delegate = self;
    self.numberTwoTextField.textAlignment = NSTextAlignmentCenter;
    self.numberTwoTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberTwoTextField.text = NUMBER_TWO_HINT;
    self.numberTwoTextField.textColor = [UIColor lightGrayColor];
    self.numberTwoTextField.tag = 3;
    
    self.numberThreeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 420, 280, 30)];
    self.numberThreeTextField.textAlignment = NSTextAlignmentCenter;
    self.numberThreeTextField.delegate = self;
    self.numberThreeTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberThreeTextField.text = NUMBER_THREE_HINT;
    self.numberThreeTextField.textColor = [UIColor lightGrayColor];
    self.numberThreeTextField.tag = 4;
    
    [self addSubview:self.numberOneTextField];
    [self addSubview:self.numberTwoTextField];
    [self addSubview:self.numberThreeTextField];
    
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TextFieldStarted" object:self userInfo:nil];

    if (textField.textColor == [UIColor lightGrayColor]) {
        textField.text = @"";
        textField.textColor = [UIColor redColor];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self updateTextFieldText:textField];
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

//
//-(void) textViewDidChange:(UITextView *)textView
//{
//    [self updateTextViewText:textView];
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
//    [self updateTextViewText:textView];
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
    if([@"\n" isEqualToString:string]) {
        [textField resignFirstResponder];
        return NO;
    }
//        else {
//        textField.text = string
//        [self updateTextFieldText:textField];
//    }
    
    return YES;
}



-(void) updateTextFieldText:(UITextField*)textField {
    if(textField.text.length == 0){
        textField.textColor = [UIColor lightGrayColor];
        if(textField.tag == 2) {
            self.numberOneTextField.text = NUMBER_ONE_HINT;
        } if(textField.tag == 3) {
            self.numberTwoTextField.text = NUMBER_TWO_HINT;
        } else if(textField.tag == 4)  {
            self.numberTwoTextField.text = NUMBER_THREE_HINT;
        }
    }
}



@end

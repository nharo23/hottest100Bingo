//
//  BingoBoardView.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 10/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//

#import "BingoBoardView.h"
#import "BingoTile.h"
#import <QuartzCore/QuartzCore.h>

#define NUMBER_OF_TILES 16
#define BINGO_X_MARGIN 8
#define BINGO_Y_MARGIN 40

#define NUMBER_ONE_HINT @"Enter your number one prediction"
#define NUMBER_TWO_HINT @"Enter your number two prediction"
#define NUMBER_THREE_HINT @"Enter your number three prediction"

@interface BingoBoardView()
@property (nonatomic,strong) UITextField* numberOneTextField;
@property (nonatomic,strong) UITextField* numberTwoTextField;
@property (nonatomic,strong) UITextField* numberThreeTextField;

@property (nonatomic,strong) UIButton* saveButton;
@property (nonatomic,strong) UIButton* rulesButton;
@property (nonatomic,strong) UIButton* linkButton;

@property BOOL isBoardSaved;
@end

@implementation BingoBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupHeading];
        [self setupBoard];
        [self setupOneTwoThree];
    }
    return self;
}
-(void) setupHeading {
    UITextField* heading = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 320, 30)];
    heading.text = @"HOTTEST 100 BINGO";
    heading.textColor = [UIColor redColor];
    heading.textAlignment = NSTextAlignmentCenter;
    [heading setFont:[UIFont boldSystemFontOfSize:26.0]];
    [self addSubview:heading];
}

-(void) setupBoard {
    for (int i = 0; i < NUMBER_OF_TILES; i++) {
        
        int tableXPos =((fmodf(i, 4)*TILE_WIDTH) + BINGO_X_MARGIN);
        int tableYPos =((floor(i / 4)*TILE_HEIGHT) + BINGO_Y_MARGIN);
        BingoTile *bingoTile = [[BingoTile alloc] initWithFrame:CGRectMake(tableXPos, tableYPos, TILE_WIDTH, TILE_HEIGHT)];
        [self addSubview:bingoTile];
    }
}
-(void) setupOneTwoThree {
    self.numberOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 350, 280, 20)];
    self.numberOneTextField.delegate = self;
    self.numberOneTextField.textAlignment = NSTextAlignmentCenter;
    self.numberOneTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberOneTextField.text = NUMBER_ONE_HINT;
    self.numberOneTextField.textColor = [UIColor lightGrayColor];
    self.numberOneTextField.tag = 2;
    self.numberOneTextField.layer.borderWidth = 1.0;
    
    self.numberTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 375, 280, 20)];
    self.numberTwoTextField.delegate = self;
    self.numberTwoTextField.textAlignment = NSTextAlignmentCenter;
    self.numberTwoTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberTwoTextField.text = NUMBER_TWO_HINT;
    self.numberTwoTextField.textColor = [UIColor lightGrayColor];
    self.numberTwoTextField.tag = 3;
    self.numberTwoTextField.layer.borderWidth = 1.0;
    
    self.numberThreeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 400, 280, 20)];
    self.numberThreeTextField.textAlignment = NSTextAlignmentCenter;
    self.numberThreeTextField.delegate = self;
    self.numberThreeTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberThreeTextField.text = NUMBER_THREE_HINT;
    self.numberThreeTextField.textColor = [UIColor lightGrayColor];
    self.numberThreeTextField.tag = 4;
    self.numberThreeTextField.layer.borderWidth = 1.0;
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = CGRectMake(20, 430, 70, 20);
    [self.saveButton addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.saveButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
    
    self.rulesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rulesButton.frame =  CGRectMake(120, 430, 70, 20);
    [self.rulesButton addTarget:self action:@selector(rulesButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.rulesButton setTitle:@"Rules" forState:UIControlStateNormal];
    [self.rulesButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
    
    self.linkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.linkButton.frame = CGRectMake(210, 430, 70, 20);
    [self.linkButton setTitle:@"Song List" forState:UIControlStateNormal];
    [self.linkButton addTarget:self action:@selector(linkButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.linkButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];

    
    [self addSubview:self.numberOneTextField];
    [self addSubview:self.numberTwoTextField];
    [self addSubview:self.numberThreeTextField];
    
    [self addSubview:self.saveButton];
    [self addSubview:self.rulesButton];
    [self addSubview:self.linkButton];
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; {
    if([@"\n" isEqualToString:string]) {
        [textField resignFirstResponder];
        return NO;
    }
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

-(void) saveButtonTapped {

}

-(void) rulesButtonTapped {
    
}

-(void) linkButtonTapped {
    
}



@end

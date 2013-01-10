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
#import "AppDelegate.h"

#define NUMBER_OF_TILES 16
#define BINGO_X_MARGIN 8
#define BINGO_Y_MARGIN 40

#define NUMBER_ONE_HINT @"Enter your number one prediction"
#define NUMBER_TWO_HINT @"Enter your number two prediction"
#define NUMBER_THREE_HINT @"Enter your number three prediction"
#define TITLE_TEXT @"HOTTEST 100 BINGO";

@interface BingoBoardView()
@property (nonatomic,strong) UITextField* numberOneTextField;
@property (nonatomic,strong) UITextField* numberTwoTextField;
@property (nonatomic,strong) UITextField* numberThreeTextField;

@property (nonatomic,strong) UIButton* saveButton;
@property (nonatomic,strong) UIButton* rulesButton;
@property (nonatomic,strong) UIButton* linkButton;

@property (nonatomic, strong) NSMutableArray* dataArray;

@end

@implementation BingoBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = [[NSMutableArray alloc] init];
        [self loadData];
        [self setupHeading];
        [self setupBoard];
        [self setupOneTwoThree];
        [self applySavedDate];
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
        UIGestureRecognizer *singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(bingoTileTapped)];
        [bingoTile addGestureRecognizer:singleTap];
        bingoTile.userInteractionEnabled = YES;
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
    self.numberOneTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.numberTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 375, 280, 20)];
    self.numberTwoTextField.delegate = self;
    self.numberTwoTextField.textAlignment = NSTextAlignmentCenter;
    self.numberTwoTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberTwoTextField.text = NUMBER_TWO_HINT;
    self.numberTwoTextField.textColor = [UIColor lightGrayColor];
    self.numberTwoTextField.tag = 3;
    self.numberTwoTextField.layer.borderWidth = 1.0;
    self.numberTwoTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.numberThreeTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 400, 280, 20)];
    self.numberThreeTextField.textAlignment = NSTextAlignmentCenter;
    self.numberThreeTextField.delegate = self;
    self.numberThreeTextField.backgroundColor = [UIColor colorWithRed:0.992 green:0.949 blue:0.82 alpha:1.0];
    self.numberThreeTextField.text = NUMBER_THREE_HINT;
    self.numberThreeTextField.textColor = [UIColor lightGrayColor];
    self.numberThreeTextField.tag = 4;
    self.numberThreeTextField.layer.borderWidth = 1.0;
    self.numberThreeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.saveButton.frame = CGRectMake(20, 430, 80, 20);
    [self.saveButton addTarget:self action:@selector(saveButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.saveButton setTitle:[(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved] ? @"Edit Board" :@"Start Game!" forState:UIControlStateNormal];
    [self.saveButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
    
    self.rulesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rulesButton.frame =  CGRectMake(120, 430, 80, 20);
    [self.rulesButton addTarget:self action:@selector(rulesButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.rulesButton setTitle:@"Rules" forState:UIControlStateNormal];
    [self.rulesButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0f]];
    
    self.linkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.linkButton.frame = CGRectMake(220, 430, 80, 20);
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
    if(textField.text.length == 0 || [textField.text isEqualToString:NUMBER_ONE_HINT] || [textField.text isEqualToString:NUMBER_TWO_HINT] || [textField.text isEqualToString:NUMBER_THREE_HINT]){
        textField.textColor = [UIColor lightGrayColor];
        if(textField.tag == 2) {
            self.numberOneTextField.text = NUMBER_ONE_HINT;
        } if(textField.tag == 3) {
            self.numberTwoTextField.text = NUMBER_TWO_HINT;
        } else if(textField.tag == 4)  {
            self.numberTwoTextField.text = NUMBER_THREE_HINT;
        }
    } else {
        textField.textColor = [UIColor redColor];
    }
}

-(void) saveButtonTapped {
    [self saveData];
    
    if([(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved]) {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] setIsBoardSaved:NO];
        [self.saveButton setTitle:@"Start Game!" forState:UIControlStateNormal];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you trying to cheat?" message:@"We play by the honour system. No changing your mind after the countdown has started" delegate:self cancelButtonTitle:@"I promise" otherButtonTitles:nil];
        [alertView show];
        
    } else if([self isAllFieldsEntered]) {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] setIsBoardSaved:YES];
        [self.saveButton setTitle:@"Edit Game" forState:UIControlStateNormal];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Game On!" message:@"Alright! Tap on the bingo squares to mark them as played" delegate:self cancelButtonTitle:@"Let's do this!" otherButtonTitles:nil];
        [alertView show];
    } else {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] setIsBoardSaved:NO];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Seriously?" message:@"Try filling out all the fields. I didn't think it was that hard.." delegate:self cancelButtonTitle:@"Sorry, I'll try harder" otherButtonTitles:nil];
        [alertView show];
    }
    [self toggleGameOnAndOff];
}

-(BOOL) isAllFieldsEntered {
    for (NSString* dataElement in self.dataArray) {
        NSString *storedValue = [dataElement description];
        if (![storedValue length]
            || [storedValue isEqualToString:NUMBER_ONE_HINT]
            || [storedValue isEqualToString:NUMBER_TWO_HINT]
            || [storedValue isEqualToString:NUMBER_THREE_HINT]
            || [storedValue isEqualToString:ARTIST_PLACEHOLDER_TEXT]
            || [storedValue isEqualToString:SONG_PLACEHOLDER_TEXT]) {
            return NO;
        }
    }
    return YES;
}


-(void) rulesButtonTapped {
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"rulesButtonTapped" object:self userInfo:nil];
}

-(void) linkButtonTapped {
    
}

-(void) saveData {
    [self.dataArray removeAllObjects];
    for (UIView* view in [self subviews]) {

        if([view isKindOfClass:[UITextField class]] && ![((UITextView*)view).text isEqualToString:@"HOTTEST 100 BINGO"] ) {
            [self.dataArray addObject:((UITextView*)view).text];
        }
        
        if([view isKindOfClass:[BingoTile class]]) {
            [self.dataArray addObject:((BingoTile*)view).songText.text];
            [self.dataArray addObject:((BingoTile*)view).artistText.text];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.dataArray forKey:@"dataArray"];
    
    [[NSUserDefaults standardUserDefaults] setBool:[(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved] forKey:@"isBoardSaved"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) loadData {
    
    self.dataArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"dataArray"]];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] setIsBoardSaved:[[NSUserDefaults standardUserDefaults] boolForKey:@"isBoardSaved"]];
}

-(void) applySavedDate {
    if([self.dataArray count]) {
        int i = 0;
        for (UIView* view in [self subviews]) {
            if([view isKindOfClass:[UITextField class]] && ![((UITextView*)view).text isEqualToString:@"HOTTEST 100 BINGO"] ) {
                
                ((UITextField*)view).text = self.dataArray[i];
                [self updateTextFieldText:((UITextField*)view)];
                i++;
            }
            
            if([view isKindOfClass:[BingoTile class]]) {
                
                ((BingoTile*)view).songText.text = self.dataArray[i];
                [((BingoTile*)view) updateTextViewText:((BingoTile*)view).songText];
                i++;
                
                ((BingoTile*)view).artistText.text = self.dataArray[i];
                [((BingoTile*)view) updateTextViewText:((BingoTile*)view).artistText];
                i++;
            }

        }
    }
}

-(void) toggleGameOnAndOff {
    
    if([self.dataArray count]) {
        for (UIView* view in [self subviews]) {
            
            if([view isKindOfClass:[UITextField class]] && ![((UITextView*)view).text isEqualToString:@"HOTTEST 100 BINGO"] ) {
                [((UITextField*)view) setEnabled:![(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved]];
            }
            
            if([view isKindOfClass:[BingoTile class]]) {
                
                [((BingoTile*)view).artistText setEditable:![(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved]];
                [((BingoTile*)view).songText setEditable:![(AppDelegate*)[[UIApplication sharedApplication] delegate] isBoardSaved]];
            }
        }
    }
}

//-(void) bingoTileTapped:(UITapGestureRecognizer *)recognizer {
//    int i = 0;
//}
//
//-(void) bingoTileTapped {
//    int j = 0;
//}
//
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    
////    otherGestureRecognizer.state = UIGestureRecognizerStateRecognized;
//   // [otherGestureRecognizer setEnabled:YES];
//   // [gestureRecognizer setEnabled:YES];
//    return YES;
//    
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return YES;
//}

@end

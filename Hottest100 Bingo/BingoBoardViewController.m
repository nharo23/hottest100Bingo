//
//  BingoBoardViewController.m
//  Hottest100 Bingo
//
//  Created by Robert Wagstaff on 4/01/13.
//  Copyright (c) 2013 Robert Wagstaff. All rights reserved.
//


#import "BingoBoardViewController.h"
#import "BingoBoardView.h"
#define kKeyboardHeight 216


@interface BingoBoardViewController ()

@property (nonatomic,strong) BingoBoardView* mainBingoBoardView;

@property (nonatomic) int keyboardHeight;
@end

@implementation BingoBoardViewController

-(id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldStartedEditing:) name:@"TextFieldStarted" object:nil];
    
    
    
    self.mainBingoBoardView = [[BingoBoardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mainBingoBoardView.backgroundColor = [UIColor greenColor];
    self.mainBingoBoardView.alwaysBounceVertical = YES;
    
    
    [self.view addSubview:self.mainBingoBoardView];

}

//
//-(void) keyboardWillShow:(NSNotification *) notification    {
//    
//    NSValue *endingFrame = [[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardFrame;
//    [endingFrame getValue:&keyboardFrame];
//
//    self.keyboardHeight = keyboardFrame.size.height;
//    
//}
//
//-(void) keyboardWillHide:(NSNotification *) notification {
//    NSLog(@"HO");    
//}
//
-(void) textFieldStartedEditing:(NSNotification *) notification    {
    
    UITextField* currentTextField = [notification object];
    
    int currentTextFieldBottomYValue = currentTextField.frame.origin.y + currentTextField.frame.size.height;
    
    
    int hiddenYPos = SCREEN_HEIGHT - 20 - kKeyboardHeight - self.mainBingoBoardView.contentOffset.y;
    NSLog(@"%f",currentTextField.frame.origin.y);
    if(currentTextFieldBottomYValue > hiddenYPos) {
        
        int offsetToScrollTo = MIN(currentTextFieldBottomYValue- hiddenYPos, kKeyboardHeight);
        
        [self.mainBingoBoardView setContentOffset:CGPointMake(0, offsetToScrollTo) animated:YES];
    }
    
    //[self.mainBingoBoardView setContentOffset:CGPointMake(0, ) animated:YES];
//    
}



@end

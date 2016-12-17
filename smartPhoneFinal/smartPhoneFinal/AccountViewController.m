//
//  Demo1ViewController.m
//  DLSlideViewDemo
//
//  Created by Dongle Su on 14-12-11.
//  Copyright (c) 2014年 dongle. All rights reserved.
//


#import "DLFixedTabbarView.h"
#import "AccountViewController.h"

@interface AccountViewController ()
-(void)setGoal:(NSInteger) num;
-(void)validateNUM:(NSString*) numinput;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        UIAlertController* newWordAlert = [UIAlertController alertControllerWithTitle:@"Set Your Daily Goal" message:@"Enter the number of the words." preferredStyle:UIAlertControllerStyleAlert];
        
        [newWordAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"50";
            textField.textColor = [UIColor blueColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
        
        UIAlertAction* saveGoalAction = [UIAlertAction actionWithTitle:@"SET" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            NSArray * textfields = newWordAlert.textFields;
            UITextField * wordfield = textfields[0];
            [self validateNUM:wordfield.text];
            [self setGoal:[wordfield.text intValue]];
        }];
        [newWordAlert addAction:saveGoalAction];
        [self presentViewController:newWordAlert animated:YES completion:nil];
    }
}
-(void)setGoal:(NSInteger) num{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:num forKey:@"DailyGoal"];
    [userDefaults synchronize];
}
-(void)validateNUM:(NSString*) numinput{
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

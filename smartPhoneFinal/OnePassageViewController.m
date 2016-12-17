//
//  OnePassageViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "OnePassageViewController.h"
#import "ArticleStore+CoreDataClass.h"
#import "ArticleStore+CoreDataProperties.h"

@interface OnePassageViewController ()
-(void)saveNewWord:(NSString*) newWord;
-(void)popupForRepetition;
@end

@implementation OnePassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO;
    self.title = @"Article Read";
    NSString *name = _selctedPassage.articleName;
    NSLog(@"passsage name is %@", name );
    NSError *error;
   // NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt" inDirectory:@"files"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: name ofType:@"txt"];
    NSLog(@"path is %@", path);
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    _passageView.text = content;

  
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [_passageView becomeFirstResponder];
    NSLog(@"wiewwillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_passageView becomeFirstResponder]; //成为第一响应者
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect targetRect = CGRectMake(200, 200, 100, 100);
    [menu setTargetRect:targetRect inView:self.view];
    // 定义两个菜单a和b
    UIMenuItem *a = [[UIMenuItem alloc] initWithTitle:@"Add To Dictionary"
                                               action:@selector(aAction)];
    // 自定义菜单添加到菜单栏中
    [menu setMenuItems:@[a]];
    [menu update];
    [menu setMenuVisible:YES];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
   BOOL result;
// 显示一个系统的paste以及自定义的a，b菜单
      if (action == @selector(aAction))
    {
        result= YES;
    }
    return result;
}


- (void)aAction{
    NSLog(@"--aAction--");
    UITextRange *selectedRange = [_passageView selectedTextRange];
    _wordToAdd = [_passageView textInRange:selectedRange];
    UIAlertController* newWordAlert = [UIAlertController alertControllerWithTitle:@"Add a New Word" message:@"Enter notes to your new word." preferredStyle:UIAlertControllerStyleAlert];
    
    [newWordAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"note";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    UIAlertAction* saveNewWordAction = [UIAlertAction actionWithTitle:@"SAVE" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSArray * textfields = newWordAlert.textFields;
        UITextField * wordfield = textfields[0];
        [self saveNewWord:wordfield.text];
    }];
    
    
    [newWordAlert addAction:saveNewWordAction];
    [self presentViewController:newWordAlert animated:YES completion:nil];
}
-(void)saveNewWord:(NSString*) newNote{
    NSLog(@" saveNewWord is called: newword is %@", _wordToAdd  );
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Inventory"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"word = %@",
                        _wordToAdd];
    request.predicate = pre;
    NSError *error = nil;
    NSArray *emps = [_myContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error");
    }
    if([emps count]!=0){
            NSLog(@"The words already in your inventory");
            [self popupForRepetition];
        }else{
        Inventory *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Inventory" inManagedObjectContext:_myContext];
        newItem.word = _wordToAdd;
        newItem.stage = 0;
        NSDate *currDate = [NSDate date];
            //change first and last date to test
        newItem.fisrtDate =currDate;
        newItem.lastDate = currDate;
        newItem.note = newNote;
        newItem.done = NO;
        newItem.relatedArticle = _selctedPassage;
        NSError *error = nil;
        if([_myContext hasChanges]){
            [_myContext save:&error];
        }
        if (error) {
            NSLog(@"%@",error);
        }
            
        NSLog(@"%@ is added to database, its done is : %d",newItem.word, newItem.done);
        
    }
}
-(void)popupForRepetition{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"The Word is in your inventory already."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backTowords:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}
@end

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

- (void)aAction{
    NSLog(@"--aAction--");
    UITextRange *selectedRange = [_passageView selectedTextRange];
    NSString *selectedText = [_passageView textInRange:selectedRange];
    WordsViewController *newWordVC = [[WordsViewController alloc]init];
    newWordVC.myContext= _myContext;
    newWordVC.selectedWord = selectedText;
    newWordVC.selectedArticle  = _selctedPassage;
    [self presentViewController:newWordVC animated:NO completion:nil];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

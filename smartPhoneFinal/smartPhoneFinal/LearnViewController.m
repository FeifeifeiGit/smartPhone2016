//
//  FirstViewController.m
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import "LearnViewController.h"
#import "VocabularyViewController.h"
#import "ProgressViewController.h"
#import "GroupViewController.h"
#import "DLFixedTabbarView.h"


@interface LearnViewController ()

@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tabedSlideView.baseViewController = self;
    self.tabedSlideView.tabItemNormalColor = [UIColor blackColor];
    self.tabedSlideView.tabItemSelectedColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarTrackColor = [UIColor colorWithRed:0.833 green:0.052 blue:0.130 alpha:1.000];
    self.tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    self.tabedSlideView.tabbarBottomSpacing = 3.0;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"Vocabulary" image:[UIImage imageNamed:@"einstin"] selectedImage:[UIImage imageNamed:@"einstin"]];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"Progress" image:[UIImage imageNamed:@"progress"] selectedImage:[UIImage imageNamed:@"progress"]];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"Group" image:[UIImage imageNamed:@"group"] selectedImage:[UIImage imageNamed:@"group"]];
    self.tabedSlideView.tabbarItems = @[item1, item2, item3];
    [self.tabedSlideView buildTabbar];
    
    self.tabedSlideView.selectedIndex = 0;
    
    NSLog(@"Learn view Controller view load is called");
    
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}
- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            VocabularyViewController *ctrl = [[VocabularyViewController alloc] init];
            return ctrl;
        }
        case 1:
        {
            ProgressViewController *ctrl = [[ProgressViewController alloc] init];
            return ctrl;
        }
        case 2:
        {
            GroupViewController *ctrl = [[GroupViewController alloc] init];
            return ctrl;
        }
            
        default:
            return nil;
    }
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

//
//  ProgressViewController.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressViewController : UIViewController
- (IBAction)clearRecord:(id)sender;

- (IBAction)createRecord:(id)sender;

@property NSManagedObjectContext *myContext;
@end

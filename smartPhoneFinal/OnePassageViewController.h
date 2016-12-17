//
//  OnePassageViewController.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/15/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inventory+CoreDataClass.h"
#import "Inventory+CoreDataProperties.h"
#import "WordsViewController.h"

#import <CoreData/CoreData.h>
@class ArticleStore;

@interface OnePassageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *passageView;
@property (strong, nonatomic) Inventory *wordToAdd;
@property NSManagedObjectContext *myContext;
@property (weak,nonatomic) ArticleStore *selctedPassage;


@end

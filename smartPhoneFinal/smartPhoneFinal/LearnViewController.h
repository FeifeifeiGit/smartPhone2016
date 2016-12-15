//
//  FirstViewController.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/14/16.
//  Copyright © 2016 fei Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabedSlideView.h"
 
@interface LearnViewController : UIViewController<DLTabedSlideViewDelegate>
@property (weak, nonatomic) IBOutlet DLTabedSlideView *tabedSlideView;



@end


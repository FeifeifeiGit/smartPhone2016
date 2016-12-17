//
//  Notes+CoreDataProperties.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/16/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Notes+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Notes (CoreDataProperties)

+ (NSFetchRequest<Notes *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *noteContent;

@end

NS_ASSUME_NONNULL_END

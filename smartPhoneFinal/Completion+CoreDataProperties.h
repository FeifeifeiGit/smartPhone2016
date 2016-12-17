//
//  Completion+CoreDataProperties.h
//  smartPhoneFinal
//
//  Created by fei Li on 12/17/16.
//  Copyright © 2016 fei Li. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Completion+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Completion (CoreDataProperties)

+ (NSFetchRequest<Completion *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nonatomic) int16_t number;

@end

NS_ASSUME_NONNULL_END

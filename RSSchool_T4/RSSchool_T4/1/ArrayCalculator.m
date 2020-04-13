#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    
    int result = 0;
    NSMutableArray *validArray = [[NSMutableArray alloc] initWithArray:[self filterAndSortArray:array]];
    
    if ([validArray count] > 0) {
        result = 1;
        
        if (numberOfItems >= [validArray count]) {
            for (NSNumber *number in validArray) result *= [number intValue];
        } else {
            for (int i = 0; i < numberOfItems; i++) result *= [validArray[i] intValue];
            
            if (result < 0) {
                result = 1;
                [validArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) { return [obj2 compare:obj1]; }];
                for (int i = 0; i < numberOfItems; i++) result *= [validArray[i] intValue];
            }
        }
    }
    
    return result;
}

+ (NSArray *)filterAndSortArray:(NSArray *)array {
    NSMutableArray *validArray = [array mutableCopy];
    [validArray removeObjectIdenticalTo:[NSNull null]];
    [validArray filterUsingPredicate:[NSPredicate predicateWithFormat: @"self isKindOfClass: %@", [NSNumber class]]];
    
    NSArray *result = [validArray sortedArrayUsingComparator:^(id a, id b) {
        if (abs([a intValue]) < abs([b intValue])) return NSOrderedDescending;
        else if (abs([b intValue]) < abs([a intValue])) return NSOrderedAscending;
        else return NSOrderedSame;
    }];
    
    return result;
}

@end

#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    
    if ([number intValue] < 0) return nil;
    
    NSDictionary *neighborNumbers = @{
        @"0": @[@"8"],
        @"1": @[@"2", @"4"],
        @"2": @[@"1", @"3", @"5"],
        @"3": @[@"2", @"6"],
        @"4": @[@"1", @"5", @"7"],
        @"5": @[@"2", @"4", @"6", @"8"],
        @"6": @[@"3", @"5", @"9"],
        @"7": @[@"4", @"8"],
        @"8": @[@"5", @"7", @"9", @"0"],
        @"9": @[@"6", @"8"]
    };
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (int i = 0; i < [number length]; i++) {
        NSRange range = NSMakeRange(i, 1);
        
        NSArray *neighborsForNumber = [neighborNumbers valueForKey:[number substringWithRange:range]];
        
        [neighborsForNumber enumerateObjectsUsingBlock:^(id x, NSUInteger index, BOOL *stop){
            [result addObject:[number stringByReplacingCharactersInRange:range withString:x]];
        }];
    }
    
    return result;
}
@end

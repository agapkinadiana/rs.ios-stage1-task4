#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray:@[number]];
    long total = 0;
    
    while ([result count]) {
        
        long lastValue = [[result lastObject] longValue];
        [result removeLastObject];
        total += pow(lastValue, 2);
        
        for (long i = lastValue - 1; i >= 0; i--) {
            if ((total - pow(i, 2) >= 0)) {
                total -= pow(i, 2);
                [result addObject:[[NSNumber alloc] initWithLong:i]];
                
                if (total == 0) return [[result reverseObjectEnumerator] allObjects];
            }
        }
    }
    return nil;
}
@end

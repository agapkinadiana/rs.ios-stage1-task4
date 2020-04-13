#import "FullBinaryTrees.h"

@interface Node : NSObject

@property NSInteger value;
@property (weak, nullable) Node* left;
@property (weak, nullable) Node* right;

- (Node *_Nullable)initTreeNode;

@end

@implementation Node

- (Node *)initTreeNode {
    self = [super init];
    if (self) self.value = 0;
    return self;
}

@end

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    
    NSArray *trees = [self findTreesFor:count];
    NSString *result = [self resultStringFromNodes:trees andCount:count];
    
    return result;
}

- (NSArray *)findTreesFor:(NSInteger)count {
    NSMutableArray *binaryTrees = [NSMutableArray new];
    
    if (count < 1 || count % 2 == 0) return binaryTrees;
    
    if (count == 1) {
        [binaryTrees addObject:[[Node alloc] initTreeNode]];
        
        return binaryTrees;
    }
    
    for (int i = 1; i < count; i += 2) {
        for (Node *leftNode in [self findTreesFor:i]) {
            for (Node *rightNode in [self findTreesFor:count - i - 1]) {
                
                Node *rootNode = [Node new];
                rootNode.left = leftNode;
                rootNode.right = rightNode;
                
                [binaryTrees addObject:rootNode];
            }
        }
    }

    return binaryTrees;
}

- (NSString *)resultStringFromNodes:(NSArray *)nodes andCount:(NSInteger)count {
    
    NSMutableString *result = [NSMutableString stringWithString:@"["];
    
    for (Node *currentNode in nodes) {
        
        NSMutableString *currentNodeString = [NSMutableString stringWithString:@"[0,"];
        
        NSMutableArray *nodes = [NSMutableArray arrayWithObject:currentNode];

        NSInteger nodesCount = 1;
        NSInteger childNodesCount = 1;

        while (nodesCount < count) {
            nodesCount++;

            Node *currentNode = [nodes firstObject];
            [nodes removeObjectAtIndex:0];

            if (currentNode.left && currentNode.right) {

                [currentNodeString appendString:@"0,0,"];
                [nodes addObject:currentNode.left];
                [nodes addObject:currentNode.right];

                childNodesCount += 2;

            } else childNodesCount < count ? [currentNodeString appendString:@"null,null,"] : 0;
        }

        [currentNodeString deleteCharactersInRange:NSMakeRange([currentNodeString length] - 1, 1)];
        [currentNodeString appendString:[currentNode isEqual:[nodes lastObject]] ? @"]" : @"],"];
        
        [result appendString:currentNodeString];
    }
    
    [result appendString:@"]"];
    
    return result;
}

@end

/*
非容器对象
对不可变对象复制(Ex. NSArray, NSString, NSDictionary)，copy只指针复制（浅拷贝）和mutableCopy就是对象复制（深拷贝）。
对可变对象复制，都是深拷贝，但是copy返回的对象是不可变的。
*/

----------------------------------------------
NSArray *array = [[NSArray alloc]initWithObjects:@"one", @"two", @"three", nil];
NSArray *array1 = [array retain];
NSArray *array2 = [array copy];
NSArray *array3 = [array mutableCopy];
NSLog(@"array.retainCount : %ld", array.retainCount);
//Breakpoint here
NSLog(@"string");

Result:
2014-05-12 10:35:58.539 CopyDemo[923:303] array.retainCount : 3

//Debug:
Printing description of array:
<__NSArrayI 0x100108200>(
one,
two,
three
)
Printing description of array1:
<__NSArrayI 0x100108200>(
one,
two,
three
)
Printing description of array2:
<__NSArrayI 0x100108200>(
one,
two,
three
)
Printing description of array3:
<__NSArrayM 0x10010ac90>(
one,
two,
three
)
//对于不可变的对象NSArray, copy的话只是简单的复制指针, 而mutableArray是深拷贝, 会创建一个新的完全一样的object.
//示例中, retain copy出来的对象地址与原对象的地址都是一样的, 也就会增加对原对象的引用计数
//而mutableCopy不会, mutableCopy是完全将对象copy出到一个新对象中.


----------------------------------------------
NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"one", @"two", @"three", nil];
NSMutableArray *array1 = [array retain];
NSMutableArray *array2 = [array copy];
//-[__NSArrayI addObject:]: unrecognized selector sent to instance 0x10010a7f0
//copy返回的是一个不可变的对象, 即使使用NSMutableArray来声明也无法改变这个事实.
//[array2 addObject:@"four"]; 
NSMutableArray *array3 = [array mutableCopy];
//Breakpoint here
NSLog(@"");  

//Debug:
Printing description of array:
<__NSArrayM 0x10010a5f0>(
one,
two,
three
)
Printing description of array1:
<__NSArrayM 0x10010a5f0>(
one,
two,
three
)
Printing description of array2:
<__NSArrayI 0x10010a7f0>(
one,
two,
three
)
Printing description of array3:
<__NSArrayM 0x10010af30>(
one,
two,
three
)

//对于可变的对象NSMutableArray, copy的话也是深拷贝, 因为copy返回的是不可变的对象, 所以简单的复制指针不能满足需求. 需要深拷贝重新创建一个不可边的对象来存放.
//对于可变的对象mutableCopy同样是深拷贝, 返回的同样是一个可变的对象.



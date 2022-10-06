!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: 'brandNewStack stackJustWithFideos stackWithHamburguesaOnTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:51:47'!
test01StackShouldBeEmptyWhenCreated
	
	self assert: brandNewStack isEmpty.! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:36:14'!
test02AnElementCanBePushedToTheStack

	brandNewStack push: 'fideos'.
	
	self deny: brandNewStack isEmpty.
	! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:57:31'!
test03AnElementCanBePoppedFromTheStack
	
	| elementRemoved |
	elementRemoved := stackJustWithFideos pop.
	
	self assert: elementRemoved equals: 'fideos'.
	self assert: stackJustWithFideos isEmpty. ! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:50:15'!
test04PoppingAnElementFromTheStackRemovesLastAddedElementAndReturnsIt

	| elementRemoved |
	elementRemoved := stackWithHamburguesaOnTop pop.
	
	self assert: elementRemoved equals: 'hamburguesa'.
	! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:50:53'!
test05PoppingAnElementFromTheStackDoesNotEliminateAllElements

	stackWithHamburguesaOnTop pop.
	
	self deny: stackWithHamburguesaOnTop isEmpty.
	! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:41:21'!
test06CanGetElementAddedToStackWithoutRemovingIt
	
	| top |
	
	top := stackJustWithFideos top.
	
	self assert: top equals: 'fideos'.
	self deny: stackJustWithFideos isEmpty.! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 15:51:30'!
test07TopGetsLastElementAddedToStack
	| top |
	
	top := stackWithHamburguesaOnTop top.
	
	self assert: top equals: 'hamburguesa'.! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 16:17:16'!
test08CantPopAnElementFromAnEmptyStack
	self assertStackShouldNotBeAbleToDoIfItsEmpty: [brandNewStack pop].! !

!StackTest methodsFor: 'tests' stamp: 'nm 10/6/2022 16:17:42'!
test09CantAskForTopOfAnEmptyStack
	
	self assertStackShouldNotBeAbleToDoIfItsEmpty: [brandNewStack top].! !


!StackTest methodsFor: 'setup' stamp: 'nm 10/6/2022 15:49:18'!
setUp
	brandNewStack := Stack new.
	
	stackJustWithFideos := Stack new.
	stackJustWithFideos push: 'fideos'.
	
	stackWithHamburguesaOnTop := Stack new.
	stackWithHamburguesaOnTop push: 'fideos'.
	stackWithHamburguesaOnTop push: 'milanesa'.
	stackWithHamburguesaOnTop push: 'hamburguesa'.
		! !


!StackTest methodsFor: 'assertions' stamp: 'nm 10/6/2022 16:15:53'!
assertStackShouldNotBeAbleToDoIfItsEmpty: aStackPrimitive
	self should: aStackPrimitive
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = Stack emptyStackErrorDescription.].! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'primitive operations' stamp: 'nm 10/6/2022 14:26:38'!
isEmpty
	^elements isEmpty.! !

!Stack methodsFor: 'primitive operations' stamp: 'nm 10/6/2022 15:20:54'!
pop
	self isEmpty ifTrue: [^self signalStackIsEmpty].
	^elements removeFirst.! !

!Stack methodsFor: 'primitive operations' stamp: 'nm 10/6/2022 14:36:54'!
push: anElementToBePushed
	elements addFirst: anElementToBePushed.! !

!Stack methodsFor: 'primitive operations' stamp: 'nm 10/6/2022 15:24:44'!
top
	self isEmpty ifTrue: [^self signalStackIsEmpty].
	^elements at: 1.! !


!Stack methodsFor: 'initializations' stamp: 'nm 10/6/2022 14:43:28'!
initialize
	elements := OrderedCollection new.! !


!Stack methodsFor: 'signals' stamp: 'nm 10/6/2022 15:21:20'!
signalStackIsEmpty
	self error: self class emptyStackErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'as yet unclassified' stamp: 'nm 10/6/2022 15:24:27'!
emptyStackErrorDescription
	^'No hay elementos con los que operar'.! !

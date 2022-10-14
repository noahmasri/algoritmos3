!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stack finder emptyStack finderWithEmptyStack smallStack finderWithSmallStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'set up' stamp: 'nm 10/13/2022 15:21:08'!
setUp
	stack := OOStack new.
	stack push: 'bokita pasion'.
	stack push: 'aguante bokita'.
	stack push: 'boke mi vida'.
	stack push: 'boka rocks, river sucks'.
	stack push: 'Bokita muero por vos'.
	stack push: 'mi vieja me dio la vida y boke las ganas de vivirla'.
	
	finder := SentenceFinderByPrefix with: stack.
	
	emptyStack := OOStack new.
	finderWithEmptyStack := SentenceFinderByPrefix with: emptyStack.
	
	smallStack := OOStack new.
	smallStack push: 'adidas'.
	smallStack push: 'nike'.
	smallStack push: 'puma'.
	finderWithSmallStack := SentenceFinderByPrefix with: smallStack.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/9/2022 13:26:52'!
test01aPrefixMatchesNoSentenceFromStack
	| sentencesFound |
	sentencesFound := finder find: 'Boca'.
	
	self assert: sentencesFound isEmpty.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:00:21'!
test02aPrefixMatchesOneSentenceFromStack
	| sentencesFound |
	sentencesFound := finder find: 'boke'.
	
	self assertThatTheOnlyThingIn: sentencesFound is: 'boke mi vida'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:33:18'!
test03aPrefixMatchesMoreThanOneSentenceFromStack
	| sentencesFound |
	sentencesFound := finder find: 'bok'.
	
	self assert: sentencesFound size equals: 3.
	self assert: sentencesFound equals: #('boka rocks, river sucks' 'boke mi vida' 'bokita pasion') asOrderedCollection.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:19:24'!
test04finderDistinguishesBetweenUpperAndLowerCase
	| sentencesFound |
	sentencesFound := finder find: 'bokita'.
	
	self assertThatTheOnlyThingIn: sentencesFound is: 'bokita pasion'.
	self assert: (sentencesFound noneSatisfy: [:element| element = 'Bokita muero por vos'.]).
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 14:54:57'!
test05prefixSearchedCantBeEmpty
	self assertFinderCantSearchWith: ''.
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 14:54:43'!
test06prefixSearchedCantContainSpaces
	self assertFinderCantSearchWith: 'mi vieja'.
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:19:05'!
test07noSentenceIsFoundInAnEmptyStack
	| sentencesFound |
	sentencesFound := finderWithEmptyStack find: 'boke'.
	
	self assert: sentencesFound isEmpty.
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:34:21'!
test08stackRemainsTheSameWhenACoincidenceIsFound
	| sentencesFound |
	sentencesFound := finderWithSmallStack find: 'puma'.
	
	self deny: sentencesFound isEmpty.
	self assertThatStackMaintainsOrderFromSetUp.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'nm 10/13/2022 15:34:38'!
test09stackRemainsTheSameWhenNoCoincidencesAreFound
	| sentencesFound |
	sentencesFound := finderWithSmallStack find: 'topper'.
	
	self assert: sentencesFound isEmpty.
	self assertThatStackMaintainsOrderFromSetUp.
	! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'nm 10/13/2022 14:54:20'!
assertFinderCantSearchWith: anInvalidPrefix

	self should: [finder find: anInvalidPrefix]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix prefixIsInvalid.].! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'nm 10/13/2022 15:16:24'!
assertThatStackMaintainsOrderFromSetUp
	self assert: (smallStack pop) equals: 'puma'.
	self assert: (smallStack pop) equals: 'nike'.
	self assert: (smallStack pop) equals: 'adidas'.! !

!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'nm 10/13/2022 14:59:45'!
assertThatTheOnlyThingIn: sentencesFound is: aSentence
	self deny: sentencesFound isEmpty.
	self assert: sentencesFound size equals: 1.
	self assert: (sentencesFound at: 1) equals: aSentence.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'nm 10/9/2022 11:25:57'!
initialize
	elements := OrderedCollection new.! !


!OOStack methodsFor: 'status' stamp: 'nm 10/9/2022 12:17:59'!
currentStatus
	^OOStackStatus of: self. ! !


!OOStack methodsFor: 'signals' stamp: 'nm 10/9/2022 12:23:54'!
signalInvalidStatus
	self error: self class stackHasInvalidStatus.! !

!OOStack methodsFor: 'signals' stamp: 'nm 10/9/2022 11:30:16'!
signalStackIsEmpty
	self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:13:00'!
popFromEmptyStack
	^self signalStackIsEmpty.! !

!OOStack methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:12:33'!
popFromStackWithElements
	^elements removeFirst.! !

!OOStack methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:27:29'!
topOfEmptyStack
	^self signalStackIsEmpty.! !

!OOStack methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:28:08'!
topOfStackWithElements
	^elements at: 1.! !


!OOStack methodsFor: 'primitives' stamp: 'nm 10/9/2022 11:26:39'!
isEmpty
	^elements isEmpty.! !

!OOStack methodsFor: 'primitives' stamp: 'nm 10/9/2022 12:24:51'!
pop
	^self currentStatus popFrom: self.! !

!OOStack methodsFor: 'primitives' stamp: 'nm 10/9/2022 11:28:20'!
push: anElementToBePushed
	elements addFirst: anElementToBePushed.! !

!OOStack methodsFor: 'primitives' stamp: 'nm 10/9/2022 11:29:43'!
size
	^elements size.! !

!OOStack methodsFor: 'primitives' stamp: 'nm 10/9/2022 12:26:21'!
top
	^self currentStatus topOf: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:24:10'!
stackHasInvalidStatus
	^'Stack is not valid'! !


!classDefinition: #OOStackStatus category: 'Stack-Exercise'!
Object subclass: #OOStackStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStatus class' category: 'Stack-Exercise'!
OOStackStatus class
	instanceVariableNames: ''!

!OOStackStatus class methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:22:23'!
of: aStack
	self subclasses detect: [:aSubclass | aSubclass isFromYourClass: aStack]
		ifFound: [:detectedSubclass | ^detectedSubclass new]
		ifNone: [^aStack signalInvalidStatus]. ! !


!classDefinition: #Empty category: 'Stack-Exercise'!
OOStackStatus subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:12:03'!
popFrom: aStack
	^aStack popFromEmptyStack.! !

!Empty methodsFor: 'primitives - DD' stamp: 'nm 10/9/2022 12:26:50'!
topOf: aStack
	^aStack topOfEmptyStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: 'Stack-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:22:49'!
isFromYourClass: aStack
	^aStack isEmpty.! !


!classDefinition: #NotEmpty category: 'Stack-Exercise'!
OOStackStatus subclass: #NotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:11:43'!
popFrom: aStack
	^aStack popFromStackWithElements.! !

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:27:15'!
topOf: aStack
	^aStack topOfStackWithElements.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmpty class' category: 'Stack-Exercise'!
NotEmpty class
	instanceVariableNames: ''!

!NotEmpty class methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 12:23:02'!
isFromYourClass: aStack
	^aStack isEmpty not.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'signals' stamp: 'nm 10/11/2022 21:33:11'!
signalPrefixIsInvalid
	^self error: self class prefixIsInvalid.! !


!SentenceFinderByPrefix methodsFor: 'actions - private' stamp: 'nm 10/13/2022 14:26:59'!
migrateAnElementFromStackto: anAuxStack savingCoincidenceWith: aPrefix in: aCollection
	| poppedElement |
	poppedElement := stack pop. 
	(poppedElement beginsWith: aPrefix) ifTrue: [aCollection add: poppedElement]. 
	anAuxStack push: poppedElement.! !

!SentenceFinderByPrefix methodsFor: 'actions - private' stamp: 'nm 10/13/2022 14:31:56'!
returnStackToOriginalFormHelpedBy: anAuxStack
	[anAuxStack isEmpty] whileFalse: [stack push: (anAuxStack pop)].! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'nm 10/9/2022 13:21:43'!
initializeWith: aStack
	stack := aStack.! !


!SentenceFinderByPrefix methodsFor: 'actions' stamp: 'nm 10/13/2022 14:32:14'!
find: aPrefix
	|auxStack sentencesFound|
	sentencesFound := OrderedCollection new.
	auxStack := OOStack new.
	
	((aPrefix includesSubString: ' ') or: [aPrefix isEmpty]) ifTrue: [^self signalPrefixIsInvalid].
	
	[stack isEmpty] whileFalse: [self migrateAnElementFromStackto: auxStack 
							savingCoincidenceWith: aPrefix in: sentencesFound].
		
	self returnStackToOriginalFormHelpedBy: auxStack.
	
	^sentencesFound.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'nm 10/11/2022 21:32:36'!
prefixIsInvalid
	^'Prefix searched can not contain spaces nor be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'nm 10/9/2022 13:24:04'!
with: aStack
	^self new initializeWith: aStack! !

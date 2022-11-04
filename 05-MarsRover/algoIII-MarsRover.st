!classDefinition: #MarsRoverTest category: 'algoIII-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverFacingNorth marsRoverFacingSouth marsRoverFacingEast marsRoverFacingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MarsRoverTest methodsFor: 'moving backwards test' stamp: 'nm 11/3/2022 16:41:07'!
test06canMoveBackwardsHeadingNorth
	self assertThatRover: marsRoverFacingNorth isAtX: 0 Y: -1 facing: self north afterExecuting: 'b'.	! !

!MarsRoverTest methodsFor: 'moving backwards test' stamp: 'nm 11/3/2022 16:41:29'!
test07canMoveBackwardsHeadingSouth
	self assertThatRover: marsRoverFacingSouth isAtX: 0 Y: 1 facing: self south afterExecuting: 'b'.	

	! !

!MarsRoverTest methodsFor: 'moving backwards test' stamp: 'nm 11/3/2022 16:42:00'!
test08canMoveBackwardsHeadingEast
	self assertThatRover: marsRoverFacingEast isAtX: -1 Y: 0 facing: self east afterExecuting: 'b'.	! !

!MarsRoverTest methodsFor: 'moving backwards test' stamp: 'nm 11/3/2022 16:42:23'!
test09canMoveBackwardsHeadingWest
	self assertThatRover: marsRoverFacingWest isAtX: 1 Y: 0 facing: self west afterExecuting: 'b'.	
! !


!MarsRoverTest methodsFor: 'invalid movement test' stamp: 'nm 11/3/2022 16:55:38'!
test01marsRoverDoesntMoveWhenReceivesEmptyString
	self assertThatRover: marsRoverFacingNorth isAtX: 0 Y: 0 facing: self north afterExecutingWithError: ' '.! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'nm 11/3/2022 16:30:38'!
east
	^East new! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'nm 11/3/2022 16:29:16'!
north
	^North new.! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'nm 11/3/2022 16:32:55'!
setUp
	marsRoverFacingNorth := MarsRover atX: 0 Y: 0 facing: 'N'. 
	marsRoverFacingSouth := MarsRover atX: 0 Y: 0 facing: 'S'. 
	marsRoverFacingEast := MarsRover atX: 0 Y: 0 facing: 'E'. 
	marsRoverFacingWest := MarsRover atX: 0 Y: 0 facing: 'W'. ! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'nm 11/3/2022 16:30:44'!
south
	^South new.! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'nm 11/3/2022 16:30:50'!
west
	^West new! !


!MarsRoverTest methodsFor: 'turning left test' stamp: 'nm 11/3/2022 16:42:49'!
test10canTurnLeftFacingNorth
	self assertThatRover: marsRoverFacingNorth isAtX: 0 Y: 0 facing: self west afterExecuting: 'l'.	
	! !

!MarsRoverTest methodsFor: 'turning left test' stamp: 'nm 11/3/2022 16:43:44'!
test11canTurnLeftFacingSouth
	self assertThatRover: marsRoverFacingSouth isAtX: 0 Y: 0 facing: self east afterExecuting: 'l'.	
	! !

!MarsRoverTest methodsFor: 'turning left test' stamp: 'nm 11/3/2022 16:44:01'!
test12canTurnLeftFacingEast
	self assertThatRover: marsRoverFacingEast isAtX: 0 Y: 0 facing: self north afterExecuting: 'l'.	
	! !

!MarsRoverTest methodsFor: 'turning left test' stamp: 'nm 11/3/2022 16:44:23'!
test13canTurnLeftFacingWest
	self assertThatRover: marsRoverFacingWest isAtX: 0 Y: 0 facing: self south afterExecuting: 'l'.	
	! !


!MarsRoverTest methodsFor: 'turning right test' stamp: 'nm 11/3/2022 16:44:56'!
test14canTurnRightFacingNorth
	self assertThatRover: marsRoverFacingNorth isAtX: 0 Y: 0 facing: self east afterExecuting: 'r'.	
	! !

!MarsRoverTest methodsFor: 'turning right test' stamp: 'nm 11/3/2022 16:45:19'!
test15canTurnRightFacingSouth
	self assertThatRover: marsRoverFacingSouth isAtX: 0 Y: 0 facing: self west afterExecuting: 'r'.	
	! !

!MarsRoverTest methodsFor: 'turning right test' stamp: 'nm 11/3/2022 16:32:09'!
test16canTurnRightFacingEast
	self assertThatRover: marsRoverFacingEast isAtX: 0 Y: 0 facing: self south afterExecuting: 'r'.
	
	! !

!MarsRoverTest methodsFor: 'turning right test' stamp: 'nm 11/3/2022 16:45:44'!
test17canTurnRightFacingWest
	self assertThatRover: marsRoverFacingWest isAtX: 0 Y: 0 facing: self north afterExecuting: 'r'.	
	! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'nm 11/3/2022 16:49:09'!
assertThatRover: aMarsRover isAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint
	self assert: anXCoordenate@anYCoordenate equals: aMarsRover position.
	self assert: (aMarsRover isFacingDirection: aCardinalPoint).
	! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'nm 11/3/2022 16:49:27'!
assertThatRover: aMarsRover isAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint afterExecuting: aSequenceOfMovements

	aMarsRover executeMovements: aSequenceOfMovements.
	self assertThatRover: aMarsRover isAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'nm 11/3/2022 16:53:34'!
assertThatRover: aMarsRover isAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint afterExecutingWithError: aSequenceOfMovements

	self should: [ aMarsRover executeMovements: aSequenceOfMovements. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Movement invalidMovement equals: anError messageText.
			self assertThatRover: aMarsRover isAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint ].! !


!MarsRoverTest methodsFor: 'moving forward test' stamp: 'nm 11/3/2022 16:36:41'!
test02canMoveForwardHeadingNorth
	self assertThatRover: marsRoverFacingNorth isAtX: 0 Y: 1 facing: self north afterExecuting: 'f'.
	
	
	! !

!MarsRoverTest methodsFor: 'moving forward test' stamp: 'nm 11/3/2022 16:38:15'!
test03canMoveForwardHeadingSouth
	self assertThatRover: marsRoverFacingSouth isAtX: 0 Y: -1 facing: self south afterExecuting: 'f'.
	
	! !

!MarsRoverTest methodsFor: 'moving forward test' stamp: 'nm 11/3/2022 16:39:33'!
test04canMoveForwardHeadingEast
	self assertThatRover: marsRoverFacingEast isAtX: 1 Y: 0 facing: self east afterExecuting: 'f'.
	
	! !

!MarsRoverTest methodsFor: 'moving forward test' stamp: 'nm 11/3/2022 16:40:37'!
test05canMoveForwardHeadingWest
	self assertThatRover: marsRoverFacingWest isAtX: -1 Y: 0 facing: self west afterExecuting: 'f'.

	! !


!MarsRoverTest methodsFor: 'moving more than once' stamp: 'nm 11/3/2022 16:56:41'!
test18canExecuteMoreThanOneMovement
	self assertThatRover: marsRoverFacingWest isAtX: 1 Y: 0 facing: self west afterExecuting: 'rlb'.
	! !

!MarsRoverTest methodsFor: 'moving more than once' stamp: 'nm 11/3/2022 16:57:59'!
test19canExecuteMoreThanOneMovementStoppingWhenDetectingAnInvalidMovement
	self assertThatRover: marsRoverFacingWest isAtX: 1 Y: 0 facing: self west afterExecutingWithError: 'rlbprlf'.
		
		
	
	! !


!classDefinition: #CardinalPoint category: 'algoIII-MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!CardinalPoint methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:38:56'!
affectMovementBackwardsOf: aMarsRover
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:43:01'!
affectMovementForwardOf: aMarsRover
	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:50:42'!
cardinalPointAtItsLeft
	self subclassResponsibility.! !

!CardinalPoint methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:54:09'!
cardinalPointAtItsRight
	self subclassResponsibility.! !


!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'nm 11/3/2022 16:29:53'!
= aCardinalPoint
	^self class = aCardinalPoint class.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: 'algoIII-MarsRover'!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:32:43'!
invalidCardinalPoint
	^'invalid cardinal point'! !

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:33:11'!
isFromYourType: aCharacter
	self subclassResponsibility! !

!CardinalPoint class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:32:12'!
of: aCharacter
	CardinalPoint subclasses detect: [:aSubclass | aSubclass isFromYourType: aCharacter]
		ifFound: [:detectedSubclass | ^detectedSubclass new]
		ifNone: [^CardinalPoint invalidCardinalPoint]! !


!classDefinition: #East category: 'algoIII-MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!East methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:51:26'!
cardinalPointAtItsLeft
	^North new.! !

!East methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:54:26'!
cardinalPointAtItsRight
	^South new.! !


!East methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:44:48'!
affectMovementBackwardsOf: aMarsRover
	aMarsRover moveBackwardsFacingEast.! !

!East methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:45:34'!
affectMovementForwardOf: aMarsRover
	aMarsRover moveForwardFacingEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'algoIII-MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:29:42'!
isFromYourType: aCharacter
	^aCharacter = 'E'. ! !


!classDefinition: #North category: 'algoIII-MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!North methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:51:48'!
cardinalPointAtItsLeft
	^West new.! !

!North methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:55:05'!
cardinalPointAtItsRight
	^East new.! !


!North methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:44:59'!
affectMovementBackwardsOf: aMarsRover
	aMarsRover moveBackwardsFacingNorth.! !

!North methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:45:52'!
affectMovementForwardOf: aMarsRover
	aMarsRover moveForwardFacingNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'algoIII-MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:29:52'!
isFromYourType: aCharacter
	^aCharacter = 'N'. ! !


!classDefinition: #South category: 'algoIII-MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!South methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:52:11'!
cardinalPointAtItsLeft
	^East new.! !

!South methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:54:56'!
cardinalPointAtItsRight
	^West new.! !


!South methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:45:10'!
affectMovementBackwardsOf: aMarsRover
	aMarsRover moveBackwardsFacingSouth.! !

!South methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:46:14'!
affectMovementForwardOf: aMarsRover
	aMarsRover moveForwardFacingSouth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'algoIII-MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:29:59'!
isFromYourType: aCharacter
	^aCharacter = 'S'. ! !


!classDefinition: #West category: 'algoIII-MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!West methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:52:44'!
cardinalPointAtItsLeft
	^South new.! !

!West methodsFor: 'neighbours' stamp: 'nm 10/31/2022 14:54:41'!
cardinalPointAtItsRight
	^North new.! !


!West methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:45:21'!
affectMovementBackwardsOf: aMarsRover
	aMarsRover moveBackwardsFacingWest.! !

!West methodsFor: 'movement - dd' stamp: 'nm 10/31/2022 14:46:29'!
affectMovementForwardOf: aMarsRover
	aMarsRover moveForwardFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'algoIII-MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:30:07'!
isFromYourType: aCharacter
	^aCharacter = 'W'. ! !


!classDefinition: #MarsRover category: 'algoIII-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'cardinalPoint xCoordenate yCoordenate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'nm 10/31/2022 14:44:16'!
initializeAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPointCharacter
	xCoordenate := anXCoordenate.
	yCoordenate := anYCoordenate.
	cardinalPoint := CardinalPoint of: aCardinalPointCharacter.! !


!MarsRover methodsFor: 'movement' stamp: 'nm 11/3/2022 16:24:15'!
executeMovements: aSequenceOfMovements
	| type |
	type := Movement type: (aSequenceOfMovements at: 1).
	type isInvalid ifTrue: [^self signalInvalidMovement ].
	type move: self.
	(aSequenceOfMovements size <= 1) ifTrue: [^self].
	self executeMovements: (aSequenceOfMovements copyFrom: 2 to: aSequenceOfMovements size).! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:37:44'!
moveBackwards
	cardinalPoint affectMovementBackwardsOf: self.
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:44:47'!
moveBackwardsFacingEast
	xCoordenate := xCoordenate - 1
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:44:58'!
moveBackwardsFacingNorth
	yCoordenate := yCoordenate - 1
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:45:10'!
moveBackwardsFacingSouth
	yCoordenate := yCoordenate + 1
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:45:20'!
moveBackwardsFacingWest
	xCoordenate := xCoordenate + 1.
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 15:04:40'!
moveForward
	cardinalPoint affectMovementForwardOf: self.! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:47:26'!
moveForwardFacingEast
	xCoordenate := xCoordenate + 1! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:47:50'!
moveForwardFacingNorth
	yCoordenate := yCoordenate + 1! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:47:59'!
moveForwardFacingSouth
	yCoordenate := yCoordenate - 1! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:47:39'!
moveForwardFacingWest
	xCoordenate := xCoordenate - 1! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:50:05'!
turnLeft
	cardinalPoint := cardinalPoint cardinalPointAtItsLeft.
	
	
	! !

!MarsRover methodsFor: 'movement' stamp: 'nm 10/31/2022 14:54:00'!
turnRight
	cardinalPoint := cardinalPoint cardinalPointAtItsRight.! !


!MarsRover methodsFor: 'location' stamp: 'nm 10/31/2022 14:58:34'!
cardinalPoint
	^cardinalPoint! !

!MarsRover methodsFor: 'location' stamp: 'nm 11/3/2022 16:29:26'!
isFacingDirection: aCardinalPoint
	^cardinalPoint = aCardinalPoint! !

!MarsRover methodsFor: 'location' stamp: 'nm 10/31/2022 12:35:31'!
position
	^xCoordenate@yCoordenate.! !


!MarsRover methodsFor: 'error' stamp: 'nm 11/3/2022 16:05:27'!
signalInvalidMovement
	self error: Movement invalidMovement.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'algoIII-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'nm 10/31/2022 14:55:53'!
atX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint
	^self new initializeAtX: anXCoordenate Y: anYCoordenate facing: aCardinalPoint ! !


!classDefinition: #Movement category: 'algoIII-MarsRover'!
Object subclass: #Movement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!Movement methodsFor: 'actions' stamp: 'nm 10/31/2022 14:02:34'!
move: aMarsRover
	self subclassResponsibility.! !


!Movement methodsFor: 'testing' stamp: 'nm 11/3/2022 15:26:30'!
isInvalid
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Movement class' category: 'algoIII-MarsRover'!
Movement class
	instanceVariableNames: ''!

!Movement class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:09:45'!
invalidMovement
	^'no existe ese movimiento'! !

!Movement class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:12:23'!
type: aCharacter
	Movement subclasses detect: [:aSubclass | aSubclass isFromYourType: aCharacter ]
		ifFound: [:detectedSubclass | ^detectedSubclass new]
		ifNone: [^InvalidMovement new]! !


!classDefinition: #InvalidMovement category: 'algoIII-MarsRover'!
Movement subclass: #InvalidMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!InvalidMovement methodsFor: 'testing' stamp: 'nm 11/3/2022 15:26:41'!
isInvalid
	^true! !


!InvalidMovement methodsFor: 'actions' stamp: 'nm 11/3/2022 16:03:41'!
move: aMarsRover
	^self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvalidMovement class' category: 'algoIII-MarsRover'!
InvalidMovement class
	instanceVariableNames: ''!

!InvalidMovement class methodsFor: 'as yet unclassified' stamp: 'nm 10/31/2022 14:12:47'!
isFromYourType: aCharacter
	^false.! !


!classDefinition: #MovementBackwards category: 'algoIII-MarsRover'!
Movement subclass: #MovementBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MovementBackwards methodsFor: 'actions' stamp: 'nm 10/31/2022 14:03:20'!
move: aMarsRover
	aMarsRover moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementBackwards class' category: 'algoIII-MarsRover'!
MovementBackwards class
	instanceVariableNames: ''!

!MovementBackwards class methodsFor: 'as yet unclassified' stamp: 'nm 11/3/2022 15:39:30'!
isFromYourType: aMovement
	^aMovement = $b.! !


!classDefinition: #MovementForward category: 'algoIII-MarsRover'!
Movement subclass: #MovementForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MovementForward methodsFor: 'actions' stamp: 'nm 10/31/2022 14:03:35'!
move: aMarsRover
	aMarsRover moveForward! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementForward class' category: 'algoIII-MarsRover'!
MovementForward class
	instanceVariableNames: ''!

!MovementForward class methodsFor: 'as yet unclassified' stamp: 'nm 11/3/2022 15:39:24'!
isFromYourType: aMovement
	^aMovement = $f.! !


!classDefinition: #MovementToLeft category: 'algoIII-MarsRover'!
Movement subclass: #MovementToLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MovementToLeft methodsFor: 'actions' stamp: 'nm 10/31/2022 14:05:08'!
move: aMarsRover
	aMarsRover turnLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementToLeft class' category: 'algoIII-MarsRover'!
MovementToLeft class
	instanceVariableNames: ''!

!MovementToLeft class methodsFor: 'as yet unclassified' stamp: 'nm 11/3/2022 15:39:15'!
isFromYourType: aMovement
	^aMovement = $l.! !


!classDefinition: #MovementToRight category: 'algoIII-MarsRover'!
Movement subclass: #MovementToRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'algoIII-MarsRover'!

!MovementToRight methodsFor: 'actions' stamp: 'nm 10/31/2022 14:05:18'!
move: aMarsRover
	aMarsRover turnRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MovementToRight class' category: 'algoIII-MarsRover'!
MovementToRight class
	instanceVariableNames: ''!

!MovementToRight class methodsFor: 'as yet unclassified' stamp: 'nm 11/3/2022 15:39:05'!
isFromYourType: aMovement
	^aMovement = $r.! !

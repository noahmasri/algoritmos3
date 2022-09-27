!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'private' stamp: 'nm 9/24/2022 18:22:32'!
assertThatThereAre: anAmountOfActiveCustomers activeAnd: anAmountOfSuspendedCustomers suspendedAnd:  anAmountOfCustomers customersIn: aCustomerBook

	self assert: anAmountOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: anAmountOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: anAmountOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'private' stamp: 'nm 9/24/2022 18:45:38'!
inCase: aBlock throwsError: anErrorType itShouldAssertThat: assertions
	aBlock
		on: anErrorType 
		do: assertions.! !

!CustomerBookTest methodsFor: 'private' stamp: 'nm 9/24/2022 17:15:43'!
theClient: aName isTheOnlyCustomerIn: customerBook
	^[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: aName)].! !


!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/26/2022 12:00:04'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: 'John Lennon'] notTakeMoreThan: 50milliSeconds.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/26/2022 12:01:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self should: [customerBook removeCustomerNamed: paulMcCartney] notTakeMoreThan: 100milliSeconds.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:47:04'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self inCase: [customerBook addCustomerNamed: ''. self fail] 
		throwsError: Error 
		itShouldAssertThat: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty].
			! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:47:23'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self inCase: [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ] 
		throwsError: NotFound 
		itShouldAssertThat: (self theClient: johnLennon isTheOnlyCustomerIn: customerBook).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:24:38'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatThereAre: 0 activeAnd: 1 suspendedAnd: 1 customersIn: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:25:06'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatThereAre: 0 activeAnd: 0 suspendedAnd: 0 customersIn: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:47:36'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self inCase: [ customerBook suspendCustomerNamed: 'Ringo Starr'. self fail ] 
		throwsError: CantSuspend 
		itShouldAssertThat: (self theClient: johnLennon isTheOnlyCustomerIn: customerBook).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'nm 9/24/2022 18:46:41'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self inCase: [customerBook suspendCustomerNamed: johnLennon. self fail ] 
		throwsError: CantSuspend 
		itShouldAssertThat: (self theClient: johnLennon isTheOnlyCustomerIn: customerBook).
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'nm 9/24/2022 17:55:34'!
includesCustomerNamed: aName

	^(self customer: aName isIn: active) or: [self customer: aName isIn: suspended ].! !

!CustomerBook methodsFor: 'testing' stamp: 'nm 9/24/2022 17:49:32'!
isEmpty
	
	^self numberOfCustomers = 0.! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/24/2022 17:27:41'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/27/2022 15:23:54'!
customer: aName isIn: aCollection

	^aCollection includes: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/24/2022 17:28:52'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/27/2022 15:23:44'!
removeCustomerNamed: aName 

	active remove: aName ifAbsent: [suspended remove: aName ifAbsent: [^NotFound signal]].
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/27/2022 15:23:41'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'nm 9/24/2022 17:58:29'!
suspendCustomerNamed: aName 
	
	(self customer: aName isIn: active) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	suspended add: aName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !

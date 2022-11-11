!classDefinition: #AccountsTransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #AccountsTransferenceTest
	instanceVariableNames: 'transmitter receiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountsTransferenceTest methodsFor: 'testing' stamp: 'nm 11/10/2022 15:02:45'!
test01aTransferenceForANegativeValueIsInvalid
	self should: [ AccountsTransference from: transmitter to: receiver forAmount: -100 * peso. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: AccountsTransference invalidAmount equals: anError messageText. ]! !

!AccountsTransferenceTest methodsFor: 'testing' stamp: 'nm 11/10/2022 15:01:24'!
test02transferenceKnowsItsValue
	| transference |
	transference := AccountsTransference from: transmitter to: receiver forAmount: 100 * peso.
	self assert: 100 * peso equals: transference value. ! !

!AccountsTransferenceTest methodsFor: 'testing' stamp: 'nm 11/8/2022 21:32:56'!
test03depositLegKnowsItsCounterpartIsExtractionLeg
	| transference |
	transference := AccountsTransference from: transmitter to: receiver forAmount: 100 * peso.
	self assert: transference depositLeg counterpart equals: transference extractionLeg.! !

!AccountsTransferenceTest methodsFor: 'testing' stamp: 'nm 11/8/2022 20:53:01'!
test04extractionLegKnowsItsCounterpartIsDepositLeg
	| transference |
	transference := AccountsTransference from: transmitter to: receiver forAmount: 100 * peso.
	self assert: transference extractionLeg counterpart equals: transference depositLeg.! !

!AccountsTransferenceTest methodsFor: 'testing' stamp: 'nm 11/10/2022 15:00:35'!
test05transferringFromOneAccountToTheOtherAffectsBalanceOfBothInvolved
	AccountsTransference from: transmitter to: receiver forAmount: 100 * peso.
	self assert: -100 * peso equals: transmitter balance.
	self assert: 100 * peso equals: receiver balance.! !


!AccountsTransferenceTest methodsFor: 'setUp' stamp: 'nm 11/8/2022 20:14:51'!
setUp
	transmitter := ReceptiveAccount new.
	receiver := ReceptiveAccount new. 
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'accountDeNoahYMarto accountDeLucho accountWithoutTransactions depositToNoahYMarto withdrawFromLucho portfolioWithAccountNM portfolioContainingPortfolioAndLucho emptyPortfolio portfolioWithAccountNM2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/8/2022 21:40:43'!
test01aPortfolioAssociatedToNoAccountsHasZeroBalance
	| portfolio |
	portfolio := Portfolio new.
	self assert: 0 equals: portfolio balance! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 15:27:23'!
test02aPortfolioAssociatedToOneAccountHasTheBalanceOfThatAccount
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	self assert: 100 * peso equals: portfolio balance! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 16:17:24'!
test03aPortfolioAssociatedToMoreThanOneAccountHasAsBalanceTheSumOfAllIndividualBalances
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	portfolio add: accountDeLucho.
	self assert: -1900 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 15:27:23'!
test04aPortfolioAssociatedToAnAccountWithNoTransactionsRegisteredNoTransactions
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountWithoutTransactions.
	self deny: portfolio transactionsWereMade.! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 15:27:23'!
test05aPortfolioAssociatedToAnAccountWithTransactionsHasMadeTransactions
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	self assert: portfolio transactionsWereMade! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 16:17:24'!
test06transactionsOfAPortfolioIncludeTheTransactionsOfAllAccountsAssociated
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	portfolio add: accountDeLucho.
	
	self assert: portfolio transactions includes: accountDeNoahYMarto transactions.
	self assert: portfolio transactions includes: 	accountDeLucho transactions.! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 15:27:23'!
test07aPortfolioAssociatedToAnAccountThatHasMadeATransactionRegistersIt
	| portfolio |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	
	self assert: (portfolio hasRegistered: depositToNoahYMarto).
	
	! !

!PortfolioTest methodsFor: 'functional testing' stamp: 'nm 11/10/2022 16:17:24'!
test08aPortfolioAssociatedToMoreThanOneAccountThatHasMadeATransactionRegistersAllTheirTransactions
	| portfolio aDeposit |
	portfolio := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	portfolio add: 	accountDeLucho.
	
	aDeposit := Deposit register: 100*peso on: accountWithoutTransactions.
	
	self assert: (portfolio hasRegistered: withdrawFromLucho).
	self assert: (portfolio hasRegistered: depositToNoahYMarto).
	self deny: (portfolio hasRegistered: aDeposit).! !


!PortfolioTest methodsFor: 'setUp' stamp: 'nm 11/10/2022 16:40:08'!
setUp

	accountDeNoahYMarto := ReceptiveAccount new.
	depositToNoahYMarto := Deposit register: 100 * peso on: accountDeNoahYMarto.
	
	accountDeLucho := ReceptiveAccount new.
	withdrawFromLucho := Withdraw register: 2000 * peso on: accountDeLucho.
	
	accountWithoutTransactions := ReceptiveAccount new.
	
	portfolioWithAccountNM := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	portfolioWithAccountNM2 := Portfolio associatedToFinantialEntity: accountDeNoahYMarto.
	portfolioContainingPortfolioAndLucho := Portfolio associatedToFinantialEntity: portfolioWithAccountNM.
	portfolioContainingPortfolioAndLucho add: accountDeLucho.
	emptyPortfolio := Portfolio new.
	! !


!PortfolioTest methodsFor: 'valid portfolio testing' stamp: 'nm 11/10/2022 16:49:31'!
test09anAccountCantBeAddedToAPortfolioIfItAlreadyContainsIt
	self assertThat: accountDeNoahYMarto shouldRaiseErrorWhenAttemptingToAddTo: portfolioWithAccountNM! !

!PortfolioTest methodsFor: 'valid portfolio testing' stamp: 'nm 11/10/2022 16:50:31'!
test10anAccountCantBeAddedToAPortfolioIfItAlreadyContainsAPortfolioThatContainsIt
	self assertThat: accountDeNoahYMarto shouldRaiseErrorWhenAttemptingToAddTo: portfolioContainingPortfolioAndLucho.
	
		! !

!PortfolioTest methodsFor: 'valid portfolio testing' stamp: 'nm 11/10/2022 16:50:57'!
test11aPortfolioCantBeAddedToItself
	self assertThat: emptyPortfolio shouldRaiseErrorWhenAttemptingToAddTo: emptyPortfolio.! !

!PortfolioTest methodsFor: 'valid portfolio testing' stamp: 'nm 11/10/2022 16:51:21'!
test12anAccountCantBeAddedToAPortfolioWhoseParentContainsTheAccount
	self assertThat: accountDeLucho shouldRaiseErrorWhenAttemptingToAddTo: portfolioWithAccountNM.
	! !

!PortfolioTest methodsFor: 'valid portfolio testing' stamp: 'nm 11/10/2022 16:51:39'!
test13aPortfolioCantBeAddedToAPortfolioWhichIncludesAnAccountTheFirstOneAlreadyHas

	self should: [portfolioWithAccountNM2 add: portfolioWithAccountNM]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Portfolio financialEntityAlreadyInPortfolioHierarchy equals: anError messageText ]. ! !


!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'nm 11/10/2022 16:49:06'!
assertThat: aFinantialEntity shouldRaiseErrorWhenAttemptingToAddTo: aPortfolio
	self should: [aPortfolio add: 	aFinantialEntity]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: Portfolio financialEntityAlreadyInPortfolioHierarchy equals: anError messageText ]. ! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'nm 11/8/2022 20:37:28'!
value 
	^value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'nm 11/8/2022 20:39:55'!
initializeFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'nm 11/8/2022 21:35:45'!
applyTo: aBalance
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'nm 11/8/2022 20:39:11'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'application' stamp: 'nm 11/4/2022 19:40:24'!
applyTo: aBalance
	^aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DepositLeg
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLeg methodsFor: 'counterpart' stamp: 'nm 11/8/2022 20:41:08'!
associateCounterpart: anExtractionLeg
	counterpart := anExtractionLeg! !

!DepositLeg methodsFor: 'counterpart' stamp: 'nm 11/8/2022 20:35:41'!
counterpart
	^counterpart! !


!DepositLeg methodsFor: 'application' stamp: 'nm 11/8/2022 20:38:06'!
applyTo: aBalance
	^aBalance + value.! !


!classDefinition: #ExtractionLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #ExtractionLeg
	instanceVariableNames: 'counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ExtractionLeg methodsFor: 'application' stamp: 'nm 11/8/2022 20:47:12'!
applyTo: aBalance
	^aBalance - value.! !


!ExtractionLeg methodsFor: 'counterpart' stamp: 'nm 11/8/2022 20:46:53'!
associateCounterpart: anExtractionLeg
	counterpart := anExtractionLeg! !

!ExtractionLeg methodsFor: 'counterpart' stamp: 'nm 11/8/2022 20:47:21'!
counterpart
	^counterpart! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'application' stamp: 'nm 11/4/2022 19:40:59'!
applyTo: aBalance
	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountsTransference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountsTransference
	instanceVariableNames: 'value extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountsTransference methodsFor: 'initialization' stamp: 'nm 11/10/2022 15:02:55'!
transferenceFrom: aTransmitterAccount  to: aReceptorAccount forAmount: aValue
	aValue <= 0 ifTrue: [^self error: AccountsTransference invalidAmount].

	extractionLeg := ExtractionLeg register: aValue on: aTransmitterAccount.
	depositLeg := DepositLeg register: aValue on: aReceptorAccount.
	
	" no se crean las legs completas de una debido a que de hacerlo queda alguna de las dos en nil "
	extractionLeg associateCounterpart: depositLeg.
	depositLeg associateCounterpart: extractionLeg.
	
	value := aValue.
	! !


!AccountsTransference methodsFor: 'accessing' stamp: 'nm 11/8/2022 20:26:28'!
depositLeg
	^depositLeg! !

!AccountsTransference methodsFor: 'accessing' stamp: 'nm 11/8/2022 20:27:13'!
extractionLeg
	^extractionLeg! !

!AccountsTransference methodsFor: 'accessing' stamp: 'nm 11/7/2022 13:36:17'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountsTransference class' category: 'ServiciosFinancieros-Ejercicio'!
AccountsTransference class
	instanceVariableNames: ''!

!AccountsTransference class methodsFor: 'instance creation' stamp: 'nm 11/7/2022 13:33:56'!
from: aTransmitterAccount to: aReceiverAccount forAmount: aValue 
	^self new transferenceFrom: aTransmitterAccount to: aReceiverAccount forAmount: aValue. ! !


!AccountsTransference class methodsFor: 'as yet unclassified' stamp: 'nm 11/10/2022 15:00:12'!
invalidAmount
	^'amount must be positive'! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'associatedFinantialEntities portfoliosThatContainSelf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'nm 11/10/2022 15:26:02'!
balance
	^associatedFinantialEntities sum: [:anAccount | anAccount balance] ifEmpty: [^0].! !

!Portfolio methodsFor: 'accessing' stamp: 'nm 11/10/2022 15:34:53'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	associatedFinantialEntities do: [:anEntity | transactions add: anEntity transactions].
	^transactions.! !


!Portfolio methodsFor: 'adding' stamp: 'nm 11/10/2022 16:37:07'!
add: aFinantialEntity

	(self cannotAdd: aFinantialEntity) ifTrue: [^self error: Portfolio financialEntityAlreadyInPortfolioHierarchy].
	
	associatedFinantialEntities add: aFinantialEntity.
	(aFinantialEntity isKindOf: Portfolio) ifTrue: [aFinantialEntity registerAsParent: self].
	! !

!Portfolio methodsFor: 'adding' stamp: 'nm 11/11/2022 12:29:38'!
registerAsParent: aPortfolio
	portfoliosThatContainSelf add: aPortfolio! !


!Portfolio methodsFor: 'initialization' stamp: 'nm 11/11/2022 12:29:05'!
initialize
	associatedFinantialEntities := Set new.
	portfoliosThatContainSelf := Set with: self.! !


!Portfolio methodsFor: 'transactions' stamp: 'nm 11/10/2022 15:26:02'!
hasRegistered: aTransaction
	^ associatedFinantialEntities anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'transactions' stamp: 'nm 11/10/2022 15:26:02'!
transactionsWereMade
	^ associatedFinantialEntities anySatisfy: [ :anAccount | anAccount transactionsWereMade ].! !


!Portfolio methodsFor: 'verifications' stamp: 'nm 11/11/2022 12:45:35'!
cannotAdd: aFinantialEntity
	(aFinantialEntity isKindOf: Portfolio) ifTrue: [^(self isAlreadyInHierarchy: aFinantialEntity) 
					or: [aFinantialEntity containsAnEntityFrom: associatedFinantialEntities].].
	(aFinantialEntity isKindOf: ReceptiveAccount) ifTrue: [^self isAlreadyInHierarchy: aFinantialEntity] ! !

!Portfolio methodsFor: 'verifications' stamp: 'nm 11/10/2022 16:39:35'!
contains: aFinantialEntity
	^(associatedFinantialEntities anySatisfy: [:anEntity | anEntity contains: aFinantialEntity]) or: [aFinantialEntity = self].! !

!Portfolio methodsFor: 'verifications' stamp: 'nm 11/11/2022 12:43:32'!
isAlreadyInHierarchy: aFinantialEntity
	^(self contains: aFinantialEntity) or: [self includesAFinantialEntityFrom: aFinantialEntity in: portfoliosThatContainSelf ]! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'nm 11/11/2022 12:44:43'!
containsAnEntityFrom: aGroupOfEntities 
	 ^aGroupOfEntities anySatisfy: [:anEntity | self contains: anEntity].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'nm 11/11/2022 12:42:43'!
includesAFinantialEntityFrom: aFinantialEntity in: aGroupOfEntities 
	 ^aGroupOfEntities anySatisfy: [:anEntity | anEntity contains: aFinantialEntity].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'nm 11/10/2022 16:17:24'!
associatedToFinantialEntity: aFinantialEntity
	^self new add: aFinantialEntity ! !


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'nm 11/10/2022 15:42:53'!
financialEntityAlreadyInPortfolioHierarchy
	^'finantial entity is already part of portfolio hierarchy'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'nm 11/4/2022 19:39:59'!
balance
	| aBalance |
	aBalance := 0.
	transactions do: [ :aTransaction | aBalance := aTransaction applyTo: aBalance ].
	^aBalance.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'nm 11/10/2022 14:52:53'!
transactionsWereMade

	^transactions isEmpty not.! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'nm 11/10/2022 15:56:29'!
contains: aFinantialEntity
	^self = aFinantialEntity! !

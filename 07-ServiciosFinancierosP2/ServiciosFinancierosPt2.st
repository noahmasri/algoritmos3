!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: 'accountWithNoTransactions reportOfAccountWithNoTransactions accountWithDeposit reportOfAccountWithDeposit accountWithWithdraw reportOfAccountWithWithdraw accountWithWithdrawLeg accountWithDepositLeg reportOfAccountWithWithdrawLeg reportOfAccountWithDepositLeg accountWithMultipleTransactions reportOfAccountWithMultipleTransactions portfolioWithMultipleTransactions reportOfPortfolioWithMultipleTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'set up' stamp: 'nm 11/17/2022 13:08:52'!
setUp
	| accountAux |
	accountWithNoTransactions := ReceptiveAccount new.
	reportOfAccountWithNoTransactions := (AccountSummary of: accountWithNoTransactions) exportReport.
	
	accountWithDeposit := ReceptiveAccount new.
	Deposit register: 50*peso on: accountWithDeposit.
	reportOfAccountWithDeposit := (AccountSummary of: accountWithDeposit) exportReport.
	
	accountWithWithdraw := ReceptiveAccount new.
	Withdraw register: 100*peso on: accountWithWithdraw.
	reportOfAccountWithWithdraw := (AccountSummary of: accountWithWithdraw) exportReport.
	
	accountWithWithdrawLeg := ReceptiveAccount new.
	accountWithDepositLeg := ReceptiveAccount new.
	Transfer amount: 200*peso from: accountWithWithdrawLeg to: accountWithDepositLeg.
	
	reportOfAccountWithWithdrawLeg := (AccountSummary of: accountWithWithdrawLeg) exportReport.
	reportOfAccountWithDepositLeg := (AccountSummary of: accountWithDepositLeg) exportReport.
	
	accountWithMultipleTransactions := ReceptiveAccount new.
	accountAux := ReceptiveAccount new.
	Deposit register: 100*peso on: accountWithMultipleTransactions.
	Withdraw register: 50*peso on: accountWithMultipleTransactions.
	Transfer amount: 20*peso from: accountWithMultipleTransactions to: accountAux.
	Transfer amount: 30*peso from: accountAux to: accountWithMultipleTransactions.
	
	reportOfAccountWithMultipleTransactions := (AccountSummary of: accountWithMultipleTransactions) exportReport.
	
	portfolioWithMultipleTransactions := Portfolio with: accountWithDeposit with: accountWithMultipleTransactions.
	reportOfPortfolioWithMultipleTransactions := (AccountSummary of: portfolioWithMultipleTransactions) exportReport.! !


!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:01:13'!
test01reportOfAnAccountWithNoTransactionsIncludesOnlyItsBalance
	
	self assertTransactionsShownInReport: reportOfAccountWithNoTransactions 
	equalsTransactions: {'Balance = 0 * pesos'}.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:06:28'!
test02reportOfAnAccountWithADepositShowsDepositWithItsValueAndAccountBalance
	
	self assertTransactionsShownInReport: reportOfAccountWithDeposit 
	equalsTransactions: {'Depósito por 50 * pesos'. 
					'Balance = 50 * pesos'}! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:06:22'!
test03reportOfAnAccountWithAWithdrawShowsWithdrawWithItsValueAndAccountBalance
	
	self assertTransactionsShownInReport: reportOfAccountWithWithdraw 
	equalsTransactions: {'Extracción por 100 * pesos'. 
					'Balance = -100 * pesos'}.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:06:16'!
test04reportOfAnAccountWithAWithdrawLegShowsWithdrawLegWithItsValueAndAccountBalance
	
	self assertTransactionsShownInReport: reportOfAccountWithWithdrawLeg 
	equalsTransactions: {'Salida por transferencia de 200 * pesos'. 
					'Balance = -200 * pesos'}.! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:06:09'!
test05reportOfAnAccountWithADepositLegShowsDepositLegWithItsValueAndAccountBalance
	
	self assertTransactionsShownInReport: reportOfAccountWithDepositLeg 
	equalsTransactions: {'Entrada por transferencia de 200 * pesos'. 
					'Balance = 200 * pesos'}.
	! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:06:03'!
test06reportOfAnAccountWithMultipleTransactionsShowsAllTransactionsWithTheirValuesAndAccountBalance

	self assertTransactionsShownInReport: reportOfAccountWithMultipleTransactions
	equalsTransactions: {'Depósito por 100 * pesos'.  
					'Extracción por 50 * pesos'.
					'Salida por transferencia de 20 * pesos'. 
					'Entrada por transferencia de 30 * pesos'.
					'Balance = 60 * pesos'.}! !

!AccountSummaryTest methodsFor: 'testing' stamp: 'nm 11/17/2022 13:10:21'!
test07reportOfAPortfolioWithMultipleTransactionsShowsAllTransactionsWithTheirValuesAndPortfolioBalance

	self assertTransactionsShownInReport: reportOfPortfolioWithMultipleTransactions 
	equalsTransactions: {'Depósito por 50 * pesos'. 
					'Depósito por 100 * pesos'.  
					'Extracción por 50 * pesos'.
					'Salida por transferencia de 20 * pesos'. 
					'Entrada por transferencia de 30 * pesos'.
					'Balance = 110 * pesos'.}! !


!AccountSummaryTest methodsFor: 'assertions' stamp: 'nm 11/17/2022 12:59:38'!
assertTransactionsShownInReport: aReport equalsTransactions: aCollectionOfTransactions

	self assert: aReport equals: aCollectionOfTransactions asOrderedCollection.
	! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: 'cuentaDeDraco cuentaDeHermione portfolioDeHogwarts portfolioDeGryffindor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/18/2022 00:03:09'!
test01DetailedPrinterOfAnEmptyPortfolioPrintsPortfolioNameAndZeroBalance
	| report |
	report := (PortfolioDetailedTreePrinter of: portfolioDeHogwarts) exportReport.
	
	self assert: report equals: {'Portfolio de Hogwarts'.
						  '     Balance = 0 * pesos'.} asOrderedCollection.! !

!PortfolioDetailedTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/18/2022 00:04:44'!
test02DetailedPrinterOfAPortfolioWithAnAccountPrintsItsAccountSummaryAndTotalBalanceWithAppropiateTabulation
	| report |
	portfolioDeHogwarts add: cuentaDeHermione.
	report := (PortfolioDetailedTreePrinter of: portfolioDeHogwarts) exportReport.

	self assert: report equals: {'Portfolio de Hogwarts'.
						  '     Cuenta de Hermione'.
						  '          Depósito por 100 * pesos'.
						  '          Extracción por 50 * pesos'.
						  '          Balance = 50 * pesos'.
						  '     Balance = 50 * pesos'.} asOrderedCollection.! !

!PortfolioDetailedTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/18/2022 00:06:06'!
test03DetailedPrinterOfAPortfolioAPortfolioPrintsInternalPortfolioDetailedTreeAndTotalBalanceWithAppropiateTabulation
	| report |
	portfolioDeHogwarts add: portfolioDeGryffindor.
	report := (PortfolioDetailedTreePrinter of: portfolioDeHogwarts) exportReport.

	self assert: report equals: {'Portfolio de Hogwarts'.
						  '     Portfolio de Gryffindor'.
						  '          Cuenta de Hermione'.
						  '               Depósito por 100 * pesos'.
						  '               Extracción por 50 * pesos'.
						  '               Balance = 50 * pesos'.
						  '          Balance = 50 * pesos'.
						  '     Balance = 50 * pesos'.} asOrderedCollection.! !


!PortfolioDetailedTreePrinterTest methodsFor: 'setUp' stamp: 'nm 11/18/2022 00:12:30'!
setUp
	cuentaDeDraco := ReceptiveAccount named: 'Cuenta de Draco Malfoy'.
	cuentaDeHermione := ReceptiveAccount named: 'Cuenta de Hermione'.
	
	Deposit register: 100*peso on: cuentaDeHermione.
	Withdraw register: 50*peso on: cuentaDeHermione.
	
	portfolioDeHogwarts := Portfolio named: 'Portfolio de Hogwarts'.
	
	portfolioDeGryffindor := Portfolio named: 'Portfolio de Gryffindor'.
	portfolioDeGryffindor add: cuentaDeHermione.
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #PortfolioTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTreePrinterTest
	instanceVariableNames: 'portfolioDeHogwarts portfolioDeGryffindor cuentaDeDraco cuentaDeHermione cuentaDeHagrid portfolioDeProfes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:32:06'!
test01anEmptyPortfolioPrintsOnlyItsName
	| report |
	report := (PortfolioTreePrinter of: portfolioDeHogwarts) exportReport. 
	
	self assertTreeShownInReport: report equalsTree: {'Portfolio de Hogwarts'}.! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:31:51'!
test02aPortfolioWithOneAccountPrintsItsNameAndItsAccountsNameTabulated
	| report |
	portfolioDeHogwarts add: cuentaDeDraco.
	report := (PortfolioTreePrinter of: portfolioDeHogwarts) exportReport.
	
	self assertTreeShownInReport: report 
		equalsTree: {'Portfolio de Hogwarts'. 
				    '     Cuenta de Draco Malfoy'.}.
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:32:34'!
test03aPortfolioWithOnePortfolioPrintsItsNameAndItsPortfolioNameTabulated
	| report |
	portfolioDeHogwarts add: portfolioDeGryffindor.
	report := (PortfolioTreePrinter of: portfolioDeHogwarts) exportReport.
	
	self assertTreeShownInReport: report 
		equalsTree: {'Portfolio de Hogwarts'. 
				    '     Portfolio de Gryffindor'.}.
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:33:19'!
test04aPortfolioWithAPortfolioContainingAnAccountPrintsItsNameAndItsPortfolioTreePrintedTabulated
	| report |
	portfolioDeGryffindor add: cuentaDeHermione.
	portfolioDeHogwarts add: portfolioDeGryffindor.
	report := (PortfolioTreePrinter of: portfolioDeHogwarts) exportReport.
	
	self assertTreeShownInReport: report 
		equalsTree: {'Portfolio de Hogwarts'. 
				    '     Portfolio de Gryffindor'.
				    '          Cuenta de Hermione'}.
	! !

!PortfolioTreePrinterTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:34:45'!
test05aPortfolioContainingMultipleElementsPrintsAllItsTreeWithAppropriateTabulations
	| report |
	portfolioDeGryffindor add: cuentaDeHermione.
	portfolioDeGryffindor add: portfolioDeProfes .
	portfolioDeHogwarts add: portfolioDeGryffindor.
	portfolioDeHogwarts add: cuentaDeDraco .
	report := (PortfolioTreePrinter of: portfolioDeHogwarts) exportReport.
	
	self assertTreeShownInReport: report 
		equalsTree: {'Portfolio de Hogwarts'. 
				    '     Portfolio de Gryffindor'. 
				    '          Cuenta de Hermione'.
				    '          Portfolio de Profes'.
				    '               Cuenta de Hagrid'.
				    '     Cuenta de Draco Malfoy'.}.! !


!PortfolioTreePrinterTest methodsFor: 'set up' stamp: 'nm 11/17/2022 15:02:00'!
setUp
	cuentaDeDraco := ReceptiveAccount named: 'Cuenta de Draco Malfoy'.
	cuentaDeHermione := ReceptiveAccount named: 'Cuenta de Hermione'.
	cuentaDeHagrid := ReceptiveAccount named: 'Cuenta de Hagrid'.
	
	portfolioDeHogwarts := Portfolio named: 'Portfolio de Hogwarts'.
	portfolioDeGryffindor := Portfolio named: 'Portfolio de Gryffindor'.
	portfolioDeProfes := Portfolio named: 'Portfolio de Profes'.
	portfolioDeProfes add: cuentaDeHagrid.
	
	! !


!PortfolioTreePrinterTest methodsFor: 'assertions' stamp: 'nm 11/17/2022 15:28:48'!
assertTreeShownInReport: aReport equalsTree: anExpectedPortfolioTree
	self assert: aReport equals: anExpectedPortfolioTree asOrderedCollection
! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: 'accountWithNoTransfer transferNetOfAccountWithNoTransfer accountWithWithdrawLeg accountWithDepositLeg transferNetOfAccountWithWithdrawLeg transferNetOfAccountWithDepositLeg accountWithMultTransactions transferNetOfaccountWithMultTransactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:21:46'!
test01TransferNetOfAnAccountWithNoTransfersIsZero
	
	self assert: 0*peso equals: transferNetOfAccountWithNoTransfer 
	! !

!TransferNetTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:23:38'!
test02TransferNetOfAnAccountWithOnlyAWithdrawLegIsTransferValueNegated
	
	self assert: -10*peso equals: transferNetOfAccountWithWithdrawLeg
	! !

!TransferNetTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:23:50'!
test03TransferNetOfAnAccountWithOnlyADepositLegIsTransferValue
	
	self assert: 10*peso equals: transferNetOfAccountWithDepositLeg 
	! !

!TransferNetTest methodsFor: 'testing' stamp: 'nm 11/17/2022 15:25:56'!
test04TransferNetOfAnAccountWithMultipleTransactionsSumsValuesOfDepositLegAndSubstactsValuesOfWithdrawLegs
	
	self assert: 10*peso equals: transferNetOfaccountWithMultTransactions ! !


!TransferNetTest methodsFor: 'set up' stamp: 'nm 11/17/2022 15:25:33'!
setUp
	| accountAux |
	accountWithNoTransfer := ReceptiveAccount new.
	transferNetOfAccountWithNoTransfer := (TransferNet of: accountWithNoTransfer) exportReport.
	
	accountWithWithdrawLeg := ReceptiveAccount new.
	accountWithDepositLeg := ReceptiveAccount new.
	Transfer amount: 10*peso from: accountWithWithdrawLeg to: accountWithDepositLeg.
	transferNetOfAccountWithWithdrawLeg := (TransferNet of: accountWithWithdrawLeg) exportReport.
	transferNetOfAccountWithDepositLeg := (TransferNet of: accountWithDepositLeg) exportReport.
	
	accountWithMultTransactions := ReceptiveAccount new.
	accountAux := ReceptiveAccount new.
	Deposit register: 100*peso on: accountWithMultTransactions.
	Withdraw register: 50*peso on: accountWithMultTransactions.
	Transfer amount: 20*peso from: accountWithMultTransactions to: accountAux.
	Transfer amount: 30*peso from: accountAux to: accountWithMultTransactions.
	transferNetOfaccountWithMultTransactions := (TransferNet of: accountWithMultTransactions) exportReport.! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'testing' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'nm 11/17/2022 14:03:41'!
name
	^name! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'accepting visit - private' stamp: 'nm 11/17/2022 12:32:31'!
visitTransactionsFrom: aReport
	self transactions do: [:aTransaction | aTransaction visitFrom: aReport.].! !


!Account methodsFor: 'initialization' stamp: 'nm 11/17/2022 13:28:17'!
initializeWithName: aName
	name := aName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'ServiciosFinancieros-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'nm 11/17/2022 13:27:05'!
named: aName
	^self new initializeWithName: aName! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'nm 11/11/2022 20:22:10'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ (0*peso) ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'accepting visit - private' stamp: 'nm 11/17/2022 14:15:59'!
visitAccountsWith: aTreePrinter
	accounts do: [:anAccount | anAccount visitFrom: aTreePrinter]! !

!Portfolio methodsFor: 'accepting visit - private' stamp: 'nm 11/17/2022 14:37:35'!
visitFrom: aTreePrinter
	^aTreePrinter visitPortfolio: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'nm 11/11/2022 20:22:19'!
balance

	^transactions 
		inject: (0*peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'accepting visit - private' stamp: 'nm 11/17/2022 14:37:57'!
visitFrom: aTreePrinter
	^aTreePrinter visitReceptiveAccount: self! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:31:46'!
visitFrom: aReport
	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'nm 11/15/2022 21:28:04'!
affectBalance: aBalance

	^aBalance + value! !


!Deposit methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:31:38'!
visitFrom: aReport
	^aReport visitDeposit: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:31:59'!
visitFrom: aReport
	self subclassResponsibility ! !


!TransferLeg methodsFor: 'balance' stamp: 'nm 11/18/2022 00:14:35'!
affectBalance: aBalance
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:32:10'!
visitFrom: aReport
	^aReport visitDepositLeg: self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:32:22'!
visitFrom: aReport
	^aReport visitWithdrawLeg: self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'accepting visit - private' stamp: 'nm 11/15/2022 21:32:33'!
visitFrom: aReport
	^aReport visitWithdraw: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!


!Report methodsFor: 'functionality' stamp: 'nm 11/15/2022 21:38:18'!
exportReport
	self subclassResponsibility ! !

!Report methodsFor: 'functionality' stamp: 'nm 11/17/2022 23:12:31'!
initializeOf: anAccount
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'ServiciosFinancieros-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'nm 11/17/2022 23:14:46'!
of: anAccount 
	^self new initializeOf: anAccount! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'functionality' stamp: 'nm 11/17/2022 12:33:06'!
exportReport
	report := OrderedCollection new.
	account visitTransactionsFrom: self.
	report add: ('Balance = ', account balance asString).
	^report! !


!AccountSummary methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:33:05'!
visitDeposit: aDeposit
	report add: ('Depósito por ', aDeposit value asString)! !

!AccountSummary methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:33:05'!
visitDepositLeg: aDepositLeg
	report add: ('Entrada por transferencia de ', aDepositLeg value asString)! !

!AccountSummary methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:33:05'!
visitWithdraw: aWithdraw
	report add: ('Extracción por ', aWithdraw value asString)! !

!AccountSummary methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:33:05'!
visitWithdrawLeg: aWithdrawLeg
	report add: ('Salida por transferencia de ', aWithdrawLeg value asString)! !


!classDefinition: #PortfolioSpecialReport category: 'ServiciosFinancieros-Solucion'!
Report subclass: #PortfolioSpecialReport
	instanceVariableNames: 'tab'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioSpecialReport methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 23:55:40'!
visitPortfolio: aPortfolio
	| reportAux |
	reportAux := (self class of: aPortfolio) exportReport.
	report addAll: (self tabulated: reportAux).
	 ! !

!PortfolioSpecialReport methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 23:13:11'!
visitReceptiveAccount: aReceptiveAccount
	self subclassResponsibility ! !


!PortfolioSpecialReport methodsFor: 'functionality' stamp: 'nm 11/17/2022 23:13:39'!
exportReport
	self subclassResponsibility ! !


!PortfolioSpecialReport methodsFor: 'initialization' stamp: 'nm 11/17/2022 23:12:36'!
initializeOf: anAccount
	account := anAccount.
	tab := '     '.! !


!PortfolioSpecialReport methodsFor: 'formating' stamp: 'nm 11/17/2022 23:35:51'!
tabulated: aCollection
	^aCollection collect: [:aLine | tab , aLine ].! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioSpecialReport subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 23:56:35'!
visitReceptiveAccount: aReceptiveAccount
	| reportAux |
	reportAux := OrderedCollection with: aReceptiveAccount name.
	reportAux addAll: (self tabulated: (AccountSummary of: aReceptiveAccount) exportReport).
	report addAll: (self tabulated: reportAux).
! !


!PortfolioDetailedTreePrinter methodsFor: 'functionality' stamp: 'nm 11/17/2022 23:27:01'!
exportReport
	report := OrderedCollection new.
	report add: account name.
	account visitAccountsWith: self.
	report add: (tab, 'Balance = ', account balance asString).
	^report
	! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioSpecialReport subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'functionality' stamp: 'nm 11/17/2022 14:26:47'!
exportReport
	report := OrderedCollection new.
	report add: account name.
	account visitAccountsWith: self.
	^report
	! !


!PortfolioTreePrinter methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 14:56:11'!
visitReceptiveAccount: aReceptiveAccount
	report add: tab, aReceptiveAccount name.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'functionality' stamp: 'nm 11/17/2022 12:35:33'!
exportReport
	report := 0*peso.
	account visitTransactionsFrom: self.
	^report.! !


!TransferNet methodsFor: 'visiting - private' stamp: 'nm 11/15/2022 21:26:40'!
visitDeposit: aDeposit
	^0! !

!TransferNet methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:36:03'!
visitDepositLeg: aDepositLeg
	report := report + aDepositLeg value ! !

!TransferNet methodsFor: 'visiting - private' stamp: 'nm 11/15/2022 21:26:56'!
visitWithdraw: aWithdraw
	^0! !

!TransferNet methodsFor: 'visiting - private' stamp: 'nm 11/17/2022 12:36:28'!
visitWithdrawLeg: aWithdrawLeg
	report := report + aWithdrawLeg value negated! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !

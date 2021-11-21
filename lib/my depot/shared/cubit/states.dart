abstract class AppStates {}

// My Depot States :

class AppInitialState extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class AppCreateDataBaseState extends AppStates {}

class AppInsertDataBaseState extends AppStates {}

class AppGetDataBaseLoadingState extends AppStates {}

class AppUpdateDataBaseLoadingState extends AppStates {}

class AppDeleteDataBaseLoadingState extends AppStates {}

class AppGetDataBaseState extends AppStates {}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeCalculateState extends AppStates {}

class AppChangeTotalResultState extends AppStates {}

class BlocChangeState extends AppStates {}

// General Chart States :

class AppChangeTimeChartState extends AppStates {}

class AppChangeGoldChartState extends AppStates {}

class AppChangeCurrencyState extends AppStates {}

%--------------------------------------------------------------------------
%Step 1: Get data or load the already saved data
%--------------------------------------------------------------------------
%1.1. Use this command to get and save data
GetandSaveDataForAllCases();

%1.2. If the data have already been saved, use this command to load it.
%[S] = LoadSavedOriginalData();
%save('temp.mat', '-struct', 'S');
%load('temp.mat')

%1.3. Use this command to load a specific original data
%[ap_dataA, ap_colnamesA] = QueryOriginalData('ap', 'A');
%[aw_dataA, aw_colnamesA] = QueryOriginalData('aw', 'A');
%[gp_dataA, gp_colnamesA] = QueryOriginalData('gp', 'A');
%[gw_dataA, gw_colnamesA] = QueryOriginalData('gw', 'A');

%[ap_dataB, ap_colnamesB] = QueryOriginalData('ap', 'B');
%[aw_dataB, aw_colnamesB] = QueryOriginalData('aw', 'B');
%[gp_dataB, gp_colnamesB] = QueryOriginalData('gp', 'B');
%[gw_dataB, gw_colnamesB] = QueryOriginalData('gw', 'B');

%[ap_dataC, ap_colnamesC] = QueryOriginalData('ap', 'C');
%[aw_dataC, aw_colnamesC] = QueryOriginalData('aw', 'C');
%[gp_dataC, gp_colnamesC] = QueryOriginalData('gp', 'C');
%[gw_dataC, gw_colnamesC] = QueryOriginalData('gw', 'C');

%--------------------------------------------------------------------------
%Step 2: Get trn and tst data or load the already saved data
%--------------------------------------------------------------------------
%2.1 generate training and testing data using this command
GetTrnandTstDataForAllCases();
%2.2 get a specific trn and tst data

%[apA_trn, apA_tcolnames, apA_tst, apA_scolnames] = QueryTrnTstData('ap', 'A');
%[awA_trn, awA_tcolnames, awA_tst, awA_scolnames] = QueryTrnTstData('aw', 'A');
%[gpA_trn, gpA_tcolnames, gpA_tst, gpA_scolnames] = QueryTrnTstData('gp', 'A');
%[gwA_trn, gwA_tcolnames, gwA_tst, gwA_scolnames] = QueryTrnTstData('gw', 'A');

%[apB_trn, apB_tcolnames, apB_tst, apB_scolnames] = QueryTrnTstData('ap', 'B');
%[awB_trn, awB_tcolnames, awB_tst, awB_scolnames] = QueryTrnTstData('aw', 'B');
%[gpB_trn, gpB_tcolnames, gpB_tst, gpB_scolnames] = QueryTrnTstData('gp', 'B');
%[gwB_trn, gwB_tcolnames, gwB_tst, gwB_scolnames] = QueryTrnTstData('gw', 'B');

%[apC_trn, apC_tcolnames, apC_tst, apC_scolnames] = QueryTrnTstData('ap', 'C');
%[awC_trn, awC_tcolnames, awC_tst, awC_scolnames] = QueryTrnTstData('aw', 'C');
%[gpC_trn, gpC_tcolnames, gpC_tst, gpC_scolnames] = QueryTrnTstData('gp', 'C');
%[gwC_trn, gwC_tcolnames, gwC_tst, gwC_scolnames] = QueryTrnTstData('gw', 'C');
function results = runmlflowtests(testName)
    % runmlflowtests Run the mlflow tests
    %
    % Call this function with a name (no extension) under which the results
    % should be saved.
   
    %  Copyright 2022-2024 MathWorks, Inc.

    if (strcmp(testName, 'mlflowazure') || strcmp(testName, 'mlflowaws')) && ~mlflow.Object.isDatabricks
        fprintf("Tests running outside the context of Databricks skipping, test: %s\n", testName);
        results = matlab.unittest.TestResult;
        return;
    end

    % Turn off warnings for missing fields in JSON decoding, and turn them
    % back later on.
    oldState = warning('off', 'mlflow:json_entries_missing');
    resetState = onCleanup(@() warning(oldState));

    import matlab.unittest.TestRunner;
    import matlab.unittest.TestSuite;
    import matlab.unittest.plugins.XMLPlugin;

    testFolder = mlflowRoot('test', 'unit');

    % Setup the runner
    runner = TestRunner.withNoPlugins;
    %     runner = TestRunner.withTextOutput('OutputDetail',3);
    % import matlab.unittest.plugins.TestReportPlugin

    runner.addPlugin(matlab.unittest.plugins.DiagnosticsRecordingPlugin);

    % Add JUnit style reports
    xmlFile = mlflowRoot('tmp',[char(testName), '.xml']);
    p = XMLPlugin.producingJUnitFormat(xmlFile);
    runner.addPlugin(p);

    suite = TestSuite.fromFolder(testFolder);
    
    % Run the tests and display results
    results = runner.run(suite);
    table(results)
    displayFailures(results)
end

function displayFailures(results)
    idx = find([results.Failed]);
    for k=idx
        R = results(k);
        fprintf('+++++++++++++++++++++++++++++++++++++++\n')
        fprintf("Failure: %s\n", R.Name);
        if isfield(R.Details, 'DiagnosticRecord')
            fprintf('%s\n', R.Details.DiagnosticRecord.Report)
        end
    end
end

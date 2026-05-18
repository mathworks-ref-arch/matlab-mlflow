classdef testArtifact < matlab.unittest.TestCase
    % TESTARTIFACT Unit testing the MLflow Artifact object

    % TODO add unit test for Artifact.fromJSON methods

    % (c) 2020-2024 MathWorks, Inc.

    properties
        fixedName = getenv('MLFLOW_UNITTESTSPATH');
        user_id = getenv('MLFLOW_UNITTESTSUSERID');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Please add your test cases below
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (TestMethodSetup)
        function testSetup(testCase)
            testCase.fixedName = getenv('MLFLOW_UNITTESTSPATH');
            testCase.user_id = getenv('MLFLOW_UNITTESTSUSERID');
        end
    end

    methods (TestMethodTeardown)
        function testTearDown(testCase) %#ok<MANU>

        end
    end

    methods (Test)
        function testArtifactConstructor(testCase)
            disp("Running testArtifactConstructor");
            % Test constructor
            art = mlflow.Artifact();
            testCase.verifyClass(art,'mlflow.Artifact');

            art.run_id = 'myRun_id'; % This should be converted to a string
            art.path = "myPath";
            art.page_token = "myPage_token";

            % Verify
            testCase.verifyTrue(strcmp(art.run_id, "myRun_id"));
            testCase.verifyClass(art.run_id, 'string');
            testCase.verifyTrue(strcmp(art.path, "myPath"));
            testCase.verifyTrue(strcmp(art.page_token, "myPage_token"));
        end

        function testArtifactList(testCase)
            disp("Running testArtifactList");
            % Experiments by name
            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITTESTSPATH to be set e.g.: /Shared/UnitTests');
            end
            if isempty(testCase.user_id)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITTESTSUSERID to be set e.g.: joe@example.com');
            end
            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            runObj = mle.createRun();
            % Configure the user_id
            runObj.user_id = testCase.user_id;

            runObj.create();
            pause(5);
            runObj.refresh();

            art = mlflow.Artifact();
            resultsList = art.list(runObj.run_id);
            testCase.verifyClass(resultsList.root_uri, 'char');
            testCase.verifyNotEmpty(resultsList.root_uri);

            % Databricks implementation specific  test
            disp(resultsList.root_uri);
            if runObj.isDatabricks
                testCase.verifyTrue(startsWith(resultsList.root_uri, 'dbfs:/databricks/mlflow'));
            else
                testCase.verifyTrue(startsWith(resultsList.root_uri, "mlflow-artifacts"));
            end

            testCase.verifyClass(art.run_id, 'string');

            % TODO log artifacts and and check path and int replacement in
            % fileinfos

            % Verify
            % testCase.verifyTrue(strcmp(art.run_id, "myRun_id"));
            % testCase.verifyTrue(strcmp(art.path, "myPath"));
            % testCase.verifyTrue(strcmp(art.page_token, "myPage_token"));
        end
    end
end


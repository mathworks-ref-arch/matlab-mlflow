classdef testRun < matlab.unittest.TestCase
% TESTRUN Unit testing stub for mflow.Run

%  (c) 2020-2022 MathWorks, Inc. 

    properties
        fixedName = getenv('MLFLOW_UNITTESTSPATH');
        user_id = getenv('MLFLOW_UNITTESTSUSERID');
    end

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
        function testConstructor(testCase)
            disp("Running testConstructor");
            % Create an object
            runObj = mlflow.Run;
            testCase.assertClass(runObj,'mlflow.Run');
        end
        
        function testRunCreationDeletion(testCase)
            disp("Running testRunCreationDeletion");
            % Experiments by name
            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITTESTSPATH to be set e.g.: /Shared/UnitTests/UnitTestExperiment');
            end            
            if isempty(testCase.user_id)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITTESTSUSERID to be set e.g.: joe@example.com');
            end
            
            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            runObj = mle.createRun();
            
            % Ensure that we have a run obj
            testCase.assertClass(runObj,'mlflow.Run');
            testCase.assertEqual(runObj.experiment_id, mle.experiment_id);
            
            % Configure the user_id
            runObj.user_id = testCase.user_id;
            runObj.create();
            
            % Check that we have an ID with the run
            testCase.assertNotEmpty(runObj.run_id);
            % Check type conversion
            testCase.verifyClass(runObj.start_time, "int64");

            if isprop(runObj,'end_time')
                % Only Databricks has end_time (at least at this stage)
                testCase.verifyClass(runObj.end_time, "int64");
            end
            
            % Delete it
            runObj.remove();
            
            % Restore it
            runObj.restore();
            
            % Clean it up for good
            runObj.remove();
        end
        
        function testRefreshMetadata(testCase)
            disp("Running testRefreshMetadata");
            % Experiments by name
            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITESTSPATH to be set e.g.: /Users/joe@example.com/UnitTests');
            end            
            if isempty(testCase.user_id)
                error('MLFLOW:UNITTEST','Expected environment variable MLFLOW_UNITTESTSUSERID to be set e.g.: joe@example.com');
            end
            
            
            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            runObj = mle.createRun();
            
            % Ensure that we have a run obj
            testCase.assertClass(runObj,'mlflow.Run');
            testCase.assertEqual(runObj.experiment_id, mle.experiment_id);
            
            % Configure the user_id
            runObj.user_id = testCase.user_id;
            runObj.create();
            
            %Check that we have an ID with the run
            testCase.assertNotEmpty(runObj.run_id);

            % Refresh metadata
            runObj.refresh();
            % Check int64s were translated
            testCase.verifyClass(runObj.start_time, "int64");
            if isprop(runObj,'end_time')
                % Only Databricks has end_time (at least at this stage)
                testCase.verifyClass(runObj.end_time, "int64");
            end
            % Check a non default vaue was populated
            testCase.verifyClass(runObj.lifecycle_stage, "string");
            testCase.verifyNotEmpty(runObj.lifecycle_stage);
            
            % Clean it up for good
            runObj.remove();
        end
    end
    
end


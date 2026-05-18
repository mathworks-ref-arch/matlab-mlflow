classdef testRunInfo < matlab.unittest.TestCase
    % TESTRUNINFO Unit test for RunInfo
    
    %  (c) 2021 MathWorks, Inc.

    methods (TestMethodSetup)
        function testSetup(testCase) %#ok<MANU>
            
        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase) %#ok<MANU>

        end
    end

    methods (Test)
        function testConstructor(testCase)
            disp("Running testConstructor")
            % Create with no arguments
            ri0 = mlflow.RunInfo;
            testCase.verifyClass(ri0, 'mlflow.RunInfo');
            
            iStruct = struct;
            iStruct.run_id = "myrun_id";
            iStruct.experiment_id = "myexperiment_id";
            iStruct.start_time = int64(123456);
            iStruct.end_time = int64(7891011);
            iStruct.artifact_uri = "http://myartifact_uri";
            iStruct.lifecycle_stage = "active";

            ri1 = mlflow.RunInfo(iStruct);
            testCase.verifyClass(ri1, 'mlflow.RunInfo');
            testCase.verifyClass(ri1.start_time, 'int64');
            testCase.verifyEqual(ri1.start_time, int64(123456));
            testCase.verifyClass(ri1.end_time, 'int64');
            testCase.verifyClass(ri1.experiment_id, 'string');
            % TODO
            % testCase.verifyClass(ri1.status, '???');
            testCase.verifyClass(ri1.run_id, 'string');
            testCase.verifyTrue(strcmp(ri1.run_id, "myrun_id"));
            testCase.verifyClass(ri1.artifact_uri, 'string');
            testCase.verifyClass(ri1.lifecycle_stage, 'string');
        end
    end
end


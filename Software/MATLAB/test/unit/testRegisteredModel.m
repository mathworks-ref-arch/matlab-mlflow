classdef testRegisteredModel < matlab.unittest.TestCase
    % TESTMODELVERSION Unit tests for Registered Model

    %  (c) 2021 MathWorks, Inc.

    properties
        isDatabricks logical
    end

    methods (TestClassSetup)
        function classSetup(testCase)
            exp = mlflow.Experiment();
            testCase.isDatabricks = exp.isDatabricks;
        end
    end

    methods (TestMethodSetup)
        function testSetup(testCase) %#ok<MANU>

        end
    end

    methods (TestMethodTeardown)
        function testTearDown(testCase) %#ok<MANU>

        end
    end

    methods (Test)
        function testConstructorRegisteredModel(testCase)
            disp("Running testConstructorRegisteredModel");
            rm = mlflow.RegisteredModel;
            testCase.verifyClass(rm, 'mlflow.RegisteredModel');
        end

        function testConstructorRegisteredModelTag(testCase)
            disp("Running testConstructorRegisteredModelTag");
            if ~testCase.isDatabricks
                % Current setup (in gitlab) only works within the Databricks environment
                return;
            end

            rmt0 = mlflow.RegisteredModelTag;
            testCase.verifyClass(rmt0, 'mlflow.RegisteredModelTag');

            % Create the test tag with k,v pair
            rmt1 = mlflow.RegisteredModelTag('mykey','myvalue');
            testCase.verifyClass(rmt1, 'mlflow.RegisteredModelTag');
            testCase.verifyEqual(rmt1.key, "mykey");
            testCase.verifyEqual(rmt1.value, "myvalue");

            % Create a vectorized set of ModelVersionTag
            rmt2 = mlflow.RegisteredModelTag( ...
                'key1', 'val1', 'key2', 'val2', 'key3', 'val3');
            testCase.verifyClass(rmt2, 'mlflow.RegisteredModelTag');
            testCase.verifyLength(rmt2, 3);

            testCase.verifyEqual(rmt2(1).key, "key1");
            testCase.verifyEqual(rmt2(1).value, "val1");

            testCase.verifyEqual(rmt2(2).key, "key2");
            testCase.verifyEqual(rmt2(2).value, "val2");

            testCase.verifyEqual(rmt2(3).key, "key3");
            testCase.verifyEqual(rmt2(3).value, "val3");
        end


        function testRMCreate(testCase)
            disp("Running testRMCreate");
            if ~testCase.isDatabricks
                % Current setup (in gitlab) only works within the Databricks environment
                return;
            end
            rm = mlflow.RegisteredModel;
            rm.name = 'unit test registered model';
            rm.description = 'a model version description';
            rmt = mlflow.RegisteredModelTag('mykey','myvalue');
            rm.tags = rmt;

            result = rm.create();

            testCase.verifyClass(result, 'mlflow.RegisteredModel');

            % Remove the model afterwards
            rm.remove();
        end
    end %methods
end %class

classdef testModelVersion < matlab.unittest.TestCase
    % TESTMODELVERSION Unit tests for Model Version

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
        function testConstructorModelVersionX(testCase)
            disp("Running testConstructorModelVersionX");
            mv0 = mlflow.ModelVersion;
            testCase.verifyClass(mv0, 'mlflow.ModelVersion');
        end

        function testConstructorModelTag(testCase)
            disp("Running testConstructorModelTag");
            mvt0 = mlflow.ModelVersionTag;
            testCase.verifyClass(mvt0, 'mlflow.ModelVersionTag');

            % Create the test tag with k,v pair
            mvt1 = mlflow.ModelVersionTag('mykey','myvalue');
            testCase.verifyClass(mvt1, 'mlflow.ModelVersionTag');
            testCase.verifyEqual(mvt1.key, "mykey");
            testCase.verifyEqual(mvt1.value, "myvalue");

            % Create a vectorized set of ModelVersionTag
            mvt2 = mlflow.ModelVersionTag(...
                'key1', 'val1', ...
                'key2', 'val2', ...
                'key3', 'val3');
            testCase.verifyClass(mvt2, 'mlflow.ModelVersionTag');
            testCase.verifyLength(mvt2, 3);

            testCase.verifyEqual(mvt2(1).key, "key1");
            testCase.verifyEqual(mvt2(1).value, "val1");

            testCase.verifyEqual(mvt2(2).key, "key2");
            testCase.verifyEqual(mvt2(2).value, "val2");

            testCase.verifyEqual(mvt2(3).key, "key3");
            testCase.verifyEqual(mvt2(3).value, "val3");
        end

        function testConstructorModelStatus(testCase)
            disp("Running testConstructorModelStatus");
            mvs0 = mlflow.ModelVersionStatus.PENDING_REGISTRATION;
            testCase.verifyClass(mvs0, 'mlflow.ModelVersionStatus');
        end

        function testMVSEnum(testCase)
            disp("Running testMVSEnum");
            mvs0 = mlflow.ModelVersionStatus.PENDING_REGISTRATION;
            testCase.verifyClass(mvs0, 'mlflow.ModelVersionStatus');
            mvs0 = mlflow.ModelVersionStatus.FAILED_REGISTRATION;
            testCase.verifyClass(mvs0, 'mlflow.ModelVersionStatus');
            mvs0 = mlflow.ModelVersionStatus.READY;
            testCase.verifyClass(mvs0, 'mlflow.ModelVersionStatus');
        end

        function testMVCreate(testCase)
            disp("Running testMVCreate");
            % TODO: Need to set the source to something else, probably DBFS
            % Removing from tests right now.
            return;
            mv = mlflow.ModelVersion;
            mv.name = 'unit test model version';
            mv.source = 'https://mysourceurl';
            mv.run_id = '1234567';
            mvt = mlflow.ModelVersionTag('mykey','myvalue');
            mv.tags = mvt;
            mv.run_link = 'https://myrunlinkurl';
            mv.description = 'a model version description';

            result = mv.create();
        end
    end %methods
end %class

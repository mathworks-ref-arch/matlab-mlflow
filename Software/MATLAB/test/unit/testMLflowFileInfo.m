classdef testMLflowFileInfo < matlab.unittest.TestCase
% TESTMLFLOWFILEINFO Unit testing the MLflow FileInfo object

% (c) 2020 MathWorks, Inc. 

    properties

    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Please add your test cases below 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
            disp("Running testConstructor");
            % Test constructor
            fi = mlflow.FileInfo();
            testCase.verifyClass(fi,'mlflow.FileInfo');
        end

        function testScalarArgs(testCase)
            disp("Running testScalarArgs");
            % Test scalar arguments
            fi1 = mlflow.FileInfo('mypath', false, int64(1234));
            testCase.verifyTrue(strcmp(fi1.path, "mypath"));
            testCase.verifyClass(fi1.path, 'string');
            testCase.verifyFalse(fi1.is_dir);
            testCase.verifyEqual(fi1.file_size, int64(1234));
            testCase.verifyClass(fi1.file_size, 'int64');
        end

        function testCellArgs(testCase)
            disp("Running testCellArgs");
            % Test cell array arguments
            paths = {'myArtifact1', 'myDirectory', "myArtifact2"};
            dirTFs = {false, true, false};
            sizes = {int64(1234), int64.empty, int64(0)};
            fi2 = mlflow.FileInfo(paths, dirTFs, sizes);

            testCase.verifyTrue(strcmp(fi2(1).path, "myArtifact1"));
            testCase.verifyTrue(strcmp(fi2(2).path, "myDirectory"));
            testCase.verifyTrue(strcmp(fi2(3).path, "myArtifact2"));
            
            testCase.verifyClass(fi2(1).path, 'string');
            testCase.verifyClass(fi2(2).path, 'string');
            testCase.verifyClass(fi2(3).path, 'string');

            testCase.verifyFalse(fi2(1).is_dir);
            testCase.verifyTrue(fi2(2).is_dir);
            testCase.verifyFalse(fi2(3).is_dir);

            testCase.verifyEqual(fi2(1).file_size, int64(1234));
            testCase.verifyClass(fi2(1).file_size, 'int64');
            testCase.verifyEmpty(fi2(2).file_size);
            testCase.verifyClass(fi2(2).file_size, 'int64');
            testCase.verifyEqual(fi2(3).file_size, int64(0));
            testCase.verifyClass(fi2(3).file_size, 'int64');
        end
    end
end


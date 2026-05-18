classdef testRunTag < matlab.unittest.TestCase
    % TESTRUNTAG Unit test for the runtag
    
    %  Copyright 2020-2022 MathWorks, Inc.

    methods (TestMethodSetup)
        function testSetup(testCase)
            
        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase)

        end
    end

    methods (Test)
        function testConstructor(testCase)
            disp("Running testConstructor")

            % Create the test tag
            tt0 = mlflow.RunTag;
            testCase.verifyClass(tt0, 'mlflow.RunTag');
            
            % Create the test tag with k,v pair
            tt1 = mlflow.RunTag('mykey','myvalue');
            testCase.verifyClass(tt1, 'mlflow.RunTag');
            testCase.verifyEqual(tt1.key, "mykey");
            testCase.verifyEqual(tt1.value, "myvalue");
        end
    end
end


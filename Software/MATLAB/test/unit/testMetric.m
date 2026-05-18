classdef testMetric < matlab.unittest.TestCase
% TESTMETRIC This is a test stub for a unit testing
% The assertions that you can use in your test cases:
%
%    assertTrue
%    assertFalse
%    assertEqual
%    assertFilesEqual
%    assertElementsAlmostEqual
%    assertVectorsAlmostEqual
%    assertExceptionThrown
%
%   A more detailed explanation goes here.
%
% Notes:

%                 (c) 2020-2024 MathWorks, Inc. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Please add your test cases below 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (TestMethodSetup)
        function testSetup(testCase)

        end
    end
    
    methods (TestMethodTeardown)
        function testTearDown(testCase)

        end
    end

    methods (Test)
        function testRealSolution(testCase)
            disp("testMetric not implemented, skipping");            % INSERT THE TEST CODE
            %actSolution = quadraticSolver(1,-3,2); % Expected to fail
            actSolution = [2,1];
            expSolution = [2,1];
            testCase.verifyEqual(actSolution,expSolution);
        end
    end
end


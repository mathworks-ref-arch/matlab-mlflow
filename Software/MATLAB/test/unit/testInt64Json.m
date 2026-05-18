classdef testInt64Json < matlab.unittest.TestCase
% TESTINT64JSON Unit testing the MLflow Artifact object

% (c) 2021-2024 MathWorks, Inc. 

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
        function testFieldReplacement(testCase)
            disp("Running testFieldReplacement");
            % Create some input json
            a = struct;
            a.a = pi;
            a.b = int64(123);
            a.c = "String1";
            a.d = ["StrArray1", "StrArray2"]; 
            tmpStruct.i64a = int64(12345);
            tmpStruct.i64b = int64(67890);
            tmpStruct.i64c = intmax("int64");
            tmpStruct.c = pi*2;
            a.e = tmpStruct;
            v = struct;
            for n=1:5
                v(n).c = ['abc', num2str(n)];
                v(n).i = int64(n);
            end
            a.v = v;
            % jsonencode of int64 works as expected
            jsonStr = jsonencode(a);

            % Check that the e.i64a value is convert to int64
            % and e.i64b defaults to a double
            allowMissing = false;
            structResult = mlflow.jsondecode(jsonStr, allowMissing, {"e", "i64a"}, "int64"); %#ok<CLARRSTR>
            testCase.verifyClass(structResult.e.i64a, 'int64');
            testCase.verifyClass(structResult.e.i64b, 'double');

            % Check conversion bases on an array
            structResult = mlflow.jsondecode(jsonStr, allowMissing, {"b"}, "int64", {"e", "i64c"}, "int64", {"e", "i64a"}, "int64", {"e", "i64b"}, "int64"); %#ok<STRSCALR,CLARRSTR>
            testCase.verifyClass(structResult.e.i64a, 'int64');
            testCase.verifyClass(structResult.e.i64b, 'int64');

            testCase.verifyEqual(structResult.e.i64a, a.e.i64a);
            testCase.verifyEqual(structResult.e.i64b, a.e.i64b);
            testCase.verifyEqual(structResult.e.i64c, a.e.i64c);

            % verify at the struct level too
            testCase.verifyEqual(structResult.a, a.a);
            testCase.verifyEqual(structResult.b, a.b);
            testCase.verifyEqual(structResult.c, char(a.c));
            
            scalarResult = jsondecodeTypedValues('1234', allowMissing, {""}, "int64"); %#ok<STRSCALR>
            testCase.verifyEqual(scalarResult, int64(1234));
            
            structResult = mlflow.jsondecode(jsonStr, allowMissing, {"v", {2}, "i"}, "int64");
            testCase.verifyEqual(structResult.v(2).i, int64(2));
            
            structResult = mlflow.jsondecode(jsonStr, allowMissing, {"v", {':'}, "i"}, "int64");
            testCase.verifyEqual(structResult.v(1).i, int64(1));
            testCase.verifyEqual(structResult.v(2).i, int64(2));
            testCase.verifyEqual(structResult.v(5).i, int64(5));
        end
        
        function testFieldBadName(testCase)
            disp("Running testFieldBadName");
            % Note $a name which can't be a matlab struct field name
            badJsonStr = '{"v":[{"c":"abc1","i":1},{"c":"abc2","i":2},{"c":"abc3","i":3},{"c":"abc4","i":4},{"c":"abc5","i":5}],"$a":{"b":123}}';   
            allowMissing = false;
            structResult = mlflow.jsondecode(badJsonStr, allowMissing, {"$a", "b"}, "int64"); %#ok<CLARRSTR> 
            testCase.verifyClass(structResult.x_a.b, 'int64')
            testCase.verifyEqual(structResult.x_a.b, int64(123));
        end

        function testAllowMissing(testCase)
            disp("Running testAllowMissing");

            s.a.b.c = intmax("int64");
            s_json = jsonencode(s);
          
            % Just testing a normal case
            r1 = mlflow.jsondecode(s_json, true, {"a", "b", "c"}, "int64"); %#ok<CLARRSTR> 
            testCase.verifyEqual(r1.a.b.c, s.a.b.c);

            % Test with something that's not there, but allow missing:
            r2 = mlflow.jsondecode(s_json, true, {"a", "b", "c"}, "int64", {"a", "b", "NOT_HERE"}, "int64"); %#ok<CLARRSTR> 
            testCase.verifyEqual(r2.a.b.c, s.a.b.c);

            % Test with something that's not there, but disallow missing:
            mytest = @() mlflow.jsondecode(s_json, false, {"a", "b", "c"}, "int64", {"a", "b", "NOT_HERE"}, "int64"); %#ok<CLARRSTR> 
            testCase.verifyError(mytest, 'ERROR:JSONERROR')
        end
    end
end


classdef testExperiment < matlab.unittest.TestCase
    % TESTEXPERIMENT Unit testing the Experiment endpoints

    %  (c) 2020-2022 MathWorks, Inc.

    properties
        exName
        exNameRoot = getenv('MLFLOW_EXPERIMENT_ROOT');
        fixedName = getenv('MLFLOW_UNITTESTSPATH');
        isDatabricks logical
    end

    methods (TestClassSetup)
        function classSetup(testCase)
            exp = mlflow.Experiment();
            testCase.exNameRoot = getenv('MLFLOW_EXPERIMENT_ROOT');
            testCase.fixedName = getenv('MLFLOW_UNITTESTSPATH');
            testCase.isDatabricks = exp.isDatabricks;

            experiment = createFixtureExperiment(testCase.fixedName) %#ok<NOPRT,NASGU>
        end
    end
    methods (TestMethodSetup)
        function testSetup(testCase)
            testCase.exName = [testCase.exNameRoot,  ...
                datestr(now, 'yyyymmddTHHMMSS_FFF')]; %#ok<TNOW1,DATST>
        end
    end

    methods (TestMethodTeardown)
        function testTearDown(testCase) %#ok<MANU>

        end
    end

    methods (Test)
        function testConstructor(testCase)
            disp("Running testConstructor");
            % Create an experiment object
            ex = mlflow.Experiment;
            testCase.verifyClass(ex, 'mlflow.Experiment');
        end

        function testListExperiments(testCase)
            disp("Running testListExperiments");
            % List existing experiments on mlflow
            if ~mlflow.Experiment.isDatabricks
                return;
            end
            
            exp = mlflow.Experiment.list();

            if ~isempty(exp)
                testCase.verifyClass(exp,'mlflow.Experiment');
            end

            % List existing experiments on mlflow
            exp = mlflow.Experiment.list('active_only');

            if ~isempty(exp)
                testCase.verifyClass(exp,'mlflow.Experiment');
            end

            % List existing experiments on mlflow
            exp = mlflow.Experiment.list('deleted_only');

            if ~isempty(exp)
                testCase.verifyClass(exp,'mlflow.Experiment');
            end

            % List existing experiments on mlflow
            exp = mlflow.Experiment.list('all');

            if ~isempty(exp)
                testCase.verifyClass(exp,'mlflow.Experiment');
            end

        end

        function testCreateDeleteExperiment(testCase)
            disp("Running testCreateDeleteExperiment");
            % Create a name for the experiment
            if length(testCase.exName) <= 15
                error('MLFLOW:UNITTEST','Experiment name is too short. Check that MLFLOW_EXPERIMENT_ROOT is set e.g.: /Shared/UnitTests/UnitTestExperiment');
            end

            exp = mlflow.Experiment;
            exp.name = testCase.exName;

            % There is no ID
            testCase.verifyEmpty(exp.experiment_id);

            % Create the experiment
            exp.create();

            % After creation, there should be an ID
            testCase.verifyNotEmpty(exp.experiment_id)

            % Delete the experiment
            exp.remove();
        end

        function testCreateDeleteRestore(testCase)
            disp("Running testCreateDeleteRestore");
            % Create a name for the cluster
            if length(testCase.exName) <= 15
                error('MLFLOW:UNITTEST','Experiment name is too short. Check that MLFLOW_EXPERIMENT_ROOT is set e.g.: /Shared/UnitTests/UnitTestExperiment');
            end

            exp = mlflow.Experiment;
            exp.name = testCase.exName;

            % Create the experiment
            exp.create();

            % Delete the experiment
            exp.remove();

            % Restore the experiment
            exp.restore();

            % Delete the experiment for good
            exp.remove();

        end

        function testUpdateMethod(testCase)
            disp("Running testUpdateMethod");
            if length(testCase.exName) <= 15
                error('MLFLOW:UNITTEST','Experiment name is too short. Check that MLFLOW_EXPERIMENT_ROOT is set e.g.: /Shared/UnitTests/UnitTestExperiment');
            end

            % Create a name for the cluster
            exp = mlflow.Experiment;
            exp.name = testCase.exName;

            % Create the experiment
            exp.create();

            % Update the experiment
            newName = exp.name + "-updated";
            exp.update(newName);

            % Check that the object has updated its name
            testCase.verifyEqual(newName, exp.name);

            % Clean up
            exp.remove();

        end

        function testGetExperiment(testCase)
            disp("Running testGetExperiment");
            if length(testCase.exName) <= 15
                error('MLFLOW:UNITTEST','Experiment name is too short. Check that MLFLOW_EXPERIMENT_ROOT is set e.g.: /Shared/UnitTests/UnitTestExperiment');
            end

            % Create a name for the experiment
            exp = mlflow.Experiment;
            exp.name = testCase.exName;

            % Create the experiment
            exp.create();

            % Update the metadata
            exp.refresh();

            % Check the experiment metadata
            testCase.verifyNotEmpty(exp.lifecycle_stage);

            if testCase.isDatabricks
                % Databricks' mlflow has some properties not available in
                % the vanilla flavour.
                testCase.verifyNotEmpty(exp.last_update_time);
                testCase.verifyNotEmpty(exp.creation_time);
            end
            % Since we just created the experiment, it should be possible
            % to check the metadata too.
            testCase.verifyEqual(exp.lifecycle_stage,"active");

            % Delete
            exp.remove();

            % Refresh the metadata again on a deleted experiment
            exp.refresh();

            % Check the stage
            testCase.verifyEqual(exp.lifecycle_stage,"deleted");
        end

        function testGetByName(testCase)
            disp("Running testGetByName");
            % Experiments by name
            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable UNITESTSPATH to be set e.g.: /Users/joe@example.com/UnitTests');
            end

            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            testCase.assertClass(mle,'mlflow.Experiment');

        end

        function testCreateRun(testCase)
            disp("Running testCreateRun");
            % Experiments by name
            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable UNITESTSPATH to be set e.g.: /Users/joe@example.com/UnitTests');
            end

            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            runObj = mle.createRun();

            % Ensure that we have a run obj
            testCase.assertClass(runObj,'mlflow.Run');
            testCase.assertEqual(runObj.experiment_id, mle.experiment_id);
        end

        function testTagging(testCase)
            disp("Running testTagging");
            % Experiments by name
            if ~testCase.isDatabricks
                % Current setup (in gitlab) only works within the Databricks environment
                return;
            end

            if isempty(testCase.fixedName)
                error('MLFLOW:UNITTEST','Expected environment variable UNITESTSPATH to be set e.g.: /Users/joe@example.com/UnitTests');
            end

            % Get the experiment by name
            mle = createFixtureExperiment(testCase.fixedName);
            uuidKey = string(javaMethod('randomUUID','java.util.UUID'));
            uuidVal = string(datestr(now,30)); %#ok<TNOW1,DATST>
            mle.setExperimentTag(uuidKey,uuidVal);

            % Read the tags
            mle.refresh;

            % Verify
            testCase.verifyTrue(any([mle.tags.key]==uuidKey));
            testCase.verifyTrue(any([mle.tags.value]==uuidVal));

        end

        function testTagsInCreateScalar(testCase)
            disp("Running testTagsInCreateScalar");
            if ~testCase.isDatabricks
                % Current setup (in gitlab) only works within the Databricks environment
                return;
            end
            mle = mlflow.Experiment();
            mle.name = testCase.exName;
            
            key = "Key1";
            value = "Some value";
            mle.tags = mlflow.ExperimentTag(key, value);
            mle.create()

            mle2 = mlflow.Experiment.getByName(testCase.exName);
            testCase.verifyLength(mle2, 1);
            tags = mle2.tags;
            idx=find(key==[tags.key]);
            testCase.verifyLength(idx, 1);
            testCase.verifyEqual(tags(idx).value, value);

            % Cleanup experiment
            mle.remove()
        end

        function testTagsInCreateVector(testCase)
            disp("Running testTagsInCreateVector");
            if ~testCase.isDatabricks
                % Current setup (in gitlab) only works within the Databricks environment
                return;
            end
            mle = mlflow.Experiment();
            mle.name = testCase.exName;
            
            key1 = "Colour";
            value1 = "Mauve";
            key2 = "Country";
            value2 = "Långtbortistan";
            mle.tags = mlflow.ExperimentTag(key1, value1, key2, value2);
            mle.create()

            mle2 = mlflow.Experiment.getByName(testCase.exName);
            testCase.verifyLength(mle2, 1);
            tags = mle2.tags;

            idx1=find(key1==[tags.key]);
            testCase.verifyLength(idx1, 1);
            testCase.verifyEqual(tags(idx1).value, value1);

            idx2=find(key2==[tags.key]);
            testCase.verifyLength(idx2, 1);
            testCase.verifyEqual(tags(idx2).value, value2);

            % Cleanup experiment
            mle.remove()
        end
    end
end

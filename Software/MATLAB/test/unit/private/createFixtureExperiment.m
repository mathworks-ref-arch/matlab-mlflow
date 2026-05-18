function experiment = createFixtureExperiment(fixedName)
    % createFixtureExperiment Internal helper function for tests

    %  (c) 2020-2024 MathWorks, Inc.

    arguments
        fixedName string = getenv('MLFLOW_UNITTESTSPATH')
    end

    if strlength(fixedName) == 0
        fixedName = "/Shared/UnitTests/UnitTestExperiment";
    end
    fixedName = fixedName + matlab.lang.internal.uuid;
    removed = false;
    while ~removed
        try
            mle = mlflow.Experiment.getByName(fixedName);
            mle.remove();
        catch ME
            if strcmp(ME.identifier,'MLFLOW:ERROR:NOTFOUND')
                disp(ME.message);
                removed = true;
            elseif strcmp(ME.identifier,'MLFLOW:ERROR') && contains(ME.message, 'error_code: RESOURCE_DOES_NOT_EXIST message: Could not find experiment with ID');
                disp(ME.message);
                removed = true;
            else
                disp(ME.message);
                error('MLFLOW:ERROR','Unexpected error')
            end
        end
    end
    disp([newline, 'Creating fixture experiment: ', char(fixedName)]);
    exp = mlflow.Experiment;
    exp.name = fixedName;
    exp.create();
    % Update the metadata
    exp.refresh();
    experiment = exp;
end

function setUnitTestVars()
    % SETUNITTESTVARS Configures user specific environment variables for MathWorks
    % These values should be amended for use in other environments.
    % These values should also be configured in CI/CD environments.
    %
    % The variables are:
    %
    %   MLFLOW_EXPERIMENT_ROOT e.g.: /Shared/UnitTests/UnitTestExperiment
    %   MLFLOW_UNITTESTSPATH   e.g.: /Shared/UnitTests/
    %   MLFLOW_UNITTESTSUSERID e.g.: example@mathworks.com

    %  (c) 2021-2024 MathWorks, Inc.

    % Use the UnitTests experiment in the shared location
    % disp('Note: It is assumed an experiment named: UnitTests exists')

    % Pick up the current username
    userName = char(java.lang.System.getProperty("user.name"));

    % Create env var to point to the Shared Experiment setup for unit tests
    exRootVal = ['/Shared/UnitTests']; %#ok<NBRAK2>
    setenv('MLFLOW_EXPERIMENT_ROOT', exRootVal);
    fprintf('Set MLFLOW_EXPERIMENT_ROOT to: %s\n', exRootVal);

    % Create shared folder to place experiments
    unitTestPath = ['/Shared','/UnitTests','/UnitTestExperiment'];
    setenv('MLFLOW_UNITTESTSPATH', unitTestPath);
    fprintf('Set MLFLOW_UNITTESTSPATH to: %s\n', unitTestPath);

    % Create username
    unitTestUserId = [userName, '@mathworks.com'];
    setenv('MLFLOW_UNITTESTSUSERID', unitTestUserId);
    fprintf('Set MLFLOW_UNITTESTSUSERID to: %s\n', unitTestUserId);
end
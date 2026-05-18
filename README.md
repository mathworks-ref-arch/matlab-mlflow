# MATLAB Interface *for MLflow*

This package provides MATLAB® interfaces to MLflow™ Tracking and MLflow Model Logging. The package provides three main interfaces:

* Fluent interface to [MLflow Tracking](https://mlflow.org/docs/latest/ml/tracking/) - this enables MATLAB to interact with [MLflow Tracking](https://mlflow.org/docs/latest/ml/tracking/) using an interface which is very similar to the well known [MLflow's Python fluent interface](https://mlflow.org/docs/latest/api_reference/python_api/mlflow.html).
* MATLAB MLflow model flavor - this enables MATLAB code to be logged as [MLflow models](https://mlflow.org/docs/latest/ml/model/). These models can then later be loaded into MATLAB again and/or in some cases these models are then also useable outside of MATLAB.
* RESTful interface to [MLflow Tracking](https://mlflow.org/docs/latest/ml/tracking/) - this enables MATLAB to interact with [MLflow Tracking](https://mlflow.org/docs/latest/ml/tracking/) through its [REST API](https://mlflow.org/docs/latest/api_reference/rest-api.html). This interface is more verbose than the fluent interface but does not require Python®.

## Requirements

### MathWorks Products (http://www.mathworks.com)

* MATLAB R2022b or later
* For selected features of the MATLAB MLflow model flavor:
  * MATLAB Compiler SDK™, or
  * Deep Learning Toolbox™, with
    * Deep Learning Toolbox Converter for ONNX™ Model Format

### 3rd Party Products

* MLflow (compatible) Tracking servers and model registries, for example (but not limited to):
  * [MLflow Tracking Server](https://mlflow.org/docs/latest/api_reference/cli.html#mlflow-server)
  * Databricks™
  * Microsoft Azure® Machine Learning
* For the fluent interface and MATLAB flavor
  * Python version 3.10 or newer (also see [Versions of Python Compatible with MATLAB Products by Release
](https://www.mathworks.com/support/requirements/python-compatibility.html))
  * `mlflow` Python package version 2.* or 3.* 

## Installation

To use the package first clone the repository:

```console
$ git clone https://github.com/mathworks-ref-arch/matlab-mlflow.git
```

Then consult [Installation (fluent interface and MATLAB flavor)](https://mathworks-ref-arch.github.io/matlab-mlflow/main/InstallationPython.html) and/or [Installation (RESTful interface)](https://mathworks-ref-arch.github.io/matlab-mlflow/main/Installation.html) for further installation instructions.

## Usage

Please see the [documentation](https://mathworks-ref-arch.github.io/matlab-mlflow/main/) for more information.

## License

The license for the MATLAB Interface *for MLflow* is available in the LICENSE.md file in this repository.

## Enhancement Requests

Provide suggestions for additional features or capabilities using the following link:
https://www.mathworks.com/products/reference-architectures/request-new-reference-architectures.html

## Support

Please submit a GitHub issue.

[//]: #  (Copyright 2020-2026 The MathWorks, Inc.)

# MATLAB Interface *for MLflow* - Release Notes

## 1.0.0 (May 2026)

* **First independent release published on GitHub.**
  
  Code from this package has been published before as part of other publicly available MathWorks packages but not as an independently reusable package. Version 1.0.0 marks the release of a reusable package in its own right. Version 1.0.0 does not introduce any breaking changes compared to version 0.1.2 but does add additional functionality.

* Adds a MATLAB flavor which allows logging MATLAB models as MLflow models. These models can later be loaded back in MATLAB again and/or these models may be reusable outside of MATLAB as a [`pyfunc` compatible MLflow model](https://mlflow.org/docs/latest/ml/model/#pyfunc-model-flavor). This also allows select Deep Learning Toolbox networks to be exported as a native MLflow ONNX flavor model.

## 0.1.2 (19th Nov 2024)

* Minor fix to `RegisteredModel` API

## 0.1.1 (16th Oct 2024)

* Minor fix for REST API interface when compiled

## 0.1.0 (26th Sept 2024)

* Added Python fluent interface
* Added Databricks unified authentication support
* Added startup verbose option
* Requires MATLAB R2022b or later

## 0.0.24 (17th April 2024)

* Internal changes to handle changed backend requirements

## 0.0.23 (2nd Oct 2023)

* Added initial support for Databricks Connect v2 environment variable credentials

## 0.0.22 (21st Feb 2023)

* Removed Contents.m file

## 0.0.21 (16th Nov 2022)

* Enabled Apple silicon beta in startup

## 0.0.20 (25th Oct 2022)

* Tests with standalone MLflow installation

## 0.0.19 (21st Oct 2022)

* Added basic documentation and a getting started guide

## 0.0.18 (13th Oct 2022)

* Minor documentation updates

## 0.0.17 (10th Oct 2022)

* Added RunInfo run_name field support

## 0.0.16 (4th Oct 2022)

* JSON Decoder support for int32 values

## 0.0.15 (15th Jul 2022)

* REST API improvements and fixes

## 0.0.14 (3rd June 2022)

* Fix `int64` and `timestamp` handling for `FileInfo`, `ModelVersion` and `RegisteredModel`

## 0.0.13 (17th May 2022)

* Improved HTTP options handling

## 0.0.12 (13th Apr 2022)

* Improved JSON handling

## 0.0.11 (1st Apr 2022)

* Improved documentation
* Fixed authentication file bug

## 0.0.10 (28th Mar 2022)

* Improved handling of int64 values

## 0.0.9 (22nd Feb 2022)

* startup improvements
* Minor string handling fixes

## 0.0.8 (9th Feb 2022)

* API Documentation updates

## 0.0.7 (7th Feb 2022)

* Further API updates

## 0.0.6 (4th Feb 2022)

* Improve APIs and underlying objects

## 0.0.5 (21st Jan 2022)

* Handle issues with JSON decoding
* Add MATLAB proxy to mlflow CLI
* Improved mlflow.Run APIs
* Add non-Databricks configuration

## 0.0.4 (1st Dec 2021)

* Improve authorization handling
* Update API documentation
  
## 0.0.3 (24th Aug 2021)

* Improved API documentation

## 0.0.2 (11th Jun 2021)

* Updated the test infrastructure
* Added ability to handle INT64 return types (jsondecode)

## 0.0.1 (Unreleased)

* Fixed Databricks references
* Support for running standalone

## 0.0.0 (Unreleased)

* Refactored work

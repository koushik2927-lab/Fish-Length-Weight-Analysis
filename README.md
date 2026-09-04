
# Fish Length–Weight Relationship Analysis

## Project Overview

This project investigates the length–weight relationship and growth patterns of freshwater fish species using morphometric data.

## Objectives

- Examine the relationship between fish total length and body weight.
- Estimate the length–weight parameters a and b.
- Evaluate the strength of the relationship using R-squared.
- Determine species-specific growth patterns.
- Test whether the growth exponent b differs significantly from 3.

## Methods

Length–weight relationships were analyzed using log10-transformed total length and body weight.

The model was:

W = aL^b

where W is body weight, L is total length, a is the scaling coefficient, and b is the growth exponent.

Species with at least 100 observations were selected for species-level analysis.

Growth type was classified using a hypothesis test of b = 3.

## Overall Result

The overall log-log regression showed a strong relationship between total length and body weight.

The estimated growth exponent was approximately 3.138, indicating positive allometric growth.

## Tools

- R
- RStudio
- Linear regression
- Log-transformation
- Statistical hypothesis testing
- Data visualization

## Project Structure

- data/ — raw dataset
- scripts/ — R analysis script
- results/ — statistical results
- figures/ — generated figures


## Dataset

The dataset was obtained from the Dryad Digital Repository.

Dataset:
Weight and length measurements for 37 Mekong River fish species of the Dai fishery.

DOI: 10.5061/dryad.dr7sqvb5h

The analysis uses total length (cm) and body weight (g) measurements.

## Statistical Analysis

The length–weight relationship was evaluated using log10-transformed variables.

Species-specific growth was assessed by testing whether the growth exponent (b) differed significantly from 3.

A significance level of 0.05 was used.

## Reproducibility

All statistical analyses were performed in R.

The analysis script and generated results are provided in this repository.


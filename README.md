# DKF-dissertation

This repository contains XeLaTeX source code for the dissertation:

M. Burkhart. “A Discriminative Approach to Bayesian Filtering with Applications to Human Neural Decoding.” Ph.D. Dissertation, Brown University (2019)

#### Abstract:

Given a stationary state-space model that relates a sequence of hidden states and corresponding measurements or observations, Bayesian filtering provides a principled statistical framework for inferring the posterior distribution of the current state given all measurements up to the present time.  For example, the Apollo lunar module implemented a Kalman filter to infer its location from a sequence of earth-based radar measurements and land safely on the moon.  

To perform Bayesian filtering, we require a measurement model that describes the conditional distribution of each observation given state.  The Kalman filter takes this measurement model to be linear, Gaussian.  Here we show how a nonlinear, Gaussian approximation to the distribution of state given observation can be used in conjunction with Bayes' rule to build a nonlinear, non-Gaussian measurement model.  The resulting approach, called the Discriminative Kalman Filter (DKF), retains fast closed-form updates for the posterior.  We argue there are many cases where the distribution of state given measurement is better-approximated as Gaussian, especially when the dimensionality of measurements far exceeds that of states and the Bernstein–von Mises theorem applies. Online neural decoding for brain-computer interfaces provides a motivating example, where filtering incorporates increasingly detailed measurements of neural activity to provide users control over external devices.  Within the BrainGate2 clinical trial, the DKF successfully enabled three volunteers with quadriplegia to control an on-screen cursor in real-time using mental imagery alone.  Participant "T9" used the DKF to type out messages on a tablet PC.

Nonstationarities, or changes to the statistical relationship between states and measurements that occur after model training, pose a significant challenge to effective filtering.  In brain-computer interfaces, one common type of nonstationarity results from wonkiness or dropout of a single neuron.  We show how a robust measurement model can be used within the DKF framework to effectively ignore large changes in the behavior of a single neuron.  At BrainGate2, a successful online human neural decoding experiment validated this approach against the commonly-used Kalman filter. 


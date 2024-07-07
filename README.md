Speech-Recognition

This repository contains MATLAB scripts for developing a speech recognition system. The main functionalities include data augmentation, feature extraction, and neural network implementation for speech processing.
Contents

    ai_nn.m: Implements an artificial neural network for speech recognition.
    augment.m: Performs data augmentation using techniques such as speed change, noise addition, and time shifting.
    mfcc_extract.m: Extracts Mel-Frequency Cepstral Coefficients (MFCC) features from audio files.
    record.m: Records audio for processing.

Getting Started
Prerequisites

    MATLAB R2021a or later

Installation

    Clone the repository:

    git clone https://github.com/arioobarzan/Speech-Recognition.git

    Navigate to the project directory:

    cd Speech-Recognition

Usage

    Recording Audio:

    record

    This script will record audio and save it for further processing.

    Data Augmentation:

    augment('inputFilePath', 10, 'outputDirectory')

    This script will augment the audio data using various techniques and save the augmented files in the specified directory.

    Feature Extraction:

    mfcc_extract('inputFilePath')

    This script will extract MFCC features from the audio file.

    Neural Network Training:

    ai_nn

    This script will train a neural network using the extracted features.

Contributing

Feel free to fork this repository and contribute by submitting pull requests. For major changes, please open an issue first to discuss what you would like to change.
License

This project is licensed under the MIT License - see the LICENSE file for details.

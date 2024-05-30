clc 
clear
close
%%
filePattern = fullfile('augmented_audio', '*.wav');
audioFiles = dir(filePattern);
numFiles = length(audioFiles);
    

% ابتدا یک سلول آرایه برای ذخیره داده‌های صوتی ایجاد می‌کنیم
fileList = cell(numFiles, 1);
% حلقه برای خواندن هر فایل و ذخیره آن در آرایه
for k = 1:numFiles
    fileList{k} = ['augmented_audio\' audioFiles(k).name];
end

features = [];
labels = [];
trainData = zeros(20,88200);
for i = 1:length(fileList)
    [audioData, fs] = audioread(fileList{i});
    if size(audioData, 2) > 1
        audioData = mean(audioData, 2);
    end
    if(size(audioData,1) > 88200)
        audioData = audioData(1:88200);
    end
    
    trainData(i,:) = audioData;
    continue;
    mfccFeature = computeMFCC(audioData, fs, 13);
    
    % افزودن ویژگی‌ها به ماتریس ویژگی‌ها
    features = [features; mfccFeature];
    
    % فرض بر این است که فایل‌های صوتی به صورت sound_label.wav نامگذاری شده‌اند
    [~, name, ~] = fileparts(fileList{i});
    label = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1]; % استخراج برچسب از نام فایل
    labels = [labels; label];
end

function mfccs = computeMFCC(signal, fs, numCoeffs)
    % تنظیم پارامترهای اولیه
    frameLength = round(0.025 * fs);  % طول هر فریم 25 میلی‌ثانیه
    frameStep = round(0.01 * fs);     % قدم هر فریم 10 میلی‌ثانیه
    signalLength = length(signal);
    
    % محاسبه تعداد فریم‌ها
    numFrames = 1 + floor((signalLength - frameLength) / frameStep);
    
    % ایجاد پنجره هموارکننده (Hamming)
    hammingWindow = hamming(frameLength);
    
    % آماده‌سازی ماتریس MFCC
    mfccs = zeros(numFrames, numCoeffs);
    
    % حلقه برای محاسبه MFCC هر فریم
    for i = 1:numFrames
        startIdx = (i - 1) * frameStep + 1;
        endIdx = startIdx + frameLength - 1;
        
        % اگر اندیس‌ها خارج از محدوده سیگنال باشند، حلقه را بشکنید
        if endIdx > signalLength
            break;
        end
        
        frame = signal(startIdx:endIdx) .* hammingWindow;
        
        % تبدیل فوریه سریع (FFT)
        frameFFT = fft(frame);
        magFrame = abs(frameFFT(1:frameLength/2+1));
        
        % اعمال فیلترهای Mel
        melSpectrum = melFilter(magFrame, fs);
        
        % تبدیل به لگاریتم طبیعی
        logMelSpectrum = log(melSpectrum + 1e-10);
        
        % تبدیل کسینوسی معکوس (DCT) برای به دست آوردن MFCC
        mfcc = dct(logMelSpectrum);
        
        % استخراج اولین numCoeffs ضرایب MFCC
        mfccs(i, :) = mfcc(1:numCoeffs);
    end
end

function melSpectrum = melFilter(spectrum, fs)
    % تنظیم پارامترهای اولیه
    numFilters = 26;
    NFFT = length(spectrum) * 2 - 2;
    
    % ایجاد فیلترهای Mel
    melPoints = linspace(0, hz2mel(fs / 2), numFilters + 2);
    hzPoints = mel2hz(melPoints);
    bin = floor((NFFT + 1) * hzPoints / fs);
    
    % اطمینان از معتبر بودن اندیس‌ها
    bin(bin < 1) = 1;
    bin(bin > NFFT / 2 + 1) = NFFT / 2 + 1;
    
    melFilterBank = zeros(numFilters, floor(NFFT / 2 + 1));
    
    for i = 1:numFilters
        melFilterBank(i, bin(i):bin(i+1)) = linspace(0, 1, bin(i+1) - bin(i) + 1);
        melFilterBank(i, bin(i+1):bin(i+2)) = linspace(1, 0, bin(i+2) - bin(i+1) + 1);
    end
    
    melSpectrum = melFilterBank * spectrum;
end

function mel = hz2mel(hz)
    mel = 2595 * log10(1 + hz / 700);
end

function hz = mel2hz(mel)
    hz = 700 * (10.^(mel / 2595) - 1);
end


clc
clear 
close all

% پارامترهای ضبط
fs = 44100; % نرخ نمونه‌برداری (هرتز)
nBits = 16; % تعداد بیت‌ها در هر نمونه
nChannels = 1; % تعداد کانال‌ها (1 برای مونو)

% ایجاد شیء ضبط صدا
recObj = audiorecorder(fs, nBits, nChannels);

% نمایش پیام برای شروع ضبط
disp('Start speaking.')

% شروع ضبط (مدت زمان ضبط به ثانیه)
recordblocking(recObj, 2);

% نمایش پیام برای پایان ضبط
disp('End of Recording.');

% پخش صدای ضبط شده
play(recObj);

% دریافت داده‌های صوتی به عنوان یک آرایه
audioData = getaudiodata(recObj);

% ذخیره صدای ضبط شده در یک فایل WAV
filename = 'sana.wav';
audiowrite(filename, audioData, fs);

% نمایش پیامی مبنی بر ذخیره موفقیت‌آمیز
disp(['Audio recorded and saved to ', filename]);

% نمایش شکل موج صدای ضبط شده
figure;
plot(audioData);
title('Recorded Audio');
xlabel('Sample Number');
ylabel('Amplitude');

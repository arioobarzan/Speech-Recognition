clc; clear; close all;
[a,fs] = audioread("Alarm01.wav");
sound(a,fs);

plot(a);
title('Waveform of Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');


%%
size(a,1)/fs

%%
% افزایش حجم صدا با محدود کردن به بازه [-1, 1]
amplification_factor = 3; % ضریب تقویت صدا
a_louder = amplification_factor * a;
a_louder(a_louder > 1) = 1; % محدود کردن به 1
a_louder(a_louder < -1) = -1; % محدود کردن به -1

% پخش صدای تقویت شده
sound(a_louder, fs);
figure
plot(a_louder);
title('Waveform of Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');

%%
window_size = 5; % اندازه پنجره فیلتر میانگین
b = ones(1, window_size) / window_size; % ضرایب فیلتر میانگین
a_filtered = filter(b, 1, a); % اعمال فیلتر میانگین
sound(a_filtered, fs);
% رسم شکل موج قبل از فیلتر
subplot(2, 1, 1);
plot(a);
title('Original Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% رسم شکل موج بعد از فیلتر
subplot(2, 1, 2);
plot(a_filtered);
title('Filtered Signal');
xlabel('Sample Number');
ylabel('Amplitude');
%%
% خواندن فایل صوتی
[a, fs] = audioread("Alarm01.wav");

% اضافه کردن نویز سفید به سیگنال
noise_level = 0.05; % میزان نویز
noise = noise_level * randn(size(a)); % ایجاد نویز سفید
a_noisy = a + noise; % اضافه کردن نویز به سیگنال

% پخش سیگنال نویزدار
sound(a_noisy, fs);
pause(length(a)/fs + 2); % توقف تا اتمام پخش

% حذف نویز با استفاده از فیلتر میانگین
window_size = 5; % اندازه پنجره فیلتر میانگین
b = ones(1, window_size) / window_size; % ضرایب فیلتر میانگین
a_filtered = filter(b, 1, a_noisy); % اعمال فیلتر میانگین

% پخش سیگنال فیلتر شده
sound(a_filtered, fs);
pause(length(a)/fs + 2); % توقف تا اتمام پخش

% رسم شکل موج‌ها
figure;

% رسم شکل موج اصلی
subplot(3, 1, 1);
plot(a);
title('Original Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% رسم شکل موج نویزدار
subplot(3, 1, 2);
plot(a_noisy);
title('Noisy Signal');
xlabel('Sample Number');
ylabel('Amplitude');

% رسم شکل موج فیلتر شده
subplot(3, 1, 3);
plot(a_filtered);
title('Filtered Signal');
xlabel('Sample Number');
ylabel('Amplitude');

data = load('/Users/wenboyi/Desktop/HR/RR/mdFNN/preconcert10_BPM_E_dummy.txt');
%data = data(:,3)
tau = mdDelay(data, 'maxLag', 25, 'plottype', 'all');
tau = mdDelay(data, 'maxLag', 25, 'plottype', 'mean');
round(tau)
[fnnPercent, embeddingDimension] = mdFnn(data, round(tau),15);
[fnnPercent, embeddingDimension]
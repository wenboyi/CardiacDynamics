function bpmData = RR2BPM(rrData, windowSz,reSamp)
% converts RR-Intervall to Beats-Per-Minutes
%
% Inputs:
%
% rrData = vector containing the RR-intervall data (ms)
% windowSz = size of the window over which BPM is calculated (unit: BPM per sec)
% reSamp = re-sampling rate of the resulting BPM data (unit: BPM per sec)
%
% Outputs:
%
% bpmData = vector containint the BPM data
bpmData = [];
tempData = [];
for j = 1:length(rrData)
    tempData(length(tempData)+1:length(tempData)+floor(rrData(j)))=1/rrData(j);
end
l=0;
length(tempData)
for k=1:reSamp:floor(length(tempData)/1000)-windowSz
    l=l+1;
    bpmData(l)=sum(tempData(1+((k-1)*1000):(windowSz*1000)+((k-1)*1000)));
end
bpmData=bpmData.*(60/windowSz)';
end
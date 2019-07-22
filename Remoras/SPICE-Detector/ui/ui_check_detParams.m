function ui_check_detParams
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ui_check_detParams.m
%
% Verify settings in GUI before running on entire drive.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global REMORA

defaultPos = [0.25,0.25,0.5,0.5];
REMORA.fig.spice_dt_verify = figure( ...
    'NumberTitle','off', ...
    'Name','Spice Detector Batch - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

% button grid layouts
% 14 rows, 4 columns
r = 24; % rows      (extra space for separations btw sections)
c = 4;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = 0:w:1;

% colors
bgColor = [1 1 1];  % white
bgColorRed = [1 .6 .6];  % red
bgColorGray = [.86 .86 .86];  % gray
bgColor3 = [.75 .875 1]; % light green 
bgColor4 = [.76 .87 .78]; % light blue 
 
REMORA.spice_dt_verify = [];
labelStr = 'Verify Detector Options';
btnPos=[x(1) y(2) 4*w h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',11,...
    'Visible','on'); 


% Set paths and strings
%***********************************
%% Base Folder Text
labelStr = 'Base Folder';
btnPos=[x(1) y(3) w dy];
REMORA.spice_dt_verify.baseDirTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Base Folder Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.baseDir);
btnPos=[x(2) y(3) (w*3)*.8 dy];
REMORA.spice_dt_verify.baseDirEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','dt_control(''setBaseDir'')');

%% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1) y(4) w dy];
REMORA.spice_dt_verify.outDirTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Output Folder Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.outDir);
btnPos=[x(2) y(4) (w*3)*.8 dy];
REMORA.spice_dt_verify.outDirEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setOutDir'',''gui'')');

%% Transfer Function Text
labelStr = 'Transfer Function Path';
btnPos=[x(1) y(5) w dy];
REMORA.spice_dt_verify.TFPathTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Transfer Function Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.tfFullFile);
btnPos=[x(2) y(5) (w*3)*.8 dy];
REMORA.spice_dt_verify.TFPathEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setTFPath'')');

%% Deployment Name Wildcard Text
labelStr = 'File Name Wildcard';
btnPos=[x(1) y(6) w dy];
REMORA.spice_dt_verify.deployNameTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Deployment Name Wildcard Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.depl);
btnPos=[x(2) y(6) w dy];
REMORA.spice_dt_verify.deployNameEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','dt_control(''setDeployName'')');

%% Channel Text
labelStr = 'Channel';
btnPos=[x(1) y(7) w dy];
REMORA.spice_dt_verify.channelTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Channel Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.channel);
btnPos=[x(2) y(7) (w/2) dy];
REMORA.spice_dt_verify.channelEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setChannel'')');

%% Overwrite Checkbox
labelStr = 'Overwrite Existing Detection Files?';
btnPos=[x(3) y(7) w dy];
REMORA.spice_dt_verify.overwriteCheck = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.spice_dt.detParams.overwrite,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','dt_control(''setOverwrite'')');%  

%% Commonly-modified parameters
labelStr = 'Commonly-Modified';
btnPos=[x(1) y(9) w*2 h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor4,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on'); 

%% Column Names
labelStr='Parameter';
btnPos=[x(1) y(10) w h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on'); 

labelStr='Min';
btnPos=[x(2) y(10) w/2 h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...    
    'FontWeight','bold',...
    'Visible','on'); 

labelStr='Max';
btnPos=[x(2)+w/2 y(10) w/2 h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on'); 

%% Peak2Peak Threshold Text
labelStr = 'RL Threshold (dBpp)';
btnPos=[x(1) y(11)-ybuff w h];
REMORA.spice_dt_verify.PPThresholdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Peak2Peak Threshold Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.dBppThreshold);
btnPos=[x(2) y(11) w/2 h];
REMORA.spice_dt_verify.PPThresholdEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setPPThreshold'')');

%% Bandpass Limits Text
labelStr = 'Bandpass Filter Edges (kHz)';
btnPos=[x(1) y(12)-ybuff w h];
REMORA.spice_dt_verify.BandPassText = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr),...
   'FontUnits','normalized', ...
   'Visible','on');%'BackgroundColor',bgColor3,...

% Minimum Bandpass Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.bpRanges(1,1));
btnPos=[x(2) y(12) w/2 h];
REMORA.spice_dt_verify.MinBandPassEdText = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMinBandpass'')');%'Enable', enbl, ...

% Maximum Bandpass Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.bpRanges(1,2));
btnPos=[x(2)+(w/2) y(12) w/2 h];
REMORA.spice_dt_verify.MaxBandPassEdText = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMaxBandpass'')');%    'Enable', enbl, ...

%% Click Duration Limits Text
labelStr = 'Click Duration Limits (us)';
btnPos=[x(1) y(13)-ybuff w h];
REMORA.spice_dt_verify.ClickDurLimText = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr),...
   'FontUnits','normalized', ...
   'Visible','on');%'BackgroundColor',bgColor3,...

% Minimum Duration Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.delphClickDurLims(1,1));
btnPos=[x(2) y(13) w/2 h];
REMORA.spice_dt_verify.MinClickDurEdText = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMinClickDur'')');%'Enable', enbl, ...

% Maximum Duration Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.delphClickDurLims(1,2));
btnPos=[x(2)+(w/2) y(13) w/2 h];
REMORA.spice_dt_verify.MaxClickDurEdText = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMaxClickDur'')');%    'Enable', enbl, ...

%% Peak Frequency Limit Text
labelStr = 'Peak Freq Limits (kHz)';
btnPos=[x(1) y(14)-ybuff w h];
REMORA.spice_dt_verify.PeakFreqTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Minimum Peak Frequency Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.cutPeakBelowKHz);
btnPos=[x(2) y(14) w/2 h];
REMORA.spice_dt_verify.MinPeakFreqEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMinPeakFreq'')');%'Enable', enbl, ...

% Maximum Peak Frequency Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.cutPeakAboveKHz);
btnPos=[x(2)+(w/2) y(14) w/2 h];
REMORA.spice_dt_verify.MaxPeakFreqEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMaxPeakFreq'')'); %'Enable', enbl, ...

%% Envelope Energy Ratio Text
labelStr = 'Click Energy Envelope Ratio';
btnPos=[x(1) y(15)-ybuff w h];
REMORA.spice_dt_verify.dEvLimsTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Minimum Envelope Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.dEvLims(1));
btnPos=[x(2) y(15) w/2 h];
REMORA.spice_dt_verify.MinEvEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMinEnvRatio'')');

% Maximum Envelope Limit Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.dEvLims(2));
btnPos=[x(2)+(w/2) y(15) w/2 h];
REMORA.spice_dt_verify.MaxEvEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMaxEnvRatio'')');

%% Clipping Threshold Text
labelStr = 'Clip Threshold ( [0 - 1] )';
btnPos=[x(1) y(16)-ybuff w h];
REMORA.spice_dt_verify.clipThresholdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');
% Clipping Threshold Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.clipThreshold);
btnPos=[x(2)+(w/2) y(16) w/2 h];
REMORA.spice_dt_verify.clipThresholdEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetClipThreshold'')');

%% Post Processing Options
labelStr = 'Post-Processing Options';
btnPos=[x(1) y(18) w*2 h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on'); 

%***********************************
% Remove Isolated Checkbox
%***********************************
labelStr = 'Remove Isolated Detections';
btnPos=[x(1)+w/4 y(19) w h];
REMORA.spice_dt_verify.rmIsolatedCheckbox = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'Value',REMORA.spice_dt.detParams.rmLonerClicks,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','dt_control(''SetRmIsolated'')');

% Max gap to neighbor text
labelStr = 'Max Time Gap to Neighbor (sec)';
btnPos=[x(2) y(19)-ybuff w/2 h];
REMORA.spice_dt_verify.maxNeighborTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

labelStr=num2str(REMORA.spice_dt.detParams.maxNeighbor);
btnPos=[x(2)+w/2 y(19) w/2 h];
REMORA.spice_dt_verify.maxNeighborEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMaxNeighbor'')');


%***********************************
% Remove Echos Checkbox
%***********************************
labelStr = 'Remove Echos';
btnPos=[x(1)+w/4 y(20) w h];
REMORA.spice_dt_verify.rmEchoCheckbox = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'Value',REMORA.spice_dt.detParams.rmEchos,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','dt_control(''SetRmEcho'')');

% Max gap to neighbor text
labelStr = 'Min Gap Between Detections (sec)';
btnPos=[x(2) y(20)-ybuff w/2 h];
REMORA.spice_dt_verify.lockoutTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

labelStr=num2str(REMORA.spice_dt.detParams.lockOut);
btnPos=[x(2)+w/2 y(20) w/2 h];
REMORA.spice_dt_verify.lockoutEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetLockout'')');


% Save Noise Checkbox
%***********************************
labelStr = 'Save Noise';
btnPos=[x(1)+w/4 y(21) w/2 h];
REMORA.spice_dt_verify.noiseCheckbox = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'Value',REMORA.spice_dt.detParams.saveNoise,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','dt_control(''SetNoise'')');
% Save for TPWS Checkbox
%***********************************
labelStr = 'Save for TPWS';
btnPos=[x(1)+w/4 y(22) w h];
REMORA.spice_dt_verify.saveForTPWSCheckbox = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Value',REMORA.spice_dt.detParams.saveForTPWS,...
   'Visible','on',...
   'Callback','dt_control(''SetSaveforTPWS'')');

%% Modify with caution parameters
labelStr = 'Modify with Caution';
btnPos=[x(3) y(9) w*2 h];
REMORA.spice_dt_verify.headtext = uicontrol(REMORA.fig.spice_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorRed,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on'); 

%% Guided detection radio button
labelStr = 'Guided Detection (requires csv of times)';
btnPos=[x(3) y(10) w*2 h];
REMORA.spice_dt_verify.GuidedDetCheckBox = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Value',REMORA.spice_dt.detParams.guidedDetector,...
   'FontWeight','bold',...
   'Visible','on',...
   'Callback','dt_control(''SetGuidedDetection'')');

% Guided detection
labelStr = 'File location';
btnPos=[x(3) y(11)-ybuff w/2 h];
REMORA.spice_dt_verify.GuidedDetFileTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',labelStr,...
   'FontUnits','normalized',...
   'Visible','on');

% Guided detection Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.gDxls);
btnPos=[x(3)+(w/3) y(11) w*1.6 h];
REMORA.spice_dt_verify.GuidedDetFileEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetGuidedDetFile'')');

%% Wave file date regexp heading
labelStr = 'Wav File-Specific Parameters';
btnPos=[x(3) y(13) w*2 h];
REMORA.spice_dt_verify.WavFileHeading = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'HorizontalAlignment','left',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontWeight','bold',...
   'FontUnits','normalized', ...
   'Value',REMORA.spice_dt.detParams.guidedDetector,...
   'Visible','on');

% Wave file date regexp text
labelStr = 'Date/Time reg. exp. for filenames';
btnPos=[x(3) y(14)-ybuff w h];
REMORA.spice_dt_verify.WaveRegExpTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Wave file Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.DateRegExp);
btnPos=[x(4) y(14) w/2 h];
REMORA.spice_dt_verify.WaveRegExpEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetWaveRegExp'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Buffers and thresholds heading
labelStr = 'Internal Buffers & Thresholds';
btnPos=[x(3) y(16) w*2 h];
REMORA.spice_dt_verify.BufferHeading = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'HorizontalAlignment','left',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontWeight','bold',...
   'FontUnits','normalized', ...
   'Value',REMORA.spice_dt.detParams.guidedDetector,...
   'Visible','on');

%% Low Res Buffer Text
labelStr = 'Low-res buffer (sec)';
btnPos=[x(3) y(17)-ybuff w h];
REMORA.spice_dt_verify.LRbufferTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Low Res Buffer Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.LRbuffer);
btnPos=[x(4) y(17) w/2 h];
REMORA.spice_dt_verify.LRBufferEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetLRBuffer'')');

%% Hi Res Buffer Text
labelStr = 'Hi-res buffer (sec)';
btnPos=[x(3) y(18)-ybuff w h];
REMORA.spice_dt_verify.HRBufferTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Hi Res Buffer Editable Text
labelStr = num2str(REMORA.spice_dt.detParams.HRbuffer);
btnPos=[x(4) y(18) w/2 h];
REMORA.spice_dt_verify.HRBufferEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetHRBuffer'')');

%% Merge Threshold Text
labelStr = 'Detection Merge Threshold (microsec)';
btnPos=[x(3) y(19)-ybuff w h];
REMORA.spice_dt_verify.mergeThresholdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Merge Threshold Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.mergeThr);
btnPos=[x(4) y(19) w/2 h];
REMORA.spice_dt_verify.mergeThresholdEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetMergeThreshold'')');

%% Start/End Energy Threshold Text
labelStr = 'Energy Percentile for Detection Onset';
btnPos=[x(3) y(20)-ybuff w h];
REMORA.spice_dt_verify.energyPercTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Energy Percentile Threshold Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.energyPrctile);
btnPos=[x(4) y(20) w/2 h];
REMORA.spice_dt_verify.energyPercEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetEnergyPercentile'')');

%% Envelope Energy Threshold Text
labelStr = 'Envelope Duration Energy Threshold';
btnPos=[x(3) y(21)-ybuff w h];
REMORA.spice_dt_verify.energyThrTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Energy Threshold Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.energyThr);
btnPos=[x(4) y(21) w/2 h];
REMORA.spice_dt_verify.energyThrEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetEnergyThr'')');

%% Band pass filter order
labelStr = 'Band-Pass Filter Order';
btnPos=[x(3) y(22)-ybuff w h];
REMORA.spice_dt_verify.BPfilterTxt = uicontrol(REMORA.fig.spice_dt_verify,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','on');

% Band pass filter order Editable Text
labelStr=num2str(REMORA.spice_dt.detParams.filterOrder);
btnPos=[x(4) y(22) w/2 h];
REMORA.spice_dt_verify.BPfilterEdTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''SetFilterOrder'')');

%% Run button
labelStr = 'Run Detector';
btnPos=[x(2)+w/2 y(24) w h];
REMORA.spice_dt_verify.runTxt = uicontrol(REMORA.fig.spice_dt_verify,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',[.47,.67,.19],...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','dt_control(''RunBatchDetection'')');

REMORA.spice_dt.SettingsControls = [REMORA.spice_dt_verify.PPThresholdTxt,...
    REMORA.spice_dt_verify.PPThresholdEdTxt,...
    REMORA.spice_dt_verify.ClickDurLimText,...
    REMORA.spice_dt_verify.MinClickDurEdText, REMORA.spice_dt_verify.MaxClickDurEdText,...
    REMORA.spice_dt_verify.PeakFreqTxt, ...  
    REMORA.spice_dt_verify.MinPeakFreqEdTxt, REMORA.spice_dt_verify.MaxPeakFreqEdTxt, ...  
    REMORA.spice_dt_verify.dEvLimsTxt,...
    REMORA.spice_dt_verify.MinEvEdTxt,REMORA.spice_dt_verify.MaxEvEdTxt,...
    REMORA.spice_dt_verify.clipThresholdTxt,REMORA.spice_dt_verify.clipThresholdEdTxt];

% set(REMORA.fig.spice_dt,'Visible','on');

end
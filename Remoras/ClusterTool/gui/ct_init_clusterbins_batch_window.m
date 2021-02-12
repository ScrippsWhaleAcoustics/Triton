function ct_init_clusterbins_batch_window

global REMORA


defaultPos = [0.25,0.35,0.38,0.4];
if isfield(REMORA.fig, 'ct')
    % check if the figure already exists. If so, don't move it.
    if isfield(REMORA.fig.ct, 'CB_settings') && isvalid(REMORA.fig.ct.CB_settings)
        defaultPos = get(REMORA.fig.ct.CB_settings,'Position');
    else
        REMORA.fig.ct.CB_settings = figure;
    end
else 
    REMORA.fig.ct.CB_settings = figure;
end

set(REMORA.fig.ct.CB_settings,'NumberTitle','off', ...
    'Name','Cluster Bin Tool - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on',...
    'ToolBar', 'none');

figure(REMORA.fig.ct.CB_settings)

% Load/save settings pulldown
if ~isfield(REMORA.fig.ct,'CBfileMenu') || ~isvalid(REMORA.fig.ct.CBfileMenu)
    REMORA.fig.ct.CBfileMenu = uimenu(REMORA.fig.ct.CB_settings,'Label',...
        'Save/Load Settings','Enable','on','Visible','on');
    
    % Spectrogram load/save params
    uimenu(REMORA.fig.ct.CBfileMenu,'Label','&Load settings',...
        'Callback','ct_cb_control(''ct_clusterBins_settingsLoad'')');
    uimenu(REMORA.fig.ct.CBfileMenu,'Label','&Save settings',...
        'Callback','ct_cb_control(''ct_clusterBins_settingsSave'')');
end

% button grid layouts
% 14 rows, 4 columns
r = 18; % rows      (extra space for separations btw sections)
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
% bgColorGray = [.86 .86 .86];  % gray
bgColor3 = [.75 .875 1]; % light green 
bgColor4 = [.76 .87 .78]; % light blue 

REMORA.ct.CB_params_help = ct_get_help_strings;

REMORA.ct.CB_verify = [];
labelStr = 'Verify Bin Clustering Options';
btnPos=[x(1) y(2) 4*w h];
REMORA.ct.CB_verify.headtext = uicontrol(REMORA.fig.ct.CB_settings, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',12,...
    'Visible','on');  %'BackgroundColor',bgColor3,...


% Set paths and strings
%***********************************
%% Base Folder Text
labelStr = 'TPWS Input Folder';
btnPos=[x(1) y(3)-ybuff w h];
REMORA.ct.CB_verify.inDirTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Base Folder Editable Text
labelStr=num2str(REMORA.ct.CB_params.inDir);
btnPos=[x(2) y(3) (w*3)*.95 h];
REMORA.ct.CB_verify.inDirEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ct_cb_control(''setInDir'')');

labelStr = 'Search Sub-Folders';
btnPos=[x(2) y(4)+.015 w dy*.9];
REMORA.ct.CB_verify.recursSearch = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.recursSearch,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','ct_cb_control(''recursSearch'')');

%% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1) y(5)-ybuff w h];
REMORA.ct.CB.verify.outDirTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Output Folder Editable Text
labelStr=num2str(REMORA.ct.CB_params.outDir);
btnPos=[x(2) y(5) (w*3)*.95 h];
REMORA.ct.CB_verify.outDirEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setOutDir'')');

%% Deployment Name Wildcard Text
labelStr = 'TPWS Name Wildcard';
btnPos=[x(1) y(6)-ybuff w h];
REMORA.ct.CB_verify.deployNameTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.siteName));%   'BackgroundColor',bgColor3,...

% Deployment Name Wildcard Editable Text
labelStr=num2str(REMORA.ct.CB_params.siteName);
btnPos=[x(2) y(6) w/2 h];
REMORA.ct.CB_verify.deployNameEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ct_cb_control(''setDeployName'')');

%% Iteration Number Text
labelStr = 'TPWS Iteration Number';
btnPos=[x(2)+w/2 y(6)-ybuff w h];
REMORA.ct.CB_verify.TPWSitrTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Deployment Name Wildcard Editable Text
labelStr=num2str(REMORA.ct.CB_params.TPWSitr);
btnPos=[x(3)+w/2 y(6) w/2 h];
REMORA.ct.CB_verify.TPWSitrEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'HorizontalAlignment','left',...
    'Visible','on',...
    'Callback','ct_cb_control(''setTPWSItr'')');

%% Clustering parameters header
labelStr = 'Clustering Parameters';
btnPos=[x(1) y(7) w*4 h-ybuff];
REMORA.ct.CB_verify.cparamtext = uicontrol(REMORA.fig.ct.CB_settings, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor4,...
    'String',labelStr, ...
    'FontWeight','bold',...    
    'FontSize',10,...
    'FontUnits','points',...
    'Visible','on'); 

%% Cluster on Spectra
if ~isfield(REMORA.ct.CB_params,'useSpectra')
    REMORA.ct.CB_params.useSpectra = 1;
end

if REMORA.ct.CB_params.useSpectra
    showSpectraOptions = 'on';
else
    showSpectraOptions = 'off';
end
labelStr = 'Cluster on Spectra';
btnPos=[x(1)+w/6 y(8)+ybuff w dy];
REMORA.ct.CB_verify.useSpectra = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.useSpectra,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.useSpectra),...
   'Visible','on',...
   'HorizontalAlignment','left',...
   'Callback','ct_cb_control(''setUseSpectraTF'')');

%% LinearTF Checkbox
labelStr = 'Compare spectra in linear space';
btnPos=[x(1)+w/3 y(10)+ybuff w*2 dy];
REMORA.ct.CB_verify.linearCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.linearTF,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.linearTF),...
   'Visible',showSpectraOptions,...
   'Callback','ct_cb_control(''setLinearTF'')');

%% Start Freq Text
labelStr = 'Start Freq (kHz)';
btnPos=[x(1)+w/3 y(9) w/2 h];
REMORA.ct.CB_verify.startFreqTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.freqs),...
   'Visible',showSpectraOptions);%   

% Start Freq Editable Text
labelStr = num2str(REMORA.ct.CB_params.startFreq);
btnPos = [x(2)-w/5 y(9)+ybuff w/6 h];
REMORA.ct.CB_verify.startFreqEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible',showSpectraOptions,...
    'Callback','ct_cb_control(''setStartFreq'')');

%% End Freq Text
labelStr = 'End Freq (kHz)';
btnPos=[x(2) y(9) w/2 h];
REMORA.ct.CB_verify.endFreqTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.freqs),...
   'Visible',showSpectraOptions);%   

% End Freq Editable Text
labelStr = num2str(REMORA.ct.CB_params.endFreq);
btnPos = [x(2)+w/2 y(9)+ybuff w/6 h];
REMORA.ct.CB_verify.endFreqEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible',showSpectraOptions,...
    'Callback','ct_cb_control(''setEndFreq'')');

%% Diff Checkbox
labelStr = 'Compare spectra on first derivative';
btnPos=[x(1)+w/3 y(11)+ybuff w*2 dy];
REMORA.ct.CB_verify.diffCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.diff,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.diff),...
   'Visible',showSpectraOptions,...
   'Callback','ct_cb_control(''setDiff'')');

%% Cluster on Waveform Envelope
if ~isfield(REMORA.ct.CB_params,'useEnvelope')
    REMORA.ct.CB_params.useEnvelope = 0;
end
labelStr = 'Cluster on Waveform';
btnPos = [x(1)+w/6 y(12)+ybuff w dy];
REMORA.ct.CB_verify.useEnvelope = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.useEnvelope,...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.useEnvelope),...
   'Visible','on',...
   'Callback','ct_cb_control(''setUseEnvelopeTF'')');

if ~isfield(REMORA.ct.CB_params,'normalizeTF')
    REMORA.ct.CB_params.normalizeTF = 1;
end
labelStr = 'Normalize Amplitudes';
btnPos = [x(1)+w/6 y(13)+ybuff w dy];
REMORA.ct.CB_verify.normalizeTF = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.normalizeTF,...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.normalizeTF),...
   'Visible','on',...
   'Callback','ct_cb_control(''setNormalizeTF'')');

%% Min Cluster Size Text
labelStr = 'Min. Cluster Size';
btnPos=[x(3)+w/6  y(8)-ybuff w h];
REMORA.ct.CB_verify.minClustTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'Visible','on',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.minClust));%   'BackgroundColor',bgColor3,...

% Min Cluster Size Editable Text
labelStr=num2str(REMORA.ct.CB_params.minClust);
btnPos=[x(4) y(8) w/2 h];
REMORA.ct.CB_verify.minClustEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'TooltipString',sprintf(REMORA.ct.CB_params_help.minClust),...
    'Visible','on',...
    'Callback','ct_cb_control(''setMinClustSize'')');

%% Prune Thresh Text
labelStr = 'Pruning Threshold [0-100]';
btnPos=[x(3)+w/6  y(9)-ybuff w h];
REMORA.ct.CB_verify.pruneThrTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.pruneThr),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Prune Thresh Editable Text
labelStr=num2str(REMORA.ct.CB_params.pruneThr);
btnPos=[x(4) y(9) w/2 h];
REMORA.ct.CB_verify.pruneThrEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setPruneThr'')');

labelStr = 'Percentage';
btnPos=[x(4)+w/2 y(9)+ybuff w/2 dy];
REMORA.ct.CB_verify.variableThreshold = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.variableThreshold,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.variableThreshold),...
   'Visible','on',...
   'Callback','ct_cb_control(''setVariableThreshold'')');

%% TimeStep Text
labelStr = 'Time bin size (minutes)';
btnPos=[x(3)+w/6 y(10)-ybuff w h];
REMORA.ct.CB_verify.timeStepTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.timeStep),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% TimeStep Editable Text
labelStr = num2str(REMORA.ct.CB_params.timeStep);
btnPos=[x(4) y(10) w/2 h];
REMORA.ct.CB_verify.timeStepEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setTimeStep'')');

%% PP thresh Text
labelStr = 'Peak-To-Peak Ampl. Threshold';
btnPos = [x(3)+w/6  y(11)-ybuff w h];
REMORA.ct.CB_verify.ppThreshTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.ppThresh),...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% PP Thresh Editable Text
labelStr=num2str(REMORA.ct.CB_params.ppThresh);
btnPos=[x(4) y(11) w/2 h];
REMORA.ct.CB_verify.ppThreshEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setppThresh'')');

%% ICI Max Text
labelStr = 'Max ICI (Sec)';
btnPos=[x(3)+w/6 y(12)-ybuff w h];
REMORA.ct.CB_verify.barIntMaxTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'HorizontalAlignment','left',...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.barIntMax),...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% ICI Max Editable Text
labelStr=num2str(REMORA.ct.CB_params.barIntMax);
btnPos=[x(4) y(12) w/2 h];
REMORA.ct.CB_verify.barIntMaxEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setBarIntMax'')');

%% Min Cue Gap Text
labelStr = 'Min Cue Gap (Sec)';
btnPos=[x(3)+w/6 y(13)-ybuff w h];
REMORA.ct.CB_verify.minCueGapTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'HorizontalAlignment','left',...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.minCueGap),...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Min cue gap Editable Text
labelStr=num2str(REMORA.ct.CB_params.minCueGap);
btnPos=[x(4) y(13) w/2 h];
REMORA.ct.CB_verify.minCueGapEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setMinCueGap'')');



%% Clustering parameters header
labelStr = 'Clustering Options & Performance Settings';
btnPos=[x(1) y(14) w*4 h-ybuff];
REMORA.ct.CB_verify.coptstext = uicontrol(REMORA.fig.ct.CB_settings, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorRed,...
    'String',labelStr, ...
    'FontSize',10,...
    'FontUnits','points',...
    'FontWeight','bold',...
    'Visible','on'); 

%% Plot Checkbox
labelStr = 'Show plots during execution';
btnPos=[x(1)+w/3 y(15)+ybuff w*2 dy];
REMORA.ct.CB_verify.plotCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.plotFlag,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.plotFlag),...
   'Visible','on',...
   'Callback','ct_cb_control(''setPlotFlag'')');


%% Plot Pause Checkbox
if ~isfield(REMORA.ct.CB_params, 'pauseAfterPlotting')
    REMORA.ct.CB_params.pauseAfterPlotting = 0;
end

labelStr = 'Pause after plotting';
btnPos=[x(1)+(w/2) y(16)+ybuff w*2 dy];
REMORA.ct.CB_verify.plotPauseCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.pauseAfterPlotting,...
   'FontUnits','normalized', ...
   'Visible','on',...
   'Callback','ct_cb_control(''setPlotPause'')');

%% RM False Checkbox
labelStr = 'Remove labeled false positives from detEdit';
btnPos=[x(1)+w/3 y(17)+ybuff w*2 dy];
REMORA.ct.CB_verify.falseRMCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.falseRM,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.falseRM),...
   'Visible','on',...
   'Callback','ct_cb_control(''setFalseRM'')');


%% Merge Checkbox
labelStr = 'Merge nodes';
btnPos=[x(1)+w/3 y(18)+ybuff w*2 dy];
REMORA.ct.CB_verify.mergeCheck = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','checkbox',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'Value',REMORA.ct.CB_params.mergeTF,...
   'FontUnits','normalized', ...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.mergeTF),...
   'Visible','on',...
   'Callback','ct_cb_control(''setMergeTF'')');


%% Parpool Text
labelStr = 'Parallel pool size';
btnPos=[x(3)+w/6 y(15)-ybuff w h];
REMORA.ct.CB_verify.parpoolSizeTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'HorizontalAlignment','left',...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.parpoolSize),...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Parpool Editable Text
labelStr=num2str(REMORA.ct.CB_params.parpoolSize);
btnPos=[x(4) y(15) w/2 h];
REMORA.ct.CB_verify.parpoolSizeEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setParpoolSize'')');

%% CW Interations Text
labelStr = 'Max Clustering Iterations';
btnPos=[x(3)+w/6 y(16)-ybuff w h];
REMORA.ct.CB_verify.maxCWitrTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.maxCWiterations),...
   'FontUnits','normalized', ...
   'HorizontalAlignment','left',...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% CW Iterations Editable Text
labelStr=num2str(REMORA.ct.CB_params.maxCWiterations);
btnPos=[x(4) y(16) w/2 h];
REMORA.ct.CB_verify.maxCWitrEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setMaxCWiterations'')');

%% Max Network Size Text
labelStr = 'Max Network Size';
btnPos=[x(3)+w/6 y(17)-ybuff w h];
REMORA.ct.CB_verify.maxNetworkSzTxt = uicontrol(REMORA.fig.ct.CB_settings,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'String',sprintf(labelStr,'Interpreter','tex'),...
   'TooltipString',sprintf(REMORA.ct.CB_params_help.maxNetworkSz),...
   'HorizontalAlignment','left',...
   'FontUnits','normalized', ...
   'Visible','on');%   'BackgroundColor',bgColor3,...

% Max Network Size Editable Text
labelStr=num2str(REMORA.ct.CB_params.maxNetworkSz);
btnPos=[x(4) y(17) w/2 h];
REMORA.ct.CB_verify.maxNetworkSzEdTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','ct_cb_control(''setMaxNetworkSz'')');

%% Run button
labelStr = 'Run Cluster Bins';
btnPos=[x(2)+w/2 y(19) w h];

REMORA.ct.CB_verify.runTxt = uicontrol(REMORA.fig.ct.CB_settings,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor3,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','ct_cb_control(''runClusterBins'')');


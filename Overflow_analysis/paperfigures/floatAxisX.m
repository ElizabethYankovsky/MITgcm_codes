function [hl1,ax2,ax3] = floatAxisX(varargin)
% floatAxisX  create floating x-axis for multi-parameter plot
% =========================================================================
% floatAxisX  Version 1.2 6-Mar-2000
%
% Usage: 
%   [h1,ax2,ax3] = floatAxisX(varargin)
%
% Description:
%   This Matlab function creates a floating x-axis for mutli-parameter
%   plots with different units on the same figure. For example, in oceanography,
%   it is common to plot temperature, salinity, and density versus depth.
%
%
% Input:
%   A minimum of two parameters is required. The first and second parameters are
%   the x,y pairs to plot. The third parameter (optional) specifies the linestyle
%   (defaults to 'k-' solid black). The fourth parameter (optional) specifies the
%   x-axis label for the floating axis. The fifth parameter (optional) specifies 
%   the x and y limits for the axis(this should be of the form 
%   [xlower xupper ylower yupper]).
%
% Output:
%   n/a
%
% Called by:
%   CTDplotX.m - script to demo floatAxis function
%
% Calls:
%   n/a
%
% Author:
%   Blair Greenan
%   Bedford Institute of Oceanography
%   18-May-1999
%   Matlab 5.2.1
%   greenanb@mar.dfo-mpo.gc.ca
% =========================================================================
%

% History
% Version 1.0 18-May-1999
% Version 1.1 31-May-1999
%    Added the ability to pass an array containing the x and y limits for
%    the axis.
% Version 1.2 6-Mar-2000
%    Added code to handle data with different y-limits. Previous versions
%    assumed all data had the same y-limits. Oops! Thanks to Jan Even Nilsen
%    (even@gfi.uib.no) for pointing this out.

% strip the arguments passed in
if (nargin < 2)
   error('floatAxis requires a minimum of three parameters')
elseif (nargin == 2)
   x = varargin{1};
   y = varargin{2};
   % default lines style (solid black line) 
   lstyle = 'k-';   
elseif (nargin == 3)
   x = varargin{1};
   y = varargin{2};  
   lstyle = varargin{3};
elseif (nargin == 4)
   x = varargin{1};
   y = varargin{2};  
   lstyle = varargin{3};
   xlbl = varargin{4};
elseif (nargin == 5)
   x = varargin{1};
   y = varargin{2};
   lstyle = varargin{3};
   xlbl = varargin{4};
   limits = varargin{5};
else
   error('Too many arguments')
end

% get position of axes
allAxes = get(gcf,'Children');
ax1Pos = get(allAxes(length(allAxes)),'position');

% rescale and reposition all axes to handle additional axes
for ii = 1:length(allAxes)-1
   if (rem(ii,2)==0) 
      % even ones in array of axes handles represent axes on which lines are plotted
      set(allAxes(ii),'Position',[ax1Pos(1) ax1Pos(2)+0.11 ax1Pos(3) ax1Pos(4)-0.11])
   else
      % odd ones in array of axes handles represent axes on which floating x-axss exist
      axPos = get(allAxes(ii),'Position');
      set(allAxes(ii),'Position',[axPos(1) axPos(2)+0.1 axPos(3) axPos(4)])
   end
end
% first axis a special case (doesn't fall into even/odd scenario of figure children)
set(allAxes(length(allAxes)),'Position',[ax1Pos(1) ax1Pos(2)+0.11 ax1Pos(3) ax1Pos(4)-0.11])
ylimit1 = get(allAxes(length(allAxes)),'Ylim');

% get new position for plotting area of figure
ax1Pos = get(allAxes(length(allAxes)),'position');

% axis to which the floating axes will be referenced
ref_axis = allAxes(1);
refPosition = get(ref_axis,'position');

% overlay new axes on the existing one
ax2 = axes('Position',ax1Pos);
% plot data and return handle for the line
hl1 = plot(x,y,lstyle,'Linewidth',2);
% make the new axes invisible, leaving only the line visible
set(ax2,'visible','off','ylim',ylimit1)

if (nargin < 5)
   % get the x limits for the 
   xlimit = get(ax2,'XLim');
else
   set(ax2,'XLim',[limits(1) limits(2)],'YLim',[limits(3) limits(4)]);
end

% set the axis limit mode so that it does not change if the
% user resizes the figure window
set(ax2,'xLimMode','manual')

% set up another set of axes to act as floater
ax3 = axes('Position',[refPosition(1) refPosition(2)-0.1 refPosition(3) 0.01]);
set(ax3,'box','off','ycolor','w','yticklabel',[],'ytick',[])
set(ax3,'XMinorTick','off','color','none','xcolor',get(hl1,'color'))
if (nargin < 5)
   set(ax3,'XLim',xlimit)
else
   set(ax3,'XLim',[limits(1) limits(2)],'YLim',[limits(3) limits(4)])
end

% label the axis
if (nargin > 3)
   xlabel(xlbl)
end



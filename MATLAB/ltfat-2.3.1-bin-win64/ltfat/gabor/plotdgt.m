function coef=plotdgt(coef,a,varargin)
%PLOTDGT  Plot DGT coefficients
%   Usage: plotdgt(coef,a);
%          plotdgt(coef,a,fs);
%          plotdgt(coef,a,fs,dynrange);
%
%   PLOTDGT(coef,a) plots the Gabor coefficients coef. The coefficients
%   must have been produced with a time shift of a.
%
%   PLOTDGT(coef,a,fs) does the same assuming a sampling rate of
%   fs Hz of the original signal.
%
%   PLOTDGT(coef,a,fs,dynrange) additionally limits the dynamic range.
%
%   The figure generated by this function places the zero-frequency in
%   the center of the y-axis, with positive frequencies above and
%   negative frequencies below.
%   
%   C=PLOTDGT(...) returns the processed image data used in the
%   plotting. Inputting this data directly to imagesc or similar
%   functions will create the plot. This is useful for custom
%   post-processing of the image data.
%
%   PLOTDGT supports all the optional parameters of TFPLOT. Please see
%   the help of TFPLOT for an exhaustive list.
%
%   See also:  dgt, tfplot, sgram, plotdgtreal
%
%   Url: http://ltfat.github.io/doc/gabor/plotdgt.html

% Copyright (C) 2005-2016 Peter L. Soendergaard <peter@sonderport.dk>.
% This file is part of LTFAT version 2.3.1
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%   AUTHOR : Peter L. Søndergaard.
%   TESTING: NA
%   REFERENCE: NA

complainif_notenoughargs(nargin,2,mfilename);
complainif_notposint(a,'a',mfilename);

definput.import={'ltfattranslate','tfplot'};
[flags,kv,fs]=ltfatarghelper({'fs','dynrange'},definput,varargin);

M=size(coef,1);

% Move zero frequency to the center and Nyquist frequency to the top.
if rem(M,2)==0
  coef=circshift(coef,M/2-1);
  yr=[-1+2/M, 1];
else
  coef=circshift(coef,(M-1)/2);
  yr=[-1+2/M, 1-2/M];
end;

coef=tfplot(coef,a,yr,'argimport',flags,kv);

if nargout<1
    clear coef;
end


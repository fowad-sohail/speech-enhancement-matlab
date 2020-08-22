%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Either load in an ascii .dat file or
% uses wavread to read a wave file
% function [speechData] = load_or_audioread(speechFile)
% speechfile in quotes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [speechData] = load_or_audioread(speechFile)

% The speech file is loaded
if (ischar(speechFile))
    if(strcmpi(speechFile(end-3:end),'.dat'))
        speechData = load(speechFile);
    elseif(strcmpi(speechFile(end-3:end),'.wav'))
        speechData = audioread(speechFile);
    end
elseif (isnumeric(speechFile))
    speechData = speechFile;
end
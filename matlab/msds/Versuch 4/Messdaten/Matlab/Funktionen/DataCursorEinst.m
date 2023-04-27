function output_txt = DataCursorEinst(obj,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

Digits = 8;

pos = get(event_obj,'Position');
output_txt = {['t: ',num2str(pos(1),Digits)],...
    ['Y: ',num2str(pos(2),Digits)]};

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),Digits)];
end

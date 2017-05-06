
% Globals
% We will declare global variables that this function and the callbacks
% can all access

global WAYPOINTS WIDX DIST_THRESHOLD CMDMSG CMDPUB DONEFLAG;
% List of waypoints (x,y) in order of operation
WAYPOINTS= [5,5
    -5,5];
WIDX = 1;  % Index of active waypoint
% Set a distance metric for reaching a waypoint
DIST_THRESHOLD = 1;
% Flag for callback to tell us we are done.
DONEFLAG = false;

% Setup publisher
CMDPUB = rospublisher('/p1/my_p3at/cmd_vel');
pause(2); % Wait to ensure publisher is registered
% Create an empty Twist message for publication
CMDMSG = rosmessage(CMDPUB);

% Setup subscriber using a callback function
poseSub = rossubscriber('/p1/my_p3at/pose',@waypoint_callback);

try
    % Infinite loop
    while 1
        pause(1.0);
        % Keep running till th callback flips the DONEFLAG
        if (DONEFLAG)
            break;
        end
    end
catch
    
end

% Clear all our subscribers
clear poseSub;

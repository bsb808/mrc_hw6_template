function [] = waypoint_callback(src,msg)

% Callback function for incoming Odometry messages 

% Global variables

global WAYPOINTS WIDX DIST_THRESHOLD CMDMSG CMDPUB DONEFLAG;

% Process the Odometry message
x = msg.Pose.Pose.Position.X;
y = msg.Pose.Pose.Position.Y;
q = msg.Pose.Pose.Orientation;
angles = quat2eul([q.W,q.X,q.Y,q.Z]);
th = angles(1);  % In radians!
% Print some debugging information - the current state
fprintf('Odometry - X: %f, Y: %f, Theta: %f \n',x,y,th);

% Current waypoint location
wp_x = WAYPOINTS(WIDX,1);
wp_y = WAYPOINTS(WIDX,2);
fprintf('Current WP - X:%f, Y: %f \n',wp_x,wp_y);

%% Waypoint following algorithm
% This is just a place holder
dist = 0.0;
linvel = 0.0;
angvel = 0.0;

%% Logic to deal with uwaypoints
if (dist <= DIST_THRESHOLD)
    if (WIDX < size(WAYPOINTS,1))
        disp('Going to next waypoint!');
        WIDX = WIDX+1;
    else
        disp('Done!')
        DONEFLAG = true;
    end
else
    % Populate the twist message
    CMDMSG.Linear.X = linvel;
    CMDMSG.Angular.Z = angvel;
    % Publish
    fprintf('Publishing cmd_vel with lin. vel: %f, ang. vel.: %f\n', ...
        linvel,angvel);
    send(CMDPUB,CMDMSG);
end
    


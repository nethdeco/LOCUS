#!/bin/bash
SESSION=BLAM

## Start up
tmux -2 new-session -d -s $SESSION

tmux split-window -v -p 75
tmux select-pane -t 1
tmux split-window -v -p 75
tmux select-pane -t 0
tmux split-window -h
tmux select-pane -t 2
tmux split-window -h

# Start ROSCORE
tmux send-keys -t 0 "roscore" C-m

# Start ORBSLAM
tmux send-keys -t 2 "sleep 1; source ~/perception_ws/devel/setup.bash;roslaunch blam_example test_online.launch" C-m

# Place rosbag
tmux send-keys -t 1 "rosbag play -r 1 -s 2 /home/costar/Downloads/full_tunnel_hand-carry_no_rs_2_2019-01-19-laser_imu.bag" 


# Prep tf record script
tmux send-keys -t 3 "sleep 2; rviz -d /home/costar/perception_ws/src/localization/localizer_blam/internal/src/blam_example/rviz/lidar_slam.rviz" C-m

# Prep close script
tmux send-keys -t 4 "source /home/costar/perception_ws/devel/setup.bash; cd /home/costar/perception_ws/src/localizer/localizer_blam/internal/src/human_loop_closure" C-m
tmux send-keys -t 4 "python manual_graph_edge.py "



# place cursor in image pub
tmux select-pane -t 1

tmux -2 attach-session -t $SESSION

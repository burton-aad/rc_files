#!/usr/bin/python

from __future__ import print_function
import subprocess
import re
import sys
import argparse

class Monitor:
    def __init__(self, w, h, rx, ry):
        self.left = rx
        self.right = rx+w
        self.up = ry
        self.down = ry+h

    def __repr__(self):
        return "{}x{}+{}+{}".format(self.right-self.left, self.down-self.up, self.left, self.up)

    def is_in(self, x, y):
        return self.left <= x <= self.right and self.up <= y <= self.down

def monitors_positions():
    "return list of monitor upper left absolute position"
    o, _ = subprocess.Popen(["xrandr", "-q"],
                            stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE).communicate()
    mon_pos=[]
    r = re.compile(" connected(?: primary)? (\d+)x(\d+)\+(\d+)\+(\d+)")
    for l in o.decode('ascii').splitlines():
        m = r.search(l)
        if m is not None:
            mon_pos.append(Monitor(*map(int, m.groups())))
    return mon_pos

def position_with_limits(center, size, start_limit, end_limit):
    """Return the start position based on the center and the size which set
       the window inside the limits. If the window is greater than the limits only
       the start position will be inside."""
    pos = center - size/2
    pos -= max(0, pos + size - end_limit)
    pos += max(0, start_limit - pos)
    return pos

def main(args):
    mpos = [m for m in monitors_positions() if m.is_in(args.xpos, args.ypos)][0]
    xpos = position_with_limits(args.xpos, args.width,
                                mpos.left + args.x_marg, mpos.right - args.x_marg)
    ypos = position_with_limits(args.ypos, args.height,
                                mpos.up + args.y_marg, mpos.down - args.y_marg)
    print(xpos, ypos)

if __name__=="__main__":
    parser = argparse.ArgumentParser(description='Give window position from a reference to avoid the window to be outside the screen')
    parser.add_argument('xpos', type=int, help='The reference x position (center of the window)')
    parser.add_argument('ypos', type=int, help='The reference y position (center of the window)')
    parser.add_argument('width', type=int, help='The window width')
    parser.add_argument('height', type=int, help='The window height')
    parser.add_argument('--x_marg', type=int, default=10,
                        help='The minimal horizontal gap between the window and the border of the screen')
    parser.add_argument('--y_marg', type=int, default=40,
                        help='The minimal horizontal gap between the window and the border of the screen')
    args = parser.parse_args()

    main(args)

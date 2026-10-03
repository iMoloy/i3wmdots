#!/bin/sh

i3-msg config border_width ${BORDER_WIDTH}
i3-msg config top_padding ${TOP_PADDING}
i3-msg config bottom_padding ${BOTTOM_PADDING}
i3-msg config left_padding ${LEFT_PADDING}
i3-msg config right_padding ${RIGHT_PADDING}
i3-msg config normal_border_color "${NORMAL_BC}"
i3-msg config focused_border_color "${FOCUSED_BC}"
i3-msg config presel_feedback_color "${blue}"

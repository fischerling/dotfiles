-- Solarized color codes Copyright (c) 2011 Ethan Schoonover

local lexers = vis.lexers

-- The colors used by the solarized scheme for st
-- http://st.suckless.org/patches/solarized
--
-- "#073642",  /*  0: black    */ -> base02
-- "#dc322f",  /*  1: red      */ -> red
-- "#859900",  /*  2: green    */ -> green
-- "#b58900",  /*  3: yellow   */ -> yellow
-- "#268bd2",  /*  4: blue     */ -> blue
-- "#d33682",  /*  5: magenta  */ -> magenta
-- "#2aa198",  /*  6: cyan     */ -> cyan
-- "#eee8d5",  /*  7: white    */ -> base2
-- "#002b36",  /*  8: brblack  */ -> base03
-- "#cb4b16",  /*  9: brred    */ -> orange
-- "#586e75",  /* 10: brgreen  */ -> base01
-- "#657b83",  /* 11: bryellow */ -> base00
-- "#839496",  /* 12: brblue   */ -> base0
-- "#6c71c4",  /* 13: brmagenta*/ -> violet
-- "#93a1a1",  /* 14: brcyan   */ -> base1
-- "#fdf6e3",  /* 15: brwhite  */ -> base3
                                                                 

local colors = {
	['base03']  = '8', -- '#002b36',
	['base02']  = '0', -- '#073642',
	['base01']  = '10', -- '#586e75',
	['base00']  = '11', -- '#657b83',
	['base0']   = '12', -- '#839496',
	['base1']   = '14', -- '#93a1a1',
	['base2']   = '7', -- '#eee8d5',
	['base3']   = '15', -- '#fdf6e3',
	['yellow']  = '3', -- '#b58900',
	['orange']  = '9', -- '#cb4b16',
	['red']     = '1', -- '#dc322f',
	['magenta'] = '5', -- '#d33682',
	['violet']  = '13',  -- '#6c71c4',
	['blue']    = '4',  -- '#268bd2',
	['cyan']    = '6',  -- '#2aa198',
	['green']   = '2',  -- '#859900',
} 

lexers.colors = colors
-- dark
local fg = ',fore:'..colors.base0..','
local bg = ',back:'..colors.base03..','
-- light
-- local fg = ',fore:'..colors.base03..','
-- local bg = ',back:'..colors.base3..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:yellow'
lexers.STYLE_COMMENT = 'fore:'..colors.base01
lexers.STYLE_CONSTANT = 'fore:'..colors.cyan
lexers.STYLE_DEFINITION = 'fore:'..colors.blue
lexers.STYLE_ERROR = 'fore:'..colors.red..',italics'
lexers.STYLE_FUNCTION = 'fore:'..colors.blue
lexers.STYLE_KEYWORD = 'fore:'..colors.green
lexers.STYLE_LABEL = 'fore:'..colors.green
lexers.STYLE_NUMBER = 'fore:'..colors.cyan
lexers.STYLE_OPERATOR = 'fore:'..colors.green
lexers.STYLE_REGEX = 'fore:green'
lexers.STYLE_STRING = 'fore:'..colors.cyan
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.orange
lexers.STYLE_TAG = 'fore:'..colors.red
lexers.STYLE_TYPE = 'fore:'..colors.yellow
lexers.STYLE_VARIABLE = 'fore:'..colors.blue
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = 'back:blue'
lexers.STYLE_IDENTIFIER = fg

lexers.STYLE_LINENUMBER = fg
lexers.STYLE_CURSOR = 'fore:'..colors.base03..',back:'..colors.base0
lexers.STYLE_CURSOR_PRIMARY = lexers.STYLE_CURSOR..',back:yellow'
lexers.STYLE_CURSOR_LINE = 'back:'..colors.base00
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.base00
-- lexers.STYLE_SELECTION = 'back:'..colors.base02
lexers.STYLE_SELECTION = 'back:white'

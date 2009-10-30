-- Imports --

import XMonad.Config.Kde
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import IO (Handle, hPutStrLn) 

-- utils
import XMonad.Util.Run (spawnPipe)

-- hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.FadeInactive

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimpleFloat
import XMonad.Layout.WindowArranger
import XMonad.Layout.Tabbed
import XMonad.Layout.SimpleDecoration

import XMonad.Util.Themes

-------------------------------------------------------------------------------
-- Main --
main = do
       xmonad $ kdeConfig 
              { workspaces = workspaces'
              , modMask = modMask'
              , borderWidth = borderWidth'
              , normalBorderColor = normalBorderColor'
              , focusedBorderColor = focusedBorderColor'
              , terminal = terminal'
              , keys = keys'
              , layoutHook = layoutHook'
              , manageHook = manageHook'
              , focusFollowsMouse  = True
              }

-------------------------------------------------------------------------------

-- Hooks --
manageHook' :: ManageHook
manageHook' = (doF W.swapDown) <+> manageHook kdeConfig <+> myManageHook

-- Set up a customized manageHook (rules for handling windows on creation)
myManageHook :: ManageHook                                      
myManageHook = composeAll $
                   -- auto-float certain windows
                 [ className =? c --> doCenterFloat | c <- myFloats ]
                 ++
                 [ title =? t     --> doCenterFloat | t <- myFloatTitles ]
                   -- send certain windows to certain workspaces
                 ++
                 [ className =? "Firefox" --> doF (W.shift "web")       
                 , className =? "Thunderbird-bin" --> doF (W.shift "mail") 
                 , className =? "OpenOffice.org 3.1" --> doF (W.shift "o")
                 , manageDocks                                   
                 ]
    -- windows to auto-float
    where myFloats = [ "VLC"
                     , "Gimp"
                     ]
          myFloatTitles = ["Add-ons", "About Shiretoko", "Selenium IDE"]



--logHook' h = dzenCustomPP { ppOutput = hPutStrLn h }
layoutHook' = avoidStruts  $ customLayout

-------------------------------------------------------------------------------
-- bar
customPP :: PP
customPP = defaultPP { ppCurrent = xmobarColor "white" "" . wrap "<" ">"
                     , ppTitle =  shorten 80
                     , ppSep =  "<fc=#AFAF87> | </fc>"
                     , ppHiddenNoWindows = xmobarColor "#AFAF87" ""
                     , ppUrgent = xmobarColor "#FFFFAF" "" . wrap "[" "]"
                     }

-- borders
borderWidth' :: Dimension
borderWidth' = 1

normalBorderColor', focusedBorderColor' :: String
normalBorderColor'  = "#333333"
focusedBorderColor' = "#AFAF87"

-- workspaces
workspaces' :: [WorkspaceId]
workspaces' = ["web", "work", "term", "o"]

-- layouts
customLayout = onWorkspace "web" Full $ onWorkspace "term" (Mirror tiled ||| simpleTabbed ||| tiled) $ onWorkspace "o" simpleTabbed $ simpleTabbed ||| smartBorders (Mirror tiled ||| tiled)
  where
    tiled = ResizableTall 1 (2/100) (1/2) []

-------------------------------------------------------------------------------
-- Terminal --
terminal' :: String
terminal' = "konsole"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' :: KeyMask
modMask' = mod4Mask

-- keys
keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) 
    , ((modMask,                             xK_p     ), spawn "krunner")

    , ((modMask,               xK_w     ), kill)

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask,               xK_b     ), sendMessage ToggleStruts)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask,                xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask .|. shiftMask, xK_comma), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    , ((modMask .|. controlMask, xK_Down  ), sendMessage (IncreaseDown 10))
    , ((modMask .|. controlMask, xK_Up    ), sendMessage (DecreaseUp 10))
    , ((modMask .|. controlMask, xK_Right ), sendMessage (IncreaseRight 10))
    , ((modMask .|. controlMask, xK_Left  ), sendMessage (DecreaseLeft 10))
      
    , ((modMask,               xK_Pause   ), spawn "xscreensaver-command -lock")
    -- XF86Suspend
    , ((0, 0x1008ffa7), spawn "sudo pm-suspend")
    -- mpd controls
    , ((0, 0x1008ff13), spawn "amixer -c 0 set Master 4%+")
    , ((0, 0x1008ff11), spawn "amixer -c 0 set Master 4%-")
    , ((0, 0x1008ff12), spawn "amixer -c 0 set Master toggle")
    , ((modMask .|. controlMask,  xK_h     ), spawn "mpc prev")
    , ((modMask .|. controlMask,  xK_t     ), spawn "mpc pause")
    , ((modMask .|. controlMask,  xK_n     ), spawn "mpc play")
    , ((modMask .|. controlMask,  xK_s     ), spawn "mpc next")

    -- quit, or restart
    , ((modMask              , xK_q     ), restart "xmonad" True)
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_F1 .. xK_F4]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


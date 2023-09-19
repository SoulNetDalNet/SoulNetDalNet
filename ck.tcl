#############################################################
## ckC TCL v.3.31 by cokkie <cokkie@gmail.com>             ##
## Created Wednesday, October 11, 2000 5:03:34 AM          ##
## Modified Friday, July 26, 2002 8:11:27 AM               ##
## Copyright © 2002 cokkie ® CrW.                          ##
## ------------------------------------------------------- ##
## REQUIRES EGGDROP 1.3+ with toolkit.tcl and alltools.tcl ##
#############################################################

set vers           "v.3.31"  ; #TCL's version
set CC             "`"       ; #Command character
set timezone       "PST"     ; #Bot's time zone
set nopart         "#dago25" ; #Bot's main channel
set topicnick      1         ; #Adds the users nick in the topic when they set it via the bot
set greetflag      G         ; #Greet flag
set min            120       ; #How often to backup ckC files
set pubcommands    1         ; #Public commands for flags o p x
set mastercommands 1         ; #Public commands for flag m
set ownercommands  1         ; #Public commands for flag n
set moredcc        1         ; #Additional dcc commands
set combot         1         ; #Combot commands
set path           "[pwd]/"  ; #Bot's path (leave default)

## Do NOT edit anything below, unless you know what you're doing!

putlog "\[!4ckc\] "
putlog "\[!4ckc\]  Initializing ck4C.tcl"
putlog "\[!4ckc\]  tcl version 3.31"
putlog "\[!4ckc\]  copyright © 2002 cokkieiezZ® CrW."
putlog "\[!4ckc\] "

if {$numversion < 1030700} {
  putlog "\[!4ckc\] *** Can't load ckC.tcl, at least Eggdrop v1.3.7 required!"
  return 0
}

set thepath $path
set newpath $path
set greetfile "${nick}.greet"
set emailfile "${nick}.email"
set urlfile "${nick}.url"
if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}
if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}

foreach x [timers] {
  if {[lindex $x 1] == "ckC_autosave"} {
    killtimer [lindex $x 2]
  }
}

#foreach u [utimers] {
#  if {[lindex $u 1] == "ckC_check"} {
#    killutimer [lindex $u 2]
#  }
#}

bind join G|G * join_greet
bind dcc p|p ckChelp dcc_ckChelp
bind dcc p|p ckChelp dcc_ckChelp
bind pub p|p ${CC}ckChelp pub_ckChelp
bind pub p|p ${CC}ckChelp pub_ckChelp
bind pub p|p ${CC}about pub_about
bind dcc p|p about dcc_about
bind pub p|p ${CC}version pub_version
bind dcc p|p version dcc_version
bind msg p|p auth msg_auth
bind msg p|p deauth msg_deauth
bind sign p|p * sign_deauth
bind part p|p * part_deauth

proc botname {} {global botname;return $botname}

if {$pubcommands==1} {
bind pub p|p ${CC}echo pub_echo
bind pub p|p ${CC}seen pub_seen
bind pub p|p ${CC}who pub_who
bind pub p|p ${CC}whois pub_whois
bind pub p|p ${CC}wi pub_whois
bind pub p|p ${CC}whom pub_whom
bind pub o|o ${CC}match pub_match
bind pub p|p ${CC}bots pub_bots
bind pub p|p ${CC}bottree pub_bottree
bind pub p|p ${CC}notes pub_notes
bind pub m ${CC}+ban pub_+ban
bind pub m ${CC}ban pub_ban
bind pub m ${CC}kb pub_kb
bind pub m ${CC}kickban pub_kickban
bind pub m ${CC}-ban pub_-ban
bind pub m ${CC}bans pub_bans
bind pub m ${CC}resetbans pub_resetbans
bind pub o|o ${CC}notice pub_notice
bind pub o|o ${CC}op pub_op
bind pub o|o ${CC}deop pub_deop
bind pub o|o ${CC}topic pub_topic
bind pub o|o ${CC}act pub_act
bind pub o|o ${CC}say pub_say
bind pub o|o ${CC}msg pub_msg
bind pub n|n ${CC}ckC pub_ckC
bind pub o|o ${CC}motd pub_motd
bind pub o|o ${CC}addlog pub_addlog
bind pub o|o ${CC}invite pub_invite
bind pub o|o ${CC}nick pub_nick
bind pub p|p ${CC}note pub_note
bind pub x|x ${CC}files pub_files
bind pub p|p ${CC}newpass pub_newpass
bind pub o|o ${CC}console pub_console
bind pub p|p ${CC}quit pub_quit
bind pub o|o ${CC}servers pub_servers
bind pub p|p ${CC}info pub_info
bind pub x|x ${CC}get pub_get
bind pub p|p ${CC}botinfo pub_botinfo
bind pub p|p ${CC}chat pub_chat
bind pub p|p ${CC}channel pub_channel
bind pub p|p ${CC}time pub_time
bind pub o|o ${CC}kick pub_kick
bind pub p|o ${CC}k pub_k
bind pub p|p ${CC}channels pub_channels
bind pub o|o ${CC}botinfo pub_botinfo
bind pub o|o ${CC}trace pub_trace
bind pub o|o ${CC}stick pub_stick
bind pub o|o ${CC}unstick pub_unstick
bind pub o|o ${CC}su pub_su
bind pub p|p ${CC}page pub_page
bind pub p|p ${CC}help pub_help
bind pub p|p ${CC}comment pub_comment
bind pub o|o ${CC}+t mode_+t
bind pub o|o ${CC}+n mode_+n 
bind pub o|o ${CC}+s mode_+s
bind pub o|o ${CC}+i mode_+i
bind pub o|o ${CC}+p mode_+p
bind pub o|o ${CC}+m mode_+m
bind pub o|o ${CC}+k mode_+k
bind pub o|o ${CC}+l mode_+l
bind pub o|o ${CC}-v mode_-v
bind pub o|o ${CC}-t mode_-t
bind pub o|o ${CC}-s mode_-s
bind pub o|o ${CC}-l mode_-l
bind pub o|o ${CC}-k mode_-k
bind pub o|o ${CC}-m mode_-m 
bind pub o|o ${CC}-i mode_-i
bind pub o|o ${CC}-n mode_-n
bind pub o|o ${CC}-p mode_-p
bind pub p|p ${CC}email pub_email
bind pub p|p ${CC}url pub_url
bind pub p|p ${CC}greet pub_greet
bind pub p|p ${CC}userinfo pub_userinfo
bind pub p|p ${CC}ui pub_userinfo
}

if {$mastercommands==1} {
bind pub n ${CC}adduser pub_adduser
bind pub n ${CC}+user pub_+user
bind pub n ${CC}-user pub_-user
bind pub n ${CC}deluser pub_deluser
bind pub m ${CC}+bot pub_+bot
bind pub m ${CC}-bot pub_-bot
bind pub m ${CC}+host pub_+host
bind pub m ${CC}-host pub_-host
bind pub n ${CC}chattr pub_chattr
bind pub m ${CC}save pub_save
bind pub m ${CC}chpass pub_chpass
bind pub m ${CC}chinfo pub_chinfo
bind pub m ${CC}chnick pub_chnick
bind pub m ${CC}chcomment pub_chcomment
bind pub m ${CC}+ignore pub_+ignore
bind pub m ${CC}-ignore pub_-ignore
bind pub m ${CC}ignores pub_ignores
bind pub m ${CC}reload pub_reload
bind pub n ${CC}jump pub_jump
bind pub n ${CC}rehash pub_rehash
bind pub n ${CC}restart pub_restart
bind dcc n join cmd_join
bind pub n ${CC}join pub_join
bind dcc n part cmd_part
bind pub n ${CC}part pub_part
bind dcc m global cmd_global
bind pub m ${CC}chaddr pub_chaddr
bind pub m ${CC}filestats pub_filestats
bind pub m ${CC}fixcodes pub_fixcodes
bind pub m ${CC}strip pub_strip
bind pub m ${CC}link pub_link
bind pub m ${CC}unlink pub_unlink
bind pub m ${CC}chbotattr pub_chbotattr
bind pub m ${CC}assoc pub_assoc
bind pub m ${CC}status pub_status
bind pub m ${CC}chaninfo pub_chaninfo
bind pub n ${CC}boot pub_boot
bind pub n ${CC}relay pub_relay
bind pub n ${CC}set pub_set
bind pub m ${CC}flush pub_flush
bind pub m ${CC}banner pub_banner
bind pub m ${CC}reset pub_reset
bind pub n ${CC}binds pub_binds
bind pub m ${CC}dump pub_dump
bind pub m ${CC}debug pub_debug
bind pub m ${CC}+chrec pub_+chrec
bind pub m ${CC}-chrec pub_-chrec
bind pub m ${CC}dccstat pub_dccstat
bind pub m ${CC}botattr pub_botattr
bind pub m ${CC}chemail pub_cchemail
bind pub m ${CC}churl pub_churl
bind pub m ${CC}chgreet pub_chgreet
bind dcc m chemail dcc_chemail
bind dcc m churl dcc_churl
bind dcc m chgreet dcc_chgreet
bind pub m ${CC}chemail pub_chemail
bind pub m ${CC}churl pub_churl
bind pub m ${CC}chgreet pub_chgreet
}

if {$ownercommands==1} {
bind dcc a botnick dcc_botnick
bind pub a ${CC}botnick pub_botnick
bind pub a ${CC}die pub_die
bind pub a ${CC}chanset pub_chanset
bind pub a ${CC}chansave pub_chansave
bind pub a ${CC}chanload pub_chanload
bind pub n ${CC}+chan pub_+chan
bind pub n ${CC}-chan pub_-chan
bind pub n ${CC}simul pub_simul
bind pub n ${CC}modules pub_modules
bind pub n ${CC}loadmodule pub_loadmodule
bind pub n ${CC}unloadmodule pub_unloadmodule
bind dcc a flsave dcc_flsave 
}

if {$moredcc==1} {
bind dcc o|o userlist cmd_userlist
bind dcc p|p channels cmd_channels
bind dcc o|o flagnote cmd_flagnote
bind dcc o|o say cmd_say
bind dcc o|o act cmd_act
bind dcc o|o addlog cmd_addlog
bind dcc o|o op cmd_op
bind dcc o|o deop cmd_deop
bind dcc m aop cmd_aop
bind dcc m raop cmd_raop
bind dcc o|o match dcc_match
bind filt p \001ACTION*\001 cmd_action
bind dcc p|p email dcc_email
bind dcc p|p url dcc_url
bind dcc p|p greet dcc_greet
bind dcc p|p userinfo dcc_userinfo
bind dcc p|p ui dcc_userinfo
bind dcc p|p wi dcc_wi
}

if {$combot==1} {
bind pub m ${CC}aop pub_aop
bind pub m ${CC}raop pub_raop
bind pub o|o ${CC}userlist pub_userlist
bind pub o|o ${CC}me pub_me
bind pub o|o up pub_up
bind pub o|o ${CC}up pub_up
bind pub o|o down pub_down
bind pub o|o ${CC}down pub_down
bind pub p|p ${CC}pong pub_pong
bind pub p|p ${CC}ping pub_ping
bind pub m ${CC}ban pub_ban
bind pub p|p ${CC}access pub_access
bind dcc p|p access dcc_access
bind pub -|- rollcall pub_rollcall
bind pub -|- ${CC}rollcall pub_rollcall
bind pub m ${CC}massunban pub_massunban
bind pub m ${CC}mub pub_massunban
bind dcc m massunban dcc_massunban
bind dcc m mub dcc_mub
bind dcc m massdeop dcc_massdeop
bind dcc m massop dcc_massop
bind dcc m mdeop cmd_mdeop
bind dcc m mop cmd_mop
bind pub m ${CC}massdeop pub_massdeop
bind pub m ${CC}massop pub_massop
bind pub m ${CC}mop pub_massop
bind pub m ${CC}mdeop pub_massdeop
}

## modes via pubic cmd -- start
proc mode_+v {nick uhost hand chan rest} {  
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+v <nick>"
  return 0
 }
 if {[onchan $rest $chan] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not on the channel."
  return 0
 }
 if {[isvoice $rest $chan] == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is already +v"
 }
 if {[onchan $rest $chan] == 1} {
  pushmode $chan +v $rest
 }
}

proc mode_-v {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
}
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-v <nick>"
  return 0
 }
 if {[onchan $rest $chan] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not on the channel."
  return 0
 }
 if {[isvoice $rest $chan] == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is already -v"
 }
 if {[onchan $rest $chan] == 1} {
  pushmode $chan -v $rest
 }
}

proc mode_+t {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +t
}

proc mode_-t {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -t
}

proc mode_+s {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +s-p
}

proc mode_-s {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -s
}

proc mode_+p {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +p-s
}

proc mode_-p {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -p
}

proc mode_+n {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +n
}

proc mode_-n {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -n
}

proc mode_+i {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +i
}

proc mode_-i {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -i
}

proc mode_+m {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan +m
}

proc mode_-m {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -m
}

proc mode_+l {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+l <limit>"
  return 0
 }
 pushmode $chan +l $rest
}

proc mode_-l {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -l $rest
}

proc mode_+k {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+k <key>"
  return 0
 }
 pushmode $chan +k $rest
}

proc mode_-k {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 pushmode $chan -k $rest
}

proc mode_+b {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+b <hostmask>"
  return 0
 }
 pushmode $chan +b $rest
}

proc mode_-b {nick uhost hand chan rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-b <hostmask>"
  return 0
 }
 pushmode $chan -b $rest
}
## modes via pubic cmd -- stop

## public cmd notice -- start
proc pub_notice {nick uhost hand channel rest} {
 set person [lindex $rest 0] 
 set rest [lrange $rest 1 end]
 if {$rest!=""} {
  puthelp "NOTICE $person :$rest"
  putlog "\[!4ckc\] <<$nick>> !$hand! Notice $rest"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: notice <nick> <msg>"
 }
}
## public cmd notice -- stop

## public cmd echo -- start
proc pub_echo {nick uhost hand chan rest} {
global botnick version CC
 puthelp "NOTICE $nick :\[!4ckc\] echo is only available via dcc chat."
} 
## public cmd echo -- stop

## start of dcc/pub cmds for userinfo, greet, chgreet, chemail, email, churl, url
proc url_read {} {
 global url botnick nick thepath
 set urlfile "${nick}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 if {![file exists $urlpath]} {
   set fd [open $urlpath w]
   puts $fd "### bnd4C Created on [unixtime]"
   close $fd
   putlog "\[!4ckc\] Creating url file information."
 }
 if {[file exists $urlpath]} {
   set fd [open $urlpath r]
   while {![eof $fd]} {
     set urlinfo [gets $fd]
     if {[string trim $urlinfo " "] != ""} {
       set url([lindex $urlinfo 0]) [lrange $urlinfo 1 end]
     }
   }
   close $fd
   return "url_read" 
 }
}

proc greet_read {} {
 global greet nick thepath
 set greetfile "${nick}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 if {![file exists $greetpath]} {
   set fd [open $greetpath w]
   puts $fd "### bnd4C Created on [unixtime]"
   close $fd
   putlog "\[!4ckc\] Creating greet file information"
 }
 if {[file exists $greetpath]} {
   set fd [open $greetpath r]
   while {![eof $fd]} {
     set greetinfo [gets $fd]
     if {[string trim [lindex $greetinfo 0] " "] != ""} {
       set greet([lindex $greetinfo 0]) [lrange $greetinfo 1 end]
     }
   }
   close $fd
   return "greet_read" 
 }
}

proc email_read {} {
 global email nick thepath
 set emailfile "${nick}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"} 
 if {![file exists $emailpath]} {
   set fd [open $emailpath w]
   puts $fd "### bnd4C Created on [unixtime]"
   close $fd
   putlog "\[!4ckc\] Creating email file information"
 }
 if {[file exists $emailpath]} {
   set fd [open $emailpath r]
   while {![eof $fd]} {
     set emailinfo [gets $fd]
     if {[string trim [lindex $emailinfo 0] " "] != ""} {
       set email([lindex $emailinfo 0]) [lrange $emailinfo 1 end]
     }
   }
   close $fd
   return "email_read"
 }
}

if {(![info exists greet]) || ([array size greet] == 0)} {
  greet_read
  putlog "\[!4ckc\] Loading bnd4C Greet File..."
}
if {(![info exists url]) || ([array size url] == 0)} {
  url_read
  putlog "\[!4ckc\] Loading bnd4C URL File..."
}
if {(![info exists email]) || ([array size email] == 0)} {
  email_read
  putlog "\[!4ckc\] Loading bnd4C E-Mail File..."
}

timer $min ckC_autosave
proc ckC_autosave {} {
 global min
 putlog "\[!4ckc\] Automatically backing up greet information"
 greet_save
 putlog "\[!4ckc\] Automatically backing up email information"
 email_save
 putlog "\[!4ckc\] Automatically backing up url information"
 url_save
 timer $min ckC_autosave
}

proc dcc_flsave {hand idx arg} {
 putcmdlog "\[!4ckc\] #$hand# flsave"
 putlog "\[!4ckc\] ${hand} requested backup of greet information"
 greet_save
 putlog "\[!4ckc\] ${hand} requested backup of email information"
 email_save
 putlog "\[!4ckc\] ${hand} requested backup of url information"
 url_save
}

proc url_save {} {
 global url nick thepath
 set urlfile "${nick}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 if {[file exists $urlpath]} {
   set fd [open $urlpath w]
   set start [array startsearch url]
   puts $fd "### $url(###)"
   while {[array anymore url $start]} {
     set item [array nextelement url $start]
     if {$item != "###"} {
       puts $fd "$item $url($item)"
     }
   }
   array donesearch url $start
   unset start
   close $fd
   putlog "\[!4ckc\] saving url information complete."
   return "url_save"
 }
}

proc greet_save {} {
 global greet botnick nick thepath
 set greetfile "${nick}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 if {[file exists $greetpath]} {
   set fd [open $greetpath w]
   set start [array startsearch greet]
   puts $fd "### $greet(###)"
   while {[array anymore greet $start]} {
     set item [array nextelement greet $start]
     if {$item != "###"} {
       puts $fd "$item $greet($item)"
     }
   }
   array donesearch greet $start
   close $fd
   putlog "\[!4ckc\] saving greet information complete."
 }
}

proc email_save {} {
 global email nick thepath
 set emailfile "${nick}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"} 
 if {[file exists $emailpath]} {
   set fd [open $emailpath w]
   set start [array startsearch email]
   puts $fd "### $email(###)"
   while {[array anymore email $start]} {
     set item [array nextelement email $start]
     if {$item != "###"} {
       puts $fd "$item $email($item)"
     }
   }
   array donesearch email $start
   unset start
   close $fd
   putlog "\[!4ckc\] saving email information complete."
   return "email_save"
 }
}

catch {unbind dcc - restart *dcc:restart ;bind dcc m restart fl_orig_restart} 0
proc fl_orig_restart {hand idx arg} {
 global greet url email thepath
 greet_save;email_save;url_save
 *dcc:restart $hand $idx $arg
}

catch {unbind dcc - rehash *dcc:rehash ;bind dcc m rehash fl_orig_rehash} 0
proc fl_orig_rehash {hand idx arg} {
 global greet url email thepath
 greet_save;email_save;url_save
 *dcc:rehash $hand $idx $arg
}

catch {unbind dcc - die *dcc:die ;bind dcc n die fl_orig_die} 0
proc fl_orig_die {hand idx arg} {
 greet_save;email_save;url_save
 *dcc:die $hand $idx $arg
}

set thebot $nick

proc pub_greet {nick uhost hand chan rest} {
 global greet botnick CC thepath thebot
 set greetfile "${thebot}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 set greetinfo [lrange $rest 0 end]
 if {$greetinfo == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}greet <new greet>"
   return 0
 }
 if {[lindex $greetinfo 0] == "none"} {
   set greet([string tolower $hand]) ""
   putcmdlog "\[!4ckc\] #${hand}# greet $greetinfo"
   puthelp "NOTICE $nick :\[!4ckc\] Your Greet msg has been removed." 
   return 0
 }
 set greet([string tolower $hand]) "$greetinfo"
 putcmdlog "\[!4ckc\] #${hand}# greet $greetinfo"
 puthelp "NOTICE $nick :\[!4ckc\] Setting for 'greet' is now $greetinfo"
}

proc dcc_greet {hand idx arg} {
 global greet botnick thebot CC thepath
 set greetfile "${thebot}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 set greetinfo [lrange $arg 0 end]
 if {$greetinfo == ""} {
   putdcc $idx "\[!4ckc\] Usage: .greet <new greet>"
   return 0
 }
 if {[lindex $greetinfo 0] == "none"} {
   set greet([string tolower $hand]) ""
   putcmdlog "\[!4ckc\] #${hand}# greet $greetinfo"
   putdcc $idx "\[!4ckc\] Your Greet msg has been removed."
   return 0
 }
 set greet([string tolower $hand]) "$greetinfo"
 putcmdlog "\[!4ckc\] #${hand}# greet $greetinfo"
 putdcc $idx "\[!4ckc\] Setting for 'greet' is now $greetinfo"
}

proc pub_email {nick uhost hand chan rest} { 
 global email botnick CC thebot thepath
 set emailfile "${thebot}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}
 set emailinfo [lrange $rest 0 end]
 if {$emailinfo == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}email <new email>"
   return 0
 }
 if {[lindex $emailinfo 0] == "none"} {
   set email([string tolower $hand]) ""
   putcmdlog "\[!4ckc\] #${hand}# email $emailinfo"
   puthelp "NOTICE $nick :\[!4ckc\] Your email msg has been removed."
   return 0
 }
 set email([string tolower $hand]) "$emailinfo"
 putcmdlog "\[!4ckc\] #${hand}# email $emailinfo"
 puthelp "NOTICE $nick :\[!4ckc\] Setting for 'email' is now $emailinfo"
}

proc dcc_email {hand idx arg} { 
 global email botnick thebot CC thepath
 set emailfile "${thebot}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}
 set emailinfo [lrange $arg 0 end]
 if {$emailinfo == ""} {
   putdcc $idx "\[!4ckc\] Usage: email <new email>"
   return 0
 }
 if {[lindex $emailinfo 0] == "none"} {
   set email([string tolower $hand]) ""
   putcmdlog "\[!4ckc\] #${hand}# email $emailinfo"
   putdcc $idx "\[!4ckc\] Your email msg has been removed."
   return 0
 }
 set email([string tolower $hand]) "$emailinfo"
 putcmdlog "\[!4ckc\] #${hand}# email $emailinfo"
 putdcc $idx "\[!4ckc\] Setting for 'email' is now $emailinfo"
}

proc pub_chemail {nick uhost hand chan rest} { 
 global email botnick thebot CC thepath
 set emailfile "${thebot}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}
 set user [string tolower [lindex $rest 0]]
 set emailinfo [lrange $rest 1 end]
 if {($emailinfo == "") || ($user == "")} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chemail <new email>"
   return 0
 }
 if {![validuser $user]} {
   puthelp "NOTICE $nick :\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $emailinfo 0] == "none"} {
   set email([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# chemail $user $emailinfo"
   puthelp "NOTICE $nick :\[!4ckc\] ${user}'s email msg has been removed."
   return 0
 }
 set email([string tolower $user]) "$emailinfo"
 putcmdlog "\[!4ckc\] #${hand}# chemail $user $emailinfo"
 puthelp "NOTICE $nick :\[!4ckc\] ${user}'s Setting for 'email' is now $emailinfo"
}

proc dcc_chemail {hand idx arg} { 
 global email botnick thebot thepath
 set emailfile "${thebot}.email"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}
 set user [string tolower [lindex $arg 0]]
 set emailinfo [lrange $arg 1 end]
 if {($emailinfo == "") || ($user == "")} {
   putdcc $idx "\[!4ckc\] Usage: ${CC}chemail <new email>"
   return 0
 }
 if {![validuser $user]} {
   putdcc $idx "\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $emailinfo 0] == "none"} {
   set email([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# chemail $user $emailinfo"
   putdcc $idx "\[!4ckc\] ${user}'s email msg has been removed."
   return 0
 }
 set email([string tolower $user]) "$emailinfo"
 putcmdlog "\[!4ckc\] #${hand}# chemail $user $emailinfo"
 putdcc $idx "\[!4ckc\] ${user}'s Setting for 'email' is now $emailinfo"
}

proc pub_chgreet {nick uhost hand chan rest} { 
 global greet botnick thebot CC thepath
 set greetfile "${thebot}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 set user [string tolower [lindex $rest 0]]
 set greetinfo [lrange $rest 1 end]
 if {($greetinfo == "") || ($user == "")} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chgreet <new greet>"
   return 0
 }
 if {![validuser $user]} {
   puthelp "NOTICE $nick :\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $greetinfo 0] == "none"} {
   set greet([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# chgreet $user $greetinfo"
   puthelp "NOTICE $nick :\[!4ckc\] ${user}'s greet msg has been removed."
   return 0
 }
 set greet([string tolower $user]) "$greetinfo"
 putcmdlog "\[!4ckc\] #${hand}# chgreet $user $greetinfo"
 puthelp "NOTICE $nick :\[!4ckc\] ${user}'s Setting for 'greet' is now $greetinfo"
}

proc dcc_chgreet {hand idx arg} { 
 global greet botnick thebot thepath
 set greetfile "${thebot}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 set user [string tolower [lindex $arg 0]]
 set greetinfo [lrange $arg 1 end]
 if {($greetinfo == "") || ($user == "")} {
   putdcc $idx "\[!4ckc\] Usage: ${CC}chgreet <new greet>"
   return 0
 }
 if {![validuser $user]} {
   putdcc $idx "\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $greetinfo 0] == "none"} {
   set greet([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# chgreet $user $greetinfo"
   putdcc $idx "\[!4ckc\] ${user}'s greet msg has been removed."
   return 0
 }
 set greet([string tolower $user]) "$greetinfo"
 putcmdlog "\[!4ckc\] #${hand}# chgreet $user $greetinfo"
 putdcc $idx "\[!4ckc\] ${user}'s Setting for 'greet' is now $greetinfo"
}

proc pub_url {nick uhost hand chan rest} {
 global url botnick thebot CC thepath
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 set urlinfo [lrange $rest 0 end]
 if {$urlinfo == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}url <new url>"
   return 0
 }
 if {[lindex $urlinfo 0] == "none"} {
   set url([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# url $urlinfo"
   puthelp "NOTICE $nick :\[!4ckc\] Your url msg has been removed." 
   return 0
 }
 set url([string tolower $hand]) "$urlinfo"
 putcmdlog "\[!4ckc\] #${hand}# url $urlinfo"
 puthelp "NOTICE $nick :\[!4ckc\] Setting for 'url' is now $urlinfo"
}

proc dcc_url {hand idx arg} {
 global url botnick thebot thepath
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 set urlinfo [lrange $arg 0 end]
 if {$urlinfo == ""} {
   putdcc $idx "\[!4ckc\] Usage: .url <new url>"
   return 0
 }
 if {[lindex $urlinfo 0] == "none"} {
   set url([string tolower $hand]) ""
   putcmdlog "\[!4ckc\] #${hand}# url $urlinfo"
   putdcc $idx "\[!4ckc\] Your url msg has been removed."
   return 0
 }
 set url([string tolower $hand]) "$urlinfo"
 putcmdlog "\[!4ckc\] #${hand}# url $urlinfo"
 putdcc $idx "\[!4ckc\] Setting for 'url' is now $urlinfo"
}

proc pub_churl {nick uhost hand chan rest} { 
 global url botnick thebot CC thepath
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 set user [string tolower [lindex $rest 0]]
 set urlinfo [lrange $rest 1 end]
 if {($urlinfo == "") || ($user == "")} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}churl <new url>"
   return 0
 }
 if {![validuser $user]} {
   puthelp "NOTICE $nick :\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $urlinfo 0] == "none"} {
   set url([string tolower $user]) ""
   putcmdlog "\[!4ckc\] #${hand}# churl $user $urlinfo"
   puthelp "NOTICE $nick :\[!4ckc\] ${user}'s url msg has been removed."
   return 0
 }
 set url([string tolower $user]) "$urlinfo"
 putcmdlog "\[!4ckc\] #${hand}# churl $user $urlinfo"
 puthelp "NOTICE $nick :\[!4ckc\] ${user}'s Setting for 'url' is now $urlinfo"
}

proc dcc_churl {hand idx arg} { 
 global url botnick thebot thepath
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 set user [string tolower [lindex $arg 0]]
 set urlinfo [lrange $arg 1 end]
 if {($urlinfo == "") || ($user == "")} {
   putdcc $idx "\[!4ckc\] Usage: ${CC}churl <new url>"
   return 0
 }
 if {![validuser $user]} {
   putdcc $idx "\[!4ckc\] no such user."
   return 0
 }
 if {[lindex $urlinfo 0] == "none"} {
   set url($user) ""
   putcmdlog "\[!4ckc\] #${hand}# churl $user $urlinfo"
   putdcc $idx "\[!4ckc\] ${user}'s url msg has been removed."
   return 0
 }
 set url(${user}) "$urlinfo"
 putcmdlog "\[!4ckc\] #${hand}# churl $user $urlinfo"
 putdcc $idx "\[!4ckc\] ${user}'s Setting for 'url' is now $urlinfo"
}

proc pub_ui {nick uhost hand chan rest} {
 global greet url thebot email CC timezone botnick thepath 
 pub_userinfo $nick $uhost $hand $chan $rest
}
 
proc pub_userinfo {nick uhost hand chan rest} {
 global greet url thebot email CC timezone botnick thepath
 set greetfile "${thebot}.greet"
 set emailfile "${thebot}.email"
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}   
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}

 set user [lindex $rest 0]
 if {$user == ""} {set user $hand}
 puthelp "NOTICE $nick :\[!4ckc\] Information about $user" 
 puthelp "NOTICE $nick :\[!4ckc\] Current Time   : [ctime [unixtime]] $timezone"
 if {[validuser $user] == 0} {
   puthelp "NOTICE $nick :\[!4ckc\] No such user."
   return 0
 }
 if {[onchan $user $chan]} {
   set last "Is currently online."
 } else {
   set last "[ctime [lindex [getuser $user LASTON] 0]]"
 }
 puthelp "NOTICE $nick :\[!4ckc\] Last Online    : $last"
 set emailyes 0;set urlyes 0;set greetyes 0
 if {![info exists email([string tolower $user])]} {set emailyes 1}
 if {![info exists url([string tolower $user])]} {set urlyes 1}
 if {![info exists email([string tolower $user])]} {set greetyes 1}
 if {!$emailyes} {
   if {$email([string tolower $user]) != ""} {  
     puthelp "NOTICE $nick :\[!4ckc\] E-Mail Address : $email([string tolower $user])"
   }
 }
 if {!$urlyes} {
   if {$url([string tolower $user]) != ""} {  
     puthelp "NOTICE $nick :\[!4ckc\] Web Address    : $url([string tolower $user])"
   }
 }
 if {!$greetyes} {
   if {$greet([string tolower $user]) != ""} {  
     puthelp "NOTICE $nick :\[!4ckc\] Greet          : $greet([string tolower $user])"
   }
 }
 if {[getuser $user INFO] != ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Info           : [getuser $user INFO]"
 }
}

proc dcc_ui {hand idx arg} {
 global greet url email thebot CC timezone botnick thepath
 dccsimul $idx ".userinfo $arg"
}

proc dcc_userinfo {hand idx arg} {
 global greet url email thebot CC timezone botnick thepath
 set greetfile "${thebot}.greet"
 set emailfile "${thebot}.email"
 set urlfile "${thebot}.url"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set emailpath "$thepath/$emailfile"} else {set emailpath "$thepath$emailfile"}   
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set urlpath "$thepath/$urlfile"} else {set urlpath "$thepath$urlfile"}
 set user [lindex $arg 0]
 if {$user == ""} {set user $hand}
 putdcc $idx "\[!4ckc\] Information about $user"
 putdcc $idx "\[!4ckc\] Current Time   : [ctime [unixtime]] $timezone"
 if {[validuser $user] == 0} {
   putdcc $idx "\[!4ckc\] No such user."
   return 0
 }
 foreach x [channels] {
   if {[onchan $user $x]} {
     set last "Is currently online in ${x}."
   } else {
     set last "[ctime [lindex [getuser $user LASTON] 0]]" 
   }
 }
 putdcc $idx "\[!4ckc\] Last Online    : $last"
 set emailyes 0;set urlyes 0;set greetyes 0
 if {![info exists url([string tolower $user])]} {set urlyes 1}
 if {![info exists email([string tolower $user])]} {set emailyes 1}
 if {![info exists greet([string tolower $user])]} {set greetyes 1}
 if {!$emailyes} {
   if {$email([string tolower $user]) != ""} {
     putdcc $idx "\[!4ckc\] E-Mail Address : $email([string tolower $user])"
   }
 }
 if {!$urlyes} {
   if {$url([string tolower $user]) != ""} {
     putdcc $idx "\[!4ckc\] Web Address    : $url([string tolower $user])"
   }
 }
 if {!$greetyes} {
   if {$greet([string tolower $user]) != ""} {
     putdcc $idx "\[!4ckc\] Greet          : $greet([string tolower $user])"
   }
 }
 if {[getuser $user INFO] != ""} {
   putdcc $idx "\[!4ckc\] Info           : [getuser $user INFO]"
 }
}

proc join_greet {nick uhost hand chan} {
 global greet botnick thebot thepath
 set greetfile "${thebot}.greet"
 if {[string index $thepath [expr [string length $thepath]-1]] != "/"} {set greetpath "$thepath/$greetfile"} else {set greetpath "$thepath$greetfile"}
 if {[string tolower $nick] != [string tolower $botnick]} {
   if {![info exists greet([string tolower $hand])]} {return 0}
   if {[info exists greet([string tolower $hand])]} {
     if {$greet([string tolower $hand]) != ""} {
       if {[string tolower $nick] != [string tolower $hand]} {
         putserv "PRIVMSG $chan :\[${nick} \(${hand}\)] $greet([string tolower $hand])"
       } else {
         putserv "PRIVMSG $chan :\[${nick}] $greet([string tolower $hand])"
       }
     }
   }
 }
}
## end of dcc/pub cmds for userinfo, greet, chgreet, chemail, email, churl, url

## public cmd seen -- start
proc pub_seen {nick uhost hand chan rest} {
global botnick version CC
set handle [lindex $rest 0]
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}seen <handle>"
   return 0
 }
 if {[validuser $handle] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user in my userlist."
  return 0
 }
 if {[string tolower $handle] == [string tolower $nick]} {
  puthelp "NOTICE $nick :\[!4ckc\] You are here."
  return 0
 }
 if {[onchan $handle $chan] == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] $handle is currently on $chan."
  return 0
 }
 set lastseen [getuser $handle LASTON]
 if {$lastseen == ""} {puthelp "NOTICE $nick :\[!4ckc\] $handle was never here";return 0}
  set lastseen [lindex $lastseen 0]
	set totalyear [expr [unixtime] - $lastseen]
	if {$totalyear < 60} {
		return "$handle has left $chan less than a minute ago."
                return 0
	}
	if {$totalyear >= 31536000} {
		set yearsfull [expr $totalyear/31536000]
		set years [expr int($yearsfull)]
		set yearssub [expr 31536000*$years]
		set totalday [expr $totalyear - $yearssub]
	}
	if {$totalyear < 31536000} {
		set totalday $totalyear
		set years 0
	}
	if {$totalday >= 86400} {
		set daysfull [expr $totalday/86400]
		set days [expr int($daysfull)]
		set dayssub [expr 86400*$days]
		set totalhour [expr $totalday - $dayssub]
	}
	if {$totalday < 86400} {
		set totalhour $totalday
		set days 0
	}
	if {$totalhour >= 3600} {
		set hoursfull [expr $totalhour/3600]
		set hours [expr int($hoursfull)]
		set hourssub [expr 3600*$hours]
		set totalmin [expr $totalhour - $hourssub]
	}
	if {$totalhour < 3600} {
		set totalmin $totalhour
		set hours 0
	}
	if {$totalmin >= 60} {
		set minsfull [expr $totalmin/60]
		set mins [expr int($minsfull)]
	}
	if {$totalmin < 60} {
		set mins 0
	}
	if {$years < 1} {set yearstext ""} elseif {$years == 1} {set yearstext "$years year, "} {set yearstext "$years years, "}

	if {$days < 1} {set daystext ""} elseif {$days == 1} {set daystext "$days day, "} {set daystext "$days days, "}

	if {$hours < 1} {set hourstext ""} elseif {$hours == 1} {set hourstext "$hours hour, "} {set hourstext "$hours hours, "}

	if {$mins < 1} {set minstext ""} elseif {$mins == 1} {set minstext "$mins minute"} {set minstext "$mins minutes"}

	set output $yearstext$daystext$hourstext$minstext
	set output [string trimright $output ", "]
	puthelp "NOTICE $nick :\[!4ckc\] $nick, I last saw $handle $output ago"
}
## pub cmd seen -- stop

## msg cmd auth -- start
proc msg_auth {nick uhost hand rest} {
 global botnick
 set pw [lindex $rest 0]
 if {$pw == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: /msg $botnick auth <password>"
  return 0
 }
 if {[matchattr $hand Q] == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] You are already Authenticated."
  return 0
 }
 set ch [passwdok $hand ""]
 if {$ch == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] No password set. Type /msg $botnick pass <password>" 
  return 0
 }
 if {[passwdok $hand $pw] == 1} {
  chattr $hand +Q
  putcmdlog "\[!4ckc\] #$hand# auth ..."
  puthelp "NOTICE $nick :\[!4ckc\] Authentication successful!"
 }
 if {[passwdok $hand $pw] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] Authentication failed!"
 }
}
## msg cmd auth -- stop

## msg cmd deauth -- start
proc msg_deauth {nick uhost hand rest} {
 global botnick
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: /msg $botnick auth <password>"
  return 0
 }
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] You never authenticated."
  return 0
 }
 if {[passwdok $hand $rest] == 1} {
  chattr $hand -Q
  putcmdlog "\[!4ckc\] #$hand# deauth ..."
  puthelp "NOTICE $nick :\[!4ckc\] DeAuthentication successful!"
 }
 if {[passwdok $hand $rest] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] DeAuthentication failed!"
 }
}
## msg cmd deauth -- stop

## sign cmd deauth -- start
proc sign_deauth {nick uhost hand chan rest} { 
 if {[matchattr $hand Q] == 1} {
  chattr $hand -Q
  putlog "\[!4ckc\] $nick has signed off, automatic deauthentication."
 }
 if {[matchattr $hand Q] == 0} {
  return 0
 }
}
## sign cmd deauth -- stop

## part cmd deauth -- start
proc part_deauth {nick uhost hand chan} {
  if {[matchattr $hand Q] == 1} {
  chattr $hand -Q
  putlog "\[!4ckc\] $nick has parted $chan, automatic deauthentication."
 }
 if {[matchattr $hand Q] == 0} {
  return 0
 }
}
## part cmd deauth -- stop

## public cmd about -- start
proc pub_about {nick uhost hand chan rest} {
 global vers
 putcmdlog "\[!4ckc\] #$hand# about ckC.tcl"
 puthelp "NOTICE $nick :\[!4ckc\] ckC.tcl $vers by cokkie <b@ndon.tv>"
 puthelp "NOTICE $nick :\[!4ckc\] Modified Friday, July 26, 2002 8:11:27 AM"
 puthelp "NOTICE $nick :\[!4ckc\] Copyright © 2002 cokkieiezZ® CrW."
}
## public cmd about -- stop

## dcc cmd about -- start
proc dcc_about {hand idx args} {
 global vers
 putcmdlog "\[!4ckc\] #$hand# about ckC.tcl"
 putdcc $idx "\[!4ckc\] ckC.tcl $vers by cokkie <b@ndon.tv>"
 putdcc $idx "\[!4ckc\] Modified Friday, July 26, 2002 8:11:27 AM"
 putdcc $idx "\[!4ckc\] Copyright © 2002 cokkieiezZ® CrW."
}
## dcc cmd about - stop

## public cmd version -- start
proc pub_version {nick uhost hand chan rest} {
 putcmdlog "\[!4ckc\] #$hand# version"
 global vers
 puthelp "NOTICE $nick :\[!4ckc\] ckC.tcl $vers ©2002 <b@ndon.tv>"
}
## public cmd version -- stop

## dcc cmd version -- start
proc dcc_version {hand idx args} {
 global vers
 putcmdlog "\[!4ckc\] #$hand# version"
 putdcc $idx "\[!4ckc\] ckC.tcl $vers ©2002 <b@ndon.tv>"
}
## dcc cmd version -- stop

## public cmd help -- start
proc pub_help {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] help is only available via dcc chat."
} 
## public cmd help -- stop

## public cmd ckChelp -- start
proc pub_ckChelp {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] ckChelp is only available via dcc chat."
}
## public cmd ckChelp -- stop

## dcc cmd ckChelp -- start
proc dcc_ckChelp {hand idx args} {
 global botnick version vers
 set tn "\[!4ckc\]"
 set args [lindex $args 0]
 global CC NC
 if {$args == ""} {
  putdcc $idx "$tn ck4C.tcl ${vers} by cokkie <b@ndon.tv>"
  putdcc $idx "$tn PUBLIC COMMANDS for $botnick, eggdrop v[lindex $version 0]"
  putdcc $idx "$tn MY DCC CMD CHAR IS: '.' MY PUBLIC CMD CHAR IS: '${CC}'"
  putdcc $idx "$tn"
  putdcc $idx "$tn For PARTYLINE users"
  putdcc $idx "$tn   ping         access        version      time"
  putdcc $idx "$tn   pong         rollcall      about        seen"
  if {[matchattr $hand o] == 1} {
   putdcc $idx "$tn For channel OPS"
   putdcc $idx "$tn   who          +ban         say      away(disabled)  quit"
   putdcc $idx "$tn   whom         -ban         msg      back(disabled)  servers"
   putdcc $idx "$tn   whois        ban          act          note        channel"
   putdcc $idx "$tn   match        bans         me           files       kick"
   putdcc $idx "$tn   bots         addlog       newpass      su          k"    
   putdcc $idx "$tn   bottree      op           invite       console     kickban"
   putdcc $idx "$tn   notes        deop         nick         email       kb"
   putdcc $idx "$tn   echo         up           stick        unstick     info"
   putdcc $idx "$tn   trace        down         filestats    page        strip"
   putdcc $idx "$tn   topic        fixcodes     userlist     flagnote    comment"
   putdcc $idx "$tn   chat         botinfo      motd         modes       info"
   putdcc $idx "$tn   wi           ui"
  }
  if {[matchattr $hand m] == 1} {
   putdcc $idx "$tn For MASTERS"
   putdcc $idx "$tn   adduser      +host        chattr       save        reload"
   putdcc $idx "$tn   deluser      -host        status       boot        chaninfo"
   putdcc $idx "$tn   +bot         botattr      chnick       chpass      chinfo"
   putdcc $idx "$tn   -bot         link         unlink       chaddr      chcomment"
   putdcc $idx "$tn   +user        set          jump         dump        +ignores"
   putdcc $idx "$tn   -user        flush        dccstat      debug       -ignores"
   putdcc $idx "$tn   join         aop          +chrec       reset       ignores"
   putdcc $idx "$tn   part         raop         -chrec       rehash      restart"   
   putdcc $idx "$tn   massop       mop          massunban    boot        banner"
   putdcc $idx "$tn   massdeop     mdeop        mub          assoc       relay"
   putdcc $idx "$tn   botattr"
  }
  if {[matchattr $hand n] == 1} {
   putdcc $idx "$tn For OWNERS"
   putdcc $idx "$tn   chanset      chansave     chanload     simul"
   putdcc $idx "$tn   +chan        -chan        die          botnick"
   putdcc $idx "$tn   modules      loadmodule   unloadmodule"
  }
  putdcc $idx "$tn All of these commands are available in the channel and in dcc chat."
  return 0
 }
 if {[string tolower $args] == "kb"} {
   putcmdlog "$tn #$hand# ckChelp kb"
   putdcc $idx "$tn \#\#\# kb"
   putdcc $idx "$tn kickbans a user off of the channel."
   return 0
 }
 if {[string tolower $args] == "chcomment"} {
   putcmdlog "$tn #$hand# ckChelp chcomment"
   putdcc $idx "$tn \#\#\# chcomment"
   putdcc $idx "$tn Allows masters/owners to set users comment line."
   return 0
 }
 if {[string tolower $args] == "seen"} {
   putcmdlog "$tn #$hand# ckChelp seen"
   putdcc $idx "$tn \#\#\# seen"
   putdcc $idx "$tn Gives the last time a user was on the channel."
   return 0
 }
 if {[string tolower $args] == "time"} {
   putcmdlog "$tn #$hand# ckChelp time"
   putdcc $idx "$tn \#\#\# time"
   putdcc $idx "$tn Gives the user the current time according to the bots location."
   return 0
 }
 if {[string tolower $args] == "mdeop"} {
   putcmdlog "$tn #$hand# ckChelp mdeop"
   putdcc $idx "$tn \#\#\#  mdeop"
   putdcc $idx "$tn MassDeops all non-ops on the channel."
   return 0
 }
 if {[string tolower $args] == "mop"} {
   putcmdlog "$tn #$hand# ckChelp mop"
   putdcc $idx "$tn \#\#\#  mop"
   putdcc $idx "$tn MassOps all non-ops on the channel."
   return 0
 }
 if {[string tolower $args] == "massdeop"} {
   putcmdlog "$tn #$hand# ckChelp massdeop"
   putdcc $idx "$tn \#\#\#  massdeop"
   putdcc $idx "$tn MassDeops all non-ops on the channel."
   return 0
 }
 if {[string tolower $args] == "massop"} {
   putcmdlog "$tn #$hand# ckChelp massop"
   putdcc $idx "$tn \#\#\#  massop"
   putdcc $idx "$tn MassOps all non-ops on the channel."
   return 0
 }
 if {[string tolower $args] == "mub"} {
   putcmdlog "$tn #$hand# ckChelp mub"
   putdcc $idx "$tn \#\#\#  mub"
   putdcc $idx "$tn Removes all bans currently set on the channel."
   return 0
 }
 if {[string tolower $args] == "massuban"} {
   putcmdlog "$tn #$hand# ckChelp massuban"
   putdcc $idx "$tn \#\#\#  massunban"
   putdcc $idx "$tn Removes all bans currently set on the channel."
   return 0
 }
 if {[string tolower $args] == "about"} {
   putcmdlog "$tn #$hand# ckChelp about"
   putdcc $idx "$tn \#\#\#  about"
   putdcc $idx "$tn About ckC.tcl"
   return 0
 }
 if {[string tolower $args] == "version"} {
   putcmdlog "$tn #$hand# ckChelp version"
   putdcc $idx "$tn \#\#\#  version"
   putdcc $idx "$tn ckC.tcl verion"
   return 0
 }
 if {[string tolower $args] == "back"} {
   putcmdlog "$tn #$hand# ckChelp back"
   putdcc $idx "$tn \#\#\#  back"
   putdcc $idx "$tn Back states that your bot is back after being away"
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "down"} {
   putcmdlog "$tn #$hand# ckChelp down"
   putdcc $idx "$tn \#\#\#  down"
   putdcc $idx "$tn bot deops you on the channel."
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "up"} {
   putcmdlog "$tn #$hand# ckChelp up"
   putdcc $idx "$tn \#\#\#  up"
   putdcc $idx "$tn bot ops on the channel."
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "userlist"} {
   putcmdlog "$tn #$hand# ckChelp userlist"
   putdcc $idx "$tn \#\#\#  userlist"
   putdcc $idx "$tn \#\#\#  userlist <flags>"
   putdcc $idx "$tn Lists all users currently on the bot"
   return 0
 } 
 if {[string tolower $args] == "ping"} {
   putcmdlog "$tn #$hand# ckChelp ping"
   putdcc $idx "$tn \#\#\#  ping"
   putdcc $idx "$tn Shows bot response time."
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "pong"} {
   putdcc $idx "$tn \#\#\#  pong"
   putcmdlog "$tn #$hand# ckChelp pong"
   putdcc $idx "$tn Shows bot response time"
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "access"} {
   putcmdlog "$tn #$hand# ckChelp access"
   putdcc $idx "$tn \#\#\#  acess"
   putdcc $idx "$tn \#\#\#  access <nick>"
   putdcc $idx "$tn shows user flags currently enabled."
   return 0
 }
 if {[string tolower $args] == "rollcall"} {
   putcmdlog "$tn #$hand# ckChelp rollcall"
   putdcc $idx "$tn \#\#\#  rollcall"
   putdcc $idx "$tn shows bots command char \& shows current bot version."
   putdcc $idx "$tn (only available via PUBLIC CMD)"
   return 0
 }
 if {[string tolower $args] == "aop"} {
   putcmdlog "$tn #$hand# ckChelp aop"
   putdcc $idx "$tn \#\#\#  aop <nick>"
   putdcc $idx "$tn aop Auto-op's a user when they enter a channel."
   return 0
 }
 if {[string tolower $args] == "raop"} {
   putcmdlog "$tn #$hand# ckChelp raop"
   putdcc $idx "$tn \#\#\#  raop <nick>"
   putdcc $idx "$tn Removes user's auto-op privilege."
   return 0
 }
 if {[string tolower $args] == "botnick"} {
   putcmdlog "$tn #$hand# ckChelp botnick"
   putdcc $idx "$tn \#\#\#  botnick <new botnick>"
   putdcc $idx "$tn changes the bots irc nick - \037NOT\037 botnet nick."
   return 0
 }
 if {[string tolower $args] == "join"} {
   putcmdlog "$tn #$hand# ckChelp join"
   putdcc $idx "$tn \#\#\#  join <#channel>"
   putdcc $idx "$tn Forces the bot to join a channel"
   return 0
 }
 if {[string tolower $args] == "part"} {
   putcmdlog "$tn #$hand# ckChelp part"
   putdcc $idx "$tn \#\#\#  part <#channel>"
   putdcc $idx "$tn Forces a bot to leave a channel."
   return 0
 }
 if {[string tolower $args] == "modes"} {
   putcmdlog "$tn #$hand# ckChelp modes"
   putdcc $idx "$tn \#\#\#  modes"
   putdcc $idx "$tn Lets you auto set channel modes."
   putdcc $idx "$tn Current modes are t,n,i,p,s,m,l,k,v"
   putdcc $idx "$tn Example: ${CC}+v lamest, ${CC}+k private, +t"
   return 0
 }
 if {[string tolower $args] == "flagnote"} {
   putcmdlog "$tn #$hand# ckChelp flagnote"
   putdcc $idx "$tn \#\#\#  flagnote <flag>"
   putdcc $idx "$tn flagnote Sends a message to all users with a certain flag"
   return 0
 }
 if {$args != ""} {
  dccsimul $idx ".help $args"
 }
}
## dcc cmd ckChelp -- stop

## dcc cmd wi -- start
proc dcc_wi {hand idx arg} {
 global botnick
 if {$arg == ""} {
   putdcc $idx "\[!4ckc\] Usage: whois <handle>"
   return 0
 }
 dccsimul $idx ".whois $arg"
}
## dcc cmd wi -- stop

## public cmd massunban -- start
proc pub_massunban {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 putserv "MODE $chan +b"
}
## public cmd massunban -- stop

## dcc cmd mub -- start
proc dcc_mub {hand idx args} {
set channel [lindex $args 0]
 if {[validchan $channel]} {
  putserv "MODE $channel +b"
 } else {
  putdcc $idx "\[!4ckc\] Usage: mub <#channel>"
 }
}
## dcc cmd mub -- stop

## dcc cmd massunban -- start
proc dcc_massunban {hand idx args} {
set channel [lindex $args 0]
 if {[validchan $channel]} {
  putserv "MODE $channel +b"
 } else {
  putdcc $idx "\[!4ckc\] Usage: massunban <#channel>"
 }
}
## dcc cmd massunban -- stop

## public cmd dccstat -- start
proc pub_dccstat {nick uhost hand chan rest} {
 set socksp "    ";set usersp "         ";set hostsp "                 "
   puthelp "NOTICE $nick :\[!4ckc\] SOCK NICK      HOST              TYPE"
   puthelp "NOTICE $nick :\[!4ckc\] ---- --------- ----------------- ----"
 foreach info [dcclist] { 
#   set info [lsort -integer [lindex $info 0]] [lrange $info 1 end]
   set sock [lindex $info 0]
   set user [lindex $info 1]
   set host [lindex $info 2]
   set type [lindex $info 3]
   if {[string length $sock] < 4} {
     set socksize [expr [string length $socksp]-[string length $sock]]
     set newsocksp [string range $socksp 0 [expr $socksize - 1]]
     set sock "${sock}${newsocksp}"
   }
   if {[string length $user] < 9} {
     set usersize [expr [string length $usersp]-[string length $user]]
     set newusersp [string range $usersp 0 [expr $usersize - 1]]
     set user "${user}${newusersp}"
   }
   if {[string length $user] > 9} {set user [string range $user 0 8}  
   if {[string length $host] < 17} {
     set hostsize [expr [string length $hostsp]-[string length $host]]
     set newhostsp [string range $hostsp 0 [expr $hostsize - 1]]
     set host "${host}${newhostsp}"
   }
   if {[string length $host] > 17} {
     set hostsize [expr [string length $host] -17]
     set host [string range $host $hostsize end]
   }
   if {$type == "TELNET"} {set type "lstn"}
   set type [string range [string tolower $type] 0 3]
   puthelp "NOTICE $nick :\[!4ckc\] $sock $user $host $type"
   putcmdlog "\[!4ckc\] #$hand# dccstat"
 }
}
## public cmd dccstat -- stop

## public cmd -chrec -- start
proc pub_-chrec {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] -chrec is only available via dcc chat."
}
## public cmd -chrec -- stop

## public cmd +chrec -- start
proc pub_+chrec {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] +chrec is only available via dcc chat."
}
## public cmd +chrec -- stop

## public cmd debug -- start
proc pub_debug {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] debug is only available via dcc chat."
}
## public cmd debug -- stop

## public cmd dump -- start
proc pub_dump {nick uhost hand chan rest} {
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 putserv "$rest"
 puthelp "NOTICE $nick :Dumped Information to Server"
 putcmdlog "\[!4ckc\] #$hand# dump $rest"
}
## public cmd dump -- stop

## public cmd unloadmodule -- start
proc pub_unloadmodule {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] unloadmodule is only available via dcc chat."
}
## public cmd unloadmodule -- stop

## public cmd loadmodule -- start
proc pub_loadmodule {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] loadmodule is only available via dcc chat."
}
## public cmd loadmodule -- stop

## public cmd modules -- start
proc pub_modules {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] modules is only available via dcc chat."
}
## public cmd modules -- stop

## public cmd simul -- start
proc pub_simul {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] simul is only available via dcc chat."
}
## public cmd simul -- stop

## public cmd botattr -- start
proc pub_botattr {nick uhost hand channel rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set chan [lindex $rest 2]
 set bot [lindex $rest 0]
 set bflags [lindex $rest 1]
 if {($bot == "") || ($bflags == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}botattr <bot> <flags> \[channel\]"
  return 0
 }
 if {[validuser $bot] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such bot!"
  return 0
 }
 if {[matchattr $bot b] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $bot is not a bot"
  return 0
 }
 if {$chan != ""} {
  if {[validchan $chan]} {
   putcmdlog "\[!4ckc\] #$hand# botattr $bot $bflags $chan"
   if {[string trim $bflags abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-] == "|"} {
    botattr $bot $bflags $chan
   } else {
    botattr $bot |$bflags $chan
   }
   set chanflags [chattr $bot | $chan]
   set chanflags [string trimleft "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-"]
   set chanflags [string trim $chanflags "|"] 
   set globalflags [chattr $ownern]
   puthelp "NOTICE $nick :\[!4ckc\] botattr $bot \[${bflags}\] $chan"
   puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $bot are \[${globalflags}\]"   
   if {$chanflags != "-"} {
    puthelp "NOTICE $nick :\[!4ckc\] Channel \"${chan}\" Flags for $bot are \[${chanflags}\]"
   } else {
    puthelp "NOTICE $nick :\[!4ckc\] $bot does not have any channel specific flags."
   }
  } else {
   puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
  }
 } else {
  putcmdlog "\[!4ckc\] #$hand# botattr $bot $bflags"
  botattr $bot $bflags
  set bflags [getuser $bot BOTFL]
  puthelp "NOTICE $nick :\[!4ckc\] botattr $bot \[${bflags}\]"
  puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $bot are now \[${bflags}\]"
 }
}
## public cmd -chan -- stop
proc pub_-chan {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set channel [lindex $rest 0]
 if {$channel == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+chan <#channel>"
  return 0
 }
 if {[string first # $channel]!=0} {
  set channel "#$channel"
 }
 if {[validchan $channel]} {
  putcmdlog "\[!4ckc\] #$hand# -chan $channel"
  channel remove $channel
  puthelp "NOTICE $nick :\[!4ckc\] Channel $channel removed from the bot."
  puthelp "NOTICE $nick :\[!4ckc\] This includes any channel specific bans you set."
 } else {
  puthelp "NOTICE $nick :\[!4ckc\] That channel doesnt exist!"
 }
}
## public cmd -chan -- stop

## public cmd +chan -- start
proc pub_+chan {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set channel [lindex $rest 0]
 set options [lindex $rest 1]
 if {$channel == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+chan <#channel> \[option-list\]"
  return 0
 }
 if {[validchan $channel]} {
  puthelp "NOTICE $nick :\[!4ckc\] Your already in $channel"
 } else {
  if {[string first # $channel]!=0} {
   set channel "#$channel"
  }
 putcmdlog "\[!4ckc\] #$hand# +chan $channel $options"
 channel add $channel $options
 }
}
## public cmd +chan -- stop

## public cmd binds -- start
proc pub_binds {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] binds is only available via dcc chat."
}
## public cmd binds -- stop

## public cmd reset -- start
proc pub_reset {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] reset is only available via dcc chat."
}
## public cmd reset -- stop

## public cmd banner -- start
proc pub_banner {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] banner is only available via dcc chat."
}
## public cmd banner -- stop

## public cmd resetbans -- start
proc pub_resetbans {nick uhost hand channel rest} {
 global CC botnick
 set chan $rest
 if {$chan != ""} {
  if {[validchan $chan]} {
   foreach ban [banlist $chan] {
    pushmode $chan +b [lindex $ban 0]
   }
   putserv "MODE $chan +b"
   putcmdlog "\[!4ckc\] #$hand# (${chan}) resetbans"
   puthelp "NOTICE $nick :\[!4ckc\] Resetting bans on $chan..."
   return 0
  } else {
   puthelp "NOTICE $nick :\[!4ckc\] $chan is an invalid channel."
   return 0
  }
 }
 if {$chan == ""} {
  foreach ban [banlist] {
   foreach i [channels] {
    pushmode $i +b [lindex $ban 0]
    puthelp "NOTICE $nick :\[!4ckc\] Resetting bans on $i"
   }
  }
  foreach x [channels] {
   putserv "MODE $x +b"
  }
  putcmdlog "\[!4ckc\] #$hand# resetbans"
 }
}
## public cmd resetbans -- stop

## public cmd flush -- start
proc pub_flush {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] flush is only available via dcc chat."
}
## public cmd flush -- stop

## public cmd set -- start
proc pub_set {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] set is only available via dcc chat."
}
## public cmd set -- stop

## public cmd chanload -- start
proc pub_chanload {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 putcmdlog "\[!4ckc\] #$hand# chanload"
 loadchannels
 puthelp "NOTICE $nick :\[!4ckc\] Reloading all dynamic channel settings."
}
## public cmd chanload -- stop

## public cmd chansave -- start
proc pub_chansave {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 putcmdlog "\[!4ckc\] #$hand# chansave"
 puthelp "NOTICE $nick :\[!4ckc\] Saving all dynamic channel settings."
 savechannels
 puthelp "NOTICE $nick :\[!4ckc\] Writing channel file ..."
}
## public cmd chansave -- stop

## public cmd chanset -- start
proc pub_chanset {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set channel [lindex $rest 0]
 set options [lindex $rest 1]
 if {($channel == "") || ($options == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chanset #<channel> <option...>"
  return 0
 }
 if {[validchan $channel]} {
  putcmdlog "\[!4ckc\] #$hand# chanset $channel $options"
  channel set $channel $options
  puthelp "NOTICE $nick :\[!4ckc\] Successfully set modes \{ $options \} on $channel"
  puthelp "NOTICE $nick :\[!4ckc\] Changes to $channel are not permanent."
 } else {
  puthelp "NOTICE $nick :\[!4ckc\] No such channel."
 }
}
## public cmd chanset -- stop

## pubic cmd restart -- start
proc pub_restart {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
  utimer 1 restart
  putcmdlog "\[!4ckc\] #${hand}# restart"
  puthelp "NOTICE $nick :\[!4ckc\] Writing user file... Writing channel file ... Restarting ..."
}
## public cmd restart -- stop

## pubic cmd rehash -- start
proc pub_rehash {nick uhost hand chan rest} {
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
  utimer 1 rehash
  putcmdlog "\[!4ckc\] #${hand}# rehash"
  puthelp "NOTICE $nick :\[!4ckc\] Writing user & channel file... Rehashing.. Userfile loaded, unpacking..."
}
## public cmd rehash -- stop

## public cmd relay -- start
proc pub_relay {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] relay is only available via dcc chat."
}
## public cmd relay -- stop

## public cmd chaninfo -- start
proc pub_chaninfo {nick uhost hand chan rest} {
 global CC
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chaninfo <#channel>"
  return 0
 }
 if {[validchan $rest]} {
  set em [lindex [channel info $rest] 0]
  putcmdlog "\[!4ckc\] #$hand# chaninfo $rest"
  puthelp "NOTICE $nick :\[!4ckc\] Settings for static channel $rest"
  set em [lindex [channel info $rest] 0]
  puthelp "NOTICE $nick :\[!4ckc\] Protect modes (chanmode): $em"
 if {[lindex [channel info $rest] 1] == "0"} {
  puthelp "NOTICE $nick :\[!4ckc\] Idle Kick after (idle-kick): DONT!"
 } else {
  puthelp "NOTICE $nick :\[!4ckc\] Idle Kick after (idle-kick): [lindex [channel info $rest] 1] min"
 } 
  puthelp "NOTICE $nick :\[!4ckc\] Other modes:" 
  puthelp "NOTICE $nick :\[!4ckc\]      [lindex [channel info $rest] 12]  [lindex [channel info $rest] 13]  [lindex [channel info $rest] 14]  [lindex [channel info $rest] 15]"
  puthelp "NOTICE $nick :\[!4ckc\]      [lindex [channel info $rest] 16]     [lindex [channel info $rest] 17]        [lindex [channel info $rest] 18]        [lindex [channel info $rest] 19]"
  puthelp "NOTICE $nick :\[!4ckc\]      [lindex [channel info $rest] 20]  [lindex [channel info $rest] 21]  [lindex [channel info $rest] 22]      [lindex [channel info $rest] 23]"
  puthelp "NOTICE $nick :\[!4ckc\]      [lindex [channel info $rest] 24]      [lindex [channel info $rest] 25]   [lindex [channel info $rest] 26]"
  set ichan [lindex [channel info $rest] 7]
  set ictcp [lindex [channel info $rest] 8]
  set ijoin [lindex [channel info $rest] 9]
  set ikick [lindex [channel info $rest] 10]
  set ideop [lindex [channel info $rest] 11]
  puthelp "NOTICE $nick :\[!4ckc\] flood settings: chan: $ichan  ctcp: $ictcp  join: $ijoin  kick: $ikick  deop: $ideop"    
 } else { 
  puthelp "NOTICE $nick :\[!4ckc\] No such channel defined."
 }
}
## public cmd chaninfo -- stop

## public cmd status -- start
proc pub_status {nick uhost hand chan rest} {
 global botnick CC server max-file-users max-filesize admin chanmode version uptime timezone files-path incoming-path
 putcmdlog "\[!4ckc\] #$hand# status"
 set vers [lindex $version 0]
 set users [countusers]
 regsub -all " " [channels] ", " chans
 puthelp "NOTICE $nick :\[!4ckc\] I am $botnick, running eggdrop v${vers}: $users users"
 puthelp "NOTICE $nick :\[!4ckc\] Running on [exec uname -sr]"
 puthelp "NOTICE $nick :\[!4ckc\] Server $server"
	set totalyear [expr [unixtime] - $uptime]
	if {$totalyear >= 31536000} {
		set yearsfull [expr $totalyear/31536000]
		set years [expr int($yearsfull)]
		set yearssub [expr 31536000*$years]
		set totalday [expr $totalyear - $yearssub]
	}
	if {$totalyear < 31536000} {
		set totalday $totalyear
		set years 0
	}
	if {$totalday >= 86400} {
		set daysfull [expr $totalday/86400]
		set days [expr int($daysfull)]
		set dayssub [expr 86400*$days]
		set totalhour [expr $totalday - $dayssub]
	}
	if {$totalday < 86400} {
		set totalhour $totalday
		set days 0
	}
	if {$totalhour >= 3600} {
		set hoursfull [expr $totalhour/3600]
		set hours [expr int($hoursfull)]
		set hourssub [expr 3600*$hours]
		set totalmin [expr $totalhour - $hourssub]
	}
	if {$totalhour < 3600} {
		set totalmin $totalhour
		set hours 0
	}
	if {$totalmin >= 60} {
		set minsfull [expr $totalmin/60]
		set mins [expr int($minsfull)]
	}
	if {$totalmin < 60} {
		set mins 0
	}
	if {$years < 1} {set yearstext ""} elseif {$years == 1} {set yearstext "$years year, "} {set yearstext "$years years, "}

	if {$days < 1} {set daystext ""} elseif {$days == 1} {set daystext "$days day, "} {set daystext "$days days, "}

	if {$hours < 1} {set hourstext ""} elseif {$hours == 1} {set hourstext "$hours hour, "} {set hourstext "$hours hours, "}

	if {$mins < 1} {set minstext ""} elseif {$mins == 1} {set minstext "$mins minute"} {set minstext "$mins minutes"}

        if {[string length $mins] == 1} {set mins "0${mins}"}
        if {[string length $hours] == 1} {set hours "0${hours}"}
	set output "${yearstext}${daystext}${hours}:${mins}"
	set output [string trimright $output ", "]
 set cpu [lindex [exec ps ux [exec cat pid.${botnick}]] 13]
 puthelp "NOTICE $nick :\[!4ckc\] Online for $output  (background)  CPU $cpu"  
 puthelp "NOTICE $nick :\[!4ckc\] Admin: $admin"
 puthelp "NOTICE $nick :\[!4ckc\]     DCC file path: ${files-path}"
 puthelp "NOTICE $nick :\[!4ckc\]         incoming: ${incoming-path}"
 puthelp "NOTICE $nick :\[!4ckc\]        max users is ${max-file-users}"
 puthelp "NOTICE $nick :\[!4ckc\]     DCC max file size: ${max-filesize}k"
 puthelp "NOTICE $nick :\[!4ckc\] Channels: $chans"
 puthelp "NOTICE $nick :\[!4ckc\] Server $server" 
 foreach x [channels] {
  set ch [llength [chanlist $x]]
  set em [lindex [channel info $x] 0]
  puthelp "NOTICE $nick :\[!4ckc\] $x :  $ch members, enforcing \"${em}\""
 }
}
## public cmd status -- stop

## public cmd boot -- start
proc pub_boot {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] Access denied, people should know who is booting them."
}
## public cmd boot -- stop

## public cmd assoc -- start
proc pub_assoc {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] assoc is only available via dcc chat."
}
## public cmd assoc -- stop

## public cmd chbotattr -- start
proc pub_chbotattr {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] See botattr command."
}
## public cmd chbotattr -- stop

## public cmd unlink -- start
proc pub_unlink {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}unlink <bot>"
  return 0
 }
 if {([validuser $rest] == 0) || ([matchattr $rest b] == 0)} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not in my userlist as a bot."
  return 0
 }
 if {[lsearch -exact [string tolower [bots]] [string tolower $rest]] == -1} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not linked on the botnet."
  return 0
 }
 if {[lsearch -exact [string tolower [bots]] [string tolower $rest]] > -1} {
  putcmdlog "\[!4ckc\] #$hand# unlink $rest"
  unlink $rest
  puthelp "NOTICE $nick :\[!4ckc\] Breaking link with $rest"
 }
}
## public cmd unlink -- stop

## public cmd link -- start
proc pub_link {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}link <bot>"
  return 0
 }
 if {([validuser $rest] == 0) || ([matchattr $rest b] == 0)} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not in my userlist as a bot."
  return 0
 }
 if {[lsearch -exact [string tolower [bots]] [string tolower $rest]] > -1} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is already linked on the botnet."
  return 0
 }
 if {[lsearch -exact [string tolower [bots]] [string tolower $rest]] == -1} {
  putcmdlog "\[!4ckc\] #$hand# link $rest"
  link $rest
  puthelp "NOTICE $nick :\[!4ckc\] Linking to $rest at [getaddr $rest]"
 }
}
## public cmd link -- end

## public cmd su -- start
proc pub_su {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] su is only available via dcc chat."
}
## public cmd strip -- start
proc pub_strip {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] strip is only available via dcc chat."
}
## public cmd strip -- stop

## public cmd page -- start
proc pub_page {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] page is only available via dcc chat."
}
## public cmd page -- stop

## public cmd filestats -- start
proc pub_filestats {nick uhost hand chan rest} {
 global CC
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}filestats <handle>"
  return 0
 }
 if {[validuser $rest] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not in my userlist."
  return 0
 }
 if {[validuser $rest] == 1} {
  set uploads [getuploads $rest]
  set nul [lindex [getuploads $rest] 0]
  set tul [lindex [getuploads $rest] 1]
  set ndl [lindex [getdnloads $rest] 0]
  set tdl [lindex [getdnloads $rest] 1] 
  putcmdlog "\[!4ckc\] #$hand# filestats $rest"
  if {$tul >9} {set main "   "} else {set main "    "}
  if {$tul >99} {set main "  "} else {set main "    "}
  if {$tdl >9} {set main "   "} else {set main "    "}
  if {$tdl >99} {set main "  "} else {set main "    "}
  if {$nul >9} {set s "     "} else {set s "      "}
  if {$nul >99} {set s "    "} else {set s "      "}
  if {$nul >999} {set s "   "} else {set s "      "}
  if {$nul >9999} {set s "  "} else {set s "      "}
  if {$ndl >9} {set s "     "} else {set s "      "}
  if {$ndl >99} {set s "    "} else {set s "      "}
  if {$ndl >999} {set s "   "} else {set s "      "}
  if {$ndl >9999} {set s "  "} else {set s "      "}
 puthelp "NOTICE $nick :\[!4ckc\] \037${rest}'s filestats\037"
 puthelp "NOTICE $nick :\[!4ckc\]   uploads:${main}${nul} /${s}${tul}k"
 puthelp "NOTICE $nick :\[!4ckc\] downloads:${main}${ndl} /${s}${tdl}k"
 }
}
## public cmd filestats -- stop

## public cmd unstick -- start
proc pub_unstick {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] unstick is only available via dcc chat."
}
## public cmd unstick -- stop

## public cmd stick -- start
proc pub_stick {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] stick is only available via dcc chat."
}
## public cmd stick -- stop

## public cmd fixcodes -- start
proc pub_fixcodes {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] fixcodes is only available via dcc chat."
}
## public cmd fixcodes -- stop

## public cmd trace -- start
proc pub_trace {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] trace is only available via dcc chat."
}
## public cmd trace -- stop

## public cmd botinfo -- start
proc pub_botinfo {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] botinfo is only available via dcc chat."
}
## public cmd botinfo -- stop

## public cmd chaddr -- start
proc pub_chaddr {nick uhost hand chan rest} {
global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate. /msg $botnick auth <password>"
  return 0
 }
 set botname [lindex $rest 0]
 set changes [lindex $rest 1]
 if {($botname == "") || ($changes == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chaddr <bot> <address:port#\[relay-port#\]>"
  return 0
 }
 set porttest [string trim $changes "abcdefghijklmnopqrstuvwxyx."]
 set porttest [string trim $porttest ":"]
 if {$porttest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chaddr <bot> <address:port#\[relay-port#\]>"
  return 0
 }
 if {[validuser $botname] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] There is no such bot in the userlist." 
  return 0
 }
 if {[matchattr $botname b] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is not a bot."
  return 0
 }
 botattr $botname $changes
 set oldaddy [getuser $botname BOTADDR]
 set oldaddy [lindex $oldaddy 0]:[lindex $oldaddy 1]/[lindex $oldaddy 2]
 puthelp "NOTICE $nick :\[!4ckc\] Changed ${botname}'s Address from \[${oldaddy}\] to \[$changes\]"
}
## public cmd chaddr -- stop

## public cmd rollcall -- start

proc pub_rollcall {nick uhost hand chan rest} {
 global CC botnick version
 set botvers [lindex $version 0]
 set cmdchar $CC
 putlog "\[!4ckc\] <<$nick>> !$hand! rollcall"
 puthelp "NOTICE $nick :\[!4ckc\] I am ${botnick}, running eggdrop v${botvers}"
 puthelp "NOTICE $nick :\[!4ckc\] My Command Charactor is \[${CC}\]"
}
## public cmd rollcall -- stop

## dcc cmd access -- start
proc dcc_access {hand idx rest} {
 global CC
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who == ""} {
  putdcc $idx "\[!4ckc\] Usage: .access <nick | me>"
  return 0
 }
 if {$who == "me"} {
  if {$chan != ""} { 
   if {[validchan $chan]} {
    set swho $hand
    set cflags [chattr $swho | $chan]
    set nflags [string trimleft $cflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set cfflags [string trim $nflags "|"]
    putlog "\[!4ckc\] !$hand! access $swho $chan"
    if {$cfflags == "-"} {
     putdcc $idx "\[!4ckc\] You do not have any channel specific flags on ${chan}."
     return 0
    } else {
     putdcc $idx "\[!4ckc\] Your access is \[${cfflags}\] on ${chan}."
     return 0
    }
   } else {
    putdcc $idx "\[!4ckc\] $chan is not a valid channel."
    return 0
   }
  }
  if {$chan == ""} {
   set mwho $hand
   set mflags [chattr $mwho]
   putlog "\[!4ckc\] !$hand! access $mwho"
   putdcc $idx "\[!4ckc\] Your access is \[${mflags}\]"
   return 0
  }
 }
 if {[validuser $who] == 1} {
  if {$chan != ""} {
   if {[validchan $chan]} {
    set cflags [chattr $who | $chan]
    set nflags [string trimleft $cflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set cfflags [string trim $nflags "|"]
    putlog "\[!4ckc\] !$hand! access $who $chan"
    if {$cfflags == "-"} {
     putdcc $idx "\[!4ckc\] You do not have any channel specific flags on ${chan}."
     return 0
    } else {
     putdcc $idx "\[!4ckc\] ${who}'s access is \[${cfflags}\] on ${chan}."
     return 0
    }
   } else {
    putdcc $idx "\[!4ckc\] $chan is not a valid channel."
    return 0
   }
  }
  if {$chan == ""} {
   set flags [chattr $who]
   putlog "\[!4ckc\] !$hand! access $who"
   putdcc $idx "\[!4ckc\] ${who}'s access is \[${flags}\]"
   return 0
  }
 }
 if {[validuser $who] == 0} {
  putdcc $idx "\[!4ckc\] No such user!"
  return 0
 }
}
## dcc cmd access -- stop

## public cmd access -- start
proc pub_access {nick uhost hand chan rest} {
 global CC
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}access <nick | me>"
  return 0
 }
 if {$who == "me"} {
  if {$chan != ""} {
   if {[validchan $chan]} {
    set swho $hand
    set cflags [chattr $swho | $chan]
    set nflags [string trimleft $cflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set cfflags [string trim $nflags "|"]
    putlog "\[!4ckc\] !$hand! access $swho $chan"
    if {$cfflags == "-"} {
     puthelp "NOTICE $nick :\[!4ckc\] You do not have any channel specific flags on ${chan}."
     return 0
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] Your access is \[${cfflags}\] on ${chan}."
     return 0
    }
   } else {
    puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel."
    return 0
   }
  }
  if {$chan == ""} {
   set mwho $hand
   set mflags [chattr $mwho]
   putlog "\[!4ckc\] !$hand! access $mwho"
   puthelp "NOTICE $nick :\[!4ckc\] Your access is \[${mflags}\]"
   return 0
  }
 }
 if {[validuser $who] == 1} {
  if {$chan != ""} {
   if {[validchan $chan]} {
    set cflags [chattr $who | $chan]
    set nflags [string trimleft $cflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set cfflags [string trim $nflags "|"]
    putlog "\[!4ckc\] !$hand! access $who $chan"
    if {$cfflags == "-"} {
     puthelp "NOTICE $nick :\[!4ckc\] ${who} does not have any channel specific flags on ${chan}."
     return 0
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] ${who}'s access is \[${cfflags}\] on ${chan}."
     return 0
    }
   } else {
    puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel."
    return 0
   }
  }
  if {$chan == ""} {
   set flags [chattr $who]
   putlog "\[!4ckc\] !$hand! access $who"
   puthelp "NOTICE $nick :\[!4ckc\] ${who}'s access is \[${flags}\]"
   return 0
  }
 }
 if {[validuser $who] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user!"
  return 0
 }
}
## public cmd access -- stop

## public cmd botnick -- start
proc pub_botnick {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set bot [lindex $rest 0]
 if {$bot==""} {
  puthelp "NOTICE $nick :\[!4ckc\] ${CC}botnick <new botnick>."
  return 0
 }
 putcmdlog "\[!4ckc\] #$hand# botnick $bot"
 putserv "NICK $bot"
}
## public cmd botnick -- stop

## dcc cmd botnick -- start
proc dcc_botnick {hand idx rest} {
 set bot [lindex $rest 0]
 if {$bot==""} {
  puthelp "NOTICE $nick :\[!4ckc\] .botnick <new botnick>."
  return 0
 }
 putcmdlog "\[!4ckc\] #$hand# botnick $bot"
 putserv "NICK $bot"
}
## dcc cmd botnick -- stop

## public cmd jump -- start
proc pub_jump {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set server [lindex $rest 0]
 if {$server == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: jump <server> \[port\] \[password\]"
  return 0
 }
 set port [lindex $rest 1]
 if {$port == ""} {set port "6667"}
 set password [lindex $rest 2]
 putcmdlog "\[!4ckc\] #$hand# jump $server $port $password"
 jump $server $port $password 
}
## public cmd jump -- stop

## public cmd die -- start
proc pub_die {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set idx [hand2idx $nick]
 if {$rest == ""} {set rest "requested!"}
 save

 putcmdlog "\[!4ckc\] #$hand# quit $rest"
 if {$rest == ""} {set rest "requested!"} 
 foreach x [userlist] {
  chattr $x -Q
 }
 putserv "QUIT :${rest}"
 utimer 2 {die}
}
## public cmd die -- stop

## public cmd ban -- start
proc pub_ban  {nick uhost hand channel rest} {
 global botnick CC ban-time
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}ban <nick> \[reason\]"
   return 0
  }
  if {$rest!=""} {
   set handle [lindex $rest 0]
   set reason [lrange $rest 1 end]
   append userhost $handle "!*" [getchanhost $handle $channel]
   set hostmask [maskhost $userhost]
   if {![onchan $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is not on the channel."
    return 0
   }
   if {[onchansplit $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is currently net-split."
    return 0
   }
   if {[string tolower $handle] == [string tolower $botnick]} {
    putserv "KICK $channel $nick :(k) do NOT mess with $botnick! -ck4C-"
    return 0
   }    
   if {$reason == ""} { 
    set reason "requested!" 
   }
   set options [lindex $reason 0]
   if {[string index $options 0] == "-"} {
     set options [string range $options 1 end]
   }
   switch -exact  $options {
     perm {
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" 0
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
           }
     min {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [lindex $reason 1]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
          }
     hours {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [lindex $reason 1]*60]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
     }
     days {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [lindex $reason 1]*60]*24]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
     }
     weeks {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [expr [lindex $reason 1]*60]*24]*7]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
     }
   }
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" $ban-time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! ban $channel $hostmask $options $reason"
             return 0
  } 
 }
 if {[isop $botnick $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## public cmd ban -- stop

## public cmd reload -- start
proc pub_reload {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 reload
 putcmdlog "\[!4ckc\] #$hand# reload"
 puthelp "NOTICE $nick :\[!4ckc\] Reloading user file..."
}
## public cmd restart -- stop

## public cmd ignores -- start
proc pub_ignores {nick uhost hand chan rest} {
 global CC botnick
 set iglist ""
 foreach x [ignorelist] {
  set iglister [lindex $x 0]
  set iglist "$iglist $iglister"
 }
 if {[ignorelist]==""} {
  putserv "NOTICE $nick :No ignores."
  return 0
 }
 regsub -all " " $iglist ", " iglist
 set iglist [string range $iglist 1 end]
 puthelp "NOTICE $nick :\[!4ckc\] Currently ignoring:$iglist"
 putlog "\[!4ckc\] <<$nick>> !$hand! ignores"
 return 0
}
## public cmd ignores -- stop

## public cmd -ignore -- start
proc pub_-ignore {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set hostmask [lindex $rest 0]
 if {$hostmask == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-ignore <hostmask>"
  return 0
 }
 if {[isignore $hostmask] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $hostmask is not on my ignore list."
  return 0
 }
 if {[isignore $hostmask] == 1} {
  putcmdlog "\[!4ckc\] #$hand# -ignore $hostmask"
  killignore $hostmask
  puthelp "NOTICE $nick :\[!4ckc\] No longer ignoring \[${hostmask}\]"
  save
 }
}
## public cmd -ignore -- stop

## public cmd +ignore -- start
proc pub_+ignore {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set hostmask [lindex $rest 0]
 set comment [lindex $rest 1]
 if {$hostmask == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+ignore <hostmask> \[comment\]"
  return 0
 }
 if {[isignore $hostmask] == 1} {
  puthelp "NOTICE $nick :\[!4ckc\] $hostmask is alreay set on ignore."
  return 0
 }
 if {[isignore $hostmask] == 0} {
  putcmdlog "\[!4ckc\] #$hand# +ignore $hostmask"
  newignore $hostmask $nick $comment 0
  puthelp "NOTICE $nick :\[!4ckc\] Now ignoring \[${hostmask}\]"
  save
 }
}
## public cmd +ignore -- stop

## public cmd comment -- start
proc pub_comment {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set comment [lrange $rest 0 end]
 if {($comment == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}comment <new comment>"
  return 0
 }
  putcmdlog "\[!4ckc\] #$hand# comment $comment"
  setuser $hand comment $comment
  puthelp "NOTICE $nick :\[!4ckc\] Added comment \[${comment}\]"
}
## public cmd comment -- stop

## public cmd chnick -- start
proc pub_chnick {nick uhost hand chan rest} {
 global CC owner botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set old [lindex $rest 0]
 set new [lindex $rest 1]
 if {($old == "") || ($new == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chnick <old nick> <new nick>"
  return 0
 }
 if {[validuser $old]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {([matchattr $old n] == 1)} {
  puthelp "NOTICE $nick :\[!4ckc\] cannot change the bot owner's nick"
  return 0
 }
 if {[validuser $old]==1} {
  putcmdlog "\[!4ckc\] #$hand# chnick $old $new"
  chnick $old $new
  puthelp "NOTICE $nick :\[!4ckc\] Changed partyline nick from \[${old}\] to \[${new}\]"
 }
}
## public cmd chnick -- stop

## public cmd chinfo -- start
proc pub_chinfo {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set info [lrange $rest 1 end]
 if {($who == "") || ($info == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chinfo <nick> <info>"
  return 0
 }
 if {[validuser $who]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {[validuser $who]==1} {
  putcmdlog "\[!4ckc\] #$hand# chinfo $who $info"
  setuser $who info $info
  puthelp "NOTICE $nick :\[!4ckc\] Added info \[${info}\] to $who."
 }
}
## public cmd chinfo -- stop

## public cmd chcomment -- start
proc pub_chcomment {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botn$
  return 0
 }
 set who [lindex $rest 0]
 set comment [lrange $rest 1 end]
 if {($who == "") || ($comment == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chcomment <nick> <new comment>"
  return 0
 }
 if {[validuser $who]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {[validuser $who]==1} {
  putcmdlog "\[!4ckc\] #$hand# chcomment $who $comment"
  setuser $who comment $comment
  puthelp "NOTICE $nick :\[!4ckc\] Added info \[${comment}\] to $who."
 }
}
## public cmd chcomment -- stop

## public cmd chemail -- start
proc pub_chemail {nick uhost hand chan rest} {
 global CC botnick
# puthelp "NOTICE $nick :\[!4ckc\] This command is only available via dcc chat"
# return 0
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set email [lindex $rest 1]
 if {($who == "") || ($email == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chemail <nick> <email>"
  return 0
 }
 if {[validuser $who]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {[validuser $who]==1} {
  putcmdlog "\[!4ckc\] #$hand# chemail $who $email"
  setuser $who email $email
  puthelp "NOTICE $nick :\[!4ckc\] Added email address \[${email}\] to $who."
 }
}
## public cmd chemail -- stop

## public cmd chpass -- start
proc pub_chpass {nick chan uhost hand rest} {
 global CC
 puthelp "NOTICE $nick :\[!4ckc\] Can only be changed via dcc chat."
}
## public cmd chpass -- stop

## public cmd me -- start
proc pub_me {nick uhost hand channel rest} {
 global CC
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage ${CC}me <msg>"
  return 0
 }
 putlog "\[!4ckc\] <<$nick>> !$hand! me $rest"
 putserv "PRIVMSG $channel :\001ACTION $rest\001"
}
## public cmd me -- stop

## public cmd save -- start
proc pub_save {nick uhost hand channel rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 putcmdlog "\[!4ckc\] #$hand# save"
 save
 puthelp "NOTICE $nick :\[!4ckc\] Writing channel & user file ..."
}
## public cmd save -- stop

## public cmd chattr -- start
proc pub_chattr {nick uhost hand channel rest} {
 global ownern flagss lowerflag nflagl CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set ownern [lindex $rest 0]
 set flagss [lindex $rest 1]
 set chan [lindex $rest 2]
 if {$ownern==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chattr <nick> <flags>"
  return 0
 }
 if {[validuser $ownern]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user!"
  return 0
 }
 if {$flagss==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}chattr <nick> <flags>"
  return 0
 }
 if {([matchattr $ownern n] == 1) && ([matchattr $nick n] == 0)} {
  puthelp "NOTICE $nick :\[!4ckc\] You do not have access to change ${ownern}'s flags."
 }
 if {[matchattr $nick n] == 1} {
  if {$chan != ""} {
   if {[validchan $chan]} {
    putcmdlog "\[!4ckc\] #$hand# chattr $ownern $flagss $chan"
    if {[string trim $flagss abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-] == "|"} {
     chattr $ownern $flagss $chan
    } else {
     chattr $ownern |$flagss $chan
    }
    set chanflags [chattr $ownern | $chan]
    set chanflags [string trimleft $chanflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set chanflags [string trim $chanflags "|"]
    set globalflags [chattr $ownern]
    puthelp "NOTICE $nick :\[!4ckc\] chattr $ownern \[${flagss}\] $chan"
    puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $ownern are \[${globalflags}\]"
    if {$chanflags != "-"} {
     puthelp "NOTICE $nick :\[!4ckc\] Channel \"${chan}\" Flags for $ownern are \[${chanflags}\]"
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $ownern does not have any channel specific flags on ${chan}."
    }
   } else {
    puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
   }
  } else {
   putcmdlog "\[!4ckc\] #$hand# chattr $ownern $flagss $chan"
   chattr $ownern $flagss
   set flags [chattr $ownern]
   puthelp "NOTICE $nick :\[!4ckc\] Chattr $ownern \[${flagss}\]"
   puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $ownern are now \[${flags}\]" 
  }
  if {[matchattr $ownern a] == 1} {
   pushmode $channel +o $ownern
  }
  if {([matchattr $ownern a] == 0) && ([matchattr $ownern o] == 0)} {
   pushmode $channel -o $ownern
  }
  save
  puthelp "NOTICE $nick :\[!4ckc\] Writing user file ..."
 }
  ##stop them from adding/removing +n if their not a owner.
 if {[matchattr $nick n] == 0} {
  set lowerflag [string tolower $flagss]
  set nflagl [string trim $flagss abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-]
  if {$nflagl != ""} {
   puthelp "NOTICE $nick :\[!4ckc\] You do not have access to add or remove the flag 'n' from that user."
   return 0
  }
 }
  ##stops other users from giving others +m.
 if {([matchattr $nick n] == 0) && ([matchattr $nick  m] == 1) && ([matchattr $ownern m] == 1)} {
  set lowerflag [string tolower $flagss]
  set nflagl [string trim $flagss abcdefghijklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-]
  if {$nflagl != ""} {
   puthelp "NOTICE $nick :\[!4ckc\] You do not have access to add or remove the flag 'm' from $ownern."
   return 0
  }
 }
 if {([matchattr $nick n] == 0) && ([matchattr $ownern n] == 0)} {
  if {$chan != ""} {
   if {[validchan $chan]} {
    putcmdlog "\[!4ckc\] #$hand# chattr $ownern $flagss"
    if {[string trim $flagss abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-] == "|"} {
     chattr $ownern $flagss $chan
    } else {
     chattr $ownern |$flagss $chan
    }
    set chanflags [chattr $ownern | $chan]
    set chanflags [string trimleft $chanflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set chanflags [string trim $chanflags "|"]
    set globalflags [chattr $ownern]
    puthelp "NOTICE $nick :\[!4ckc\] Chattr $ownern \[${flagss}\] $chan"
    puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $ownern are \[${globalflags}\]"
    if {$chanflags != "-"} {
     puthelp "NOTICE $nick :\[!4ckc\] Channel \"${chan}\" Flags for $ownern are \[${chanflags}\]"
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $ownern does not have any channel specific flags on ${chan}."
    }
   } else {
    puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
    return 0
   }
  } else {
   putcmdlog "\[!4ckc\] #$hand# chattr $ownern $flagss"
   chattr $ownern $flagss
   set flags [chattr $ownern]
   puthelp "NOTICE $nick :\[!4ckc\] Chattr $ownern \[${flagss}\]"
   puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $ownern are now \[${flags}\]"
  }
  if {[matchattr $ownern a] == 1} {
   pushmode $channel +o $ownern
  }
  save
  puthelp "NOTICE $nick :\[!4ckc\] Writing user file ..."
 }
}
## public cmd chattr -- stop

## public cmd -host -- start
proc pub_-host {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set hostname [lindex $rest 1]
 set completed 0
 if {($who == "") || ($hostname == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-host <nick> <hostmask>"
  return 0
 }
 if {[validuser $who]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {([matchattr $nick n] == 0) && ([matchattr $who n] == 1)} {
  puthelp "NOTICE $nick :\[!4ckc\] Can't remove hostmasks from the bot owner."
  return 0
 }
 if {[matchattr $nick m] == 0} {
  if {[string tolower $hand] != [string tolower $who]} {
   puthelp "NOTICE $nick :\[!4ckc\] You need '+m' to change other users hostmasks"
   return 0
  }
 }
 foreach * [getuser $who HOSTS] {
  if {${hostname} == ${*}} {
   putcmdlog "\[!4ckc\] #$hand# -host $who $hostname"
   delhost $who $hostname
   save 
   puthelp "NOTICE $nick :\[!4ckc\] Removed \[${hostname}\] from $who."
    ### Make it do the -host thing here, and any message that goes along with it
   set completed 1
  }
 }
 if {$completed == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such hostmask!"
 }
}
## public cmd -host -- stop

## public cmd +host -- start
 set thehosts {
              *@* * *!*@* *!* *!@* !*@*  *!*@*.* *!@*.* !*@*.* *@*.*
              *!*@*.com *!*@*com *!*@*.net *!*@*net *!*@*.org *!*@*org
              *!*@*gov *!*@*.ca *!*@*ca *!*@*.uk *!*@*uk *!*@*.mil
              *!*@*.fr *!*@*fr *!*@*.au *!*@*au *!*@*.nl *!*@*nl *!*@*edu
              *!*@*se *!*@*.se *!*@*.nz *!*@*nz *!*@*.eg *!*@*eg *!*@*dk
              *!*@*.il *!*@*il *!*@*.no *!*@*no *!*@*br *!*@*.br *!*@*.gi
              *!*@*.gov *!*@*.dk *!*@*.edu *!*@*gi *!*@*mil *!*@*.to *!@*.to 
              *!*@*to *@*.to *@*to

 }

proc pub_+host {nick uhost hand chan rest} {
 global CC thehosts botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set hostname [lindex $rest 1]
 if {($who == "") || ($hostname == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+host <nick> <new hostmask>"
  return 0
 }
 if {[validuser $who] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user!"
  return 0
 }
 set badhost 0
 foreach * [getuser $who HOSTS] {
  if {${hostname} == ${*}} {
   puthelp "NOTICE $nick :\[!4ckc\] That hostmask is already there."
   return 0
  }
 }
 if {($who == "") && ($hostname == "")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+host <nick> <new hostmask>"
  return 0
 }
 if {([lsearch -exact $thehosts $hostname] > "-1") || ([string match *@* $hostname] == 0)} {
     if {[string index $hostname 0] != "*"} {
       set hostname "*!*@*${hostname}"
     } else {
       set hostname "*!*@${hostname}"
     }
 }
 if {([string match *@* $hostname] == 1) && ([string match *!* $hostname] == 0)} { 
   if {[string index $hostname 0] == "*"} {
     set hostname "*!${hostname}"
   } else {
     set hostname "*!*${hostname}"
   }
 }
 puthelp "NOTICE kindred :$hostname"
 if {[validuser $who]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] No such user."
  return 0
 }
 if {([matchattr $nick n] == 0) && ([matchattr $who n] == 1)} {
  puthelp "NOTICE $nick :\[!4ckc\] Can't add hostmasks to the bot owner."
  return 0
 }
 foreach * $thehosts {
  if {${hostname} == ${*}} {
   puthelp "NOTICE $nick :\[!4ckc\] Invalid hostmask!"
   set badhost 1
  }
 }
 if {$badhost != 1} {
  if {[matchattr $nick m] == 0} {
   if {[string tolower $hand] != [string tolower $who]} {
    puthelp "NOTICE $nick :\[!4ckc\] You need '+m' to change other users hostmasks"
    return 0
   }
  }
  putcmdlog "\[!4ckc\] #$hand# +host $who $hostname"
  setuser $who HOSTS $hostname
  puthelp "NOTICE $nick :\[!4ckc\] Added \[${hostname}\] to $who."
  if {[matchattr $who a] == 1} {
   pushmode $chan +o $who
  }
  save
  puthelp "NOTICE $nick :\[!4ckc\] Writing user file ..."
 }
}
## public cmd +host -- stop

## public cmd -bot -- start
proc pub_-bot {nick uhost hand chan rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set bot [lindex $rest 0]
 if {$bot==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-bot <handle>"
  return 0
 }
 if {[validuser $bot] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $bot is not on my userlist."
  return 0
 }
 if {[matchattr $bot b] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] $bot is not a bot on the userlist."
  return 0
 }
 if {[matchattr $bot b] == 1} {
  putcmdlog "\[!4ckc\] #$hand# -bot $bot"
  deluser $bot
  puthelp "NOTICE $nick :\[!4ckc\] $bot has been deleted from the userlist."
  save
 }
}
## public cmd -bot -- stop

## public cmd +bot -- start
proc pub_+bot {nick uhost hand channel rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set bot [lindex $rest 0]
 set address [lindex $rest 1] 
 set hostmask [lindex $rest 2]
 if {[validuser $bot]==1} {
  puthelp "NOTICE $nick :\[!4ckc\] $bot is already in my userlist."
  return 0
 }
 if {($bot=="") || ($address=="")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+bot <botname> <address:botport#\[userport#\]> \[hostmask\]"
  return 0
 }
 set porttest [string trim $address "abcdefghijklmnopqrstuvwxyx."]
 set porttest [string trim $porttest ":"]
 if {$porttest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+bot <botname> <address:botport#\[userport#\]> \[hostmask\]" 
  return 0
 }
 if {[validuser $bot]==0} {
  putcmdlog "\[!4ckc\] #$hand# +bot $bot $address $hostmask"
  addbot $bot $address
  if {$hostmask != ""} {
    setuser $bot HOSTS $hostmask
  }
  save
  puthelp "NOTICE $nick :\[!4ckc\] $bot \[${address}\] has been add to userlist as a bot."
  return 0
 }
}
## public cmd +bot -- stop

## public cmd deluser -- start
proc pub_deluser {nick uhost hand channel rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}deluser <handle>"
  return 0
 } else {
  pub_-user $nick $uhost $hand $channel $rest} {
 }
}
## public cmd deluser -- stop

## public cmd -user -- start
proc pub_-user {nick uhost hand channel rest} {
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 if {$who == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}-user <nick>"
 } else {
  if {[validuser $who] == 0} {
   puthelp "NOTICE $nick :\[!4ckc\] $who is not on my userlist."
  } else {
   if {[matchattr $who n] == 1}  {
    puthelp "NOTICE $nick :\[!4ckc\] You cannot delete a bot owner."
   } else {
    if {([matchattr $who m] == 1) && ([matchattr $nick n] == 0)} {
     puthelp "NOTICE $nick :\[!4ckc\] You don't have access to delete $who."
    } else {
     putcmdlog "\[!4ckc\] #$hand# -user $who"
     deluser $who
     save
     puthelp "NOTICE $nick :\[!4ckc\] $who has been deleted."
    }
   }
  }
 }
}
## public cmd -user -- stop

## public cmd +user -- start
proc pub_+user {nick uhost hand channel rest} {
 global CC botnick thehosts
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set hostmask [lindex $rest 1]
 if {([lsearch -exact $thehosts $hostmask] > "-1") || ([string match *@* $hostmask] == 0)} {
     if {[string index $hostmask 0] != "*"} {
       set hostmask "*!*@*${hostmask}"
     } else {
       set hostmask "*!*@${hostmask}"
     }
 }
 if {([string match *@* $hostmask] == 1) && ([string match *!* $hostmask] == 0)} {
   if {[string index $hostmask 0] == "*"} {
     set hostmask "*!${hostmask}"
   } else {
     set hostmask "*!*${hostmask}"
   }
 }
 if {$hostmask == ""} {
   if {[onchan $who $channel] == 1} {
     regsub -all " " [split [maskhost [getchanhost mark- #wonkegg]] !] "!*" hostmask
   }
 }
 if {[validuser $who]==1} {
  puthelp "NOTICE $nick :\[!4ckc\] $who is already in my userlist."
  return 0
 }
 if {($who=="") || ($hostmask=="")} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+user <nick> <hostmask>"
  return 0
 }
 set who [lindex $rest 0]
 set flags [lindex $rest 2]
 if {[validuser $who]==0} {
  putcmdlog "\[!4ckc\] #$hand# +user $who $hostmask"
  adduser $who $hostmask
  save
  puthelp "NOTICE $nick :\[!4ckc\] $who has been added to userlist with hostmask \[$hostmask\]."
  if {$flags != ""} {
   chattr $who $flags $channel
   puthelp "NOTICE $nick :\[!4ckc\] Added $flags to $who"
  }
  return 0
 }
}
## public cmd +user -- stop

## public cmd adduser -- start
proc pub_adduser {nick uhost hand channel rest} {
 global CC botnick
  if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[lindex $rest 0] == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}adduser <nick> \[optional flags\]"
  return 0
 }
 if {[validuser [lindex $rest 0]]} {
  puthelp "NOTICE $nick :\[!4ckc\] $rest is already in my userlist."
  return 0
 }
 if {[onchan [lindex $rest 0] $channel]==1} {
  set who [lindex $rest 0]
  set oflags [lindex $rest 1]
  set host [maskhost [getchanhost [lindex $rest 0] $channel]]
  putcmdlog "\[!4ckc\] #$hand# adduser $who $oflags"
  adduser $who $host
  if {$oflags != ""} {
   if {[lindex $rest 2] != ""} {
    chattr $who |${oflags} [lindex $rest 2]
    set flags [chattr $who]
    set newhost [getuser $who HOSTS]
    puthelp "NOTICE $nick :\[!4ckc\] $who \[$newhost\] has been added to the userlist."
    puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $who are \[${flags}\]"
    set chanflags [chattr [lindex $rest 0] | [lindex $rest 2]]
    set chanflags [string trimleft $chanflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]
    set chanflags [string trim $chanflags |]
    puthelp "NOTICE $nick :\[!4ckc\] Channel \"[lindex $rest 2]\" Flags for $who are \[${chanflags}\]"
    save
    return 0
   } else {
    chattr $who $oflags
    set flags [chattr $who]
    set newhost [getuser $who HOSTS]
    puthelp "NOTICE $nick :\[!4ckc\] $who \[$newhost\] has been added to the userlist."
    puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $who are \[${flags}\]"
    save
    return 0
   }
  } else {
   set flags [chattr $who]
   puthelp "NOTICE $nick :\[!4ckc\] $who \[$host\] has been added to the userlist."
   puthelp "NOTICE $nick :\[!4ckc\] Global Flags for $who are \[${flags}\]"
   save
   return 0
  }
 }
 if {[onchan [lindex $rest 0] $channel]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] That user is not on $channel."
 }
}
## public cmd adduser -- stop

## dcc cmd action -- start
proc cmd_action {idx text} {
 set text [string trim $text \001]
 set text [lrange $text 1 end]
 dccsimul $idx ".me $text"
 return 1
}
## dcc cmd action -- stop

## public cmd part -- start
proc pub_part {nick uhost hand chan rest} { 
 set rest [lindex $rest 0]
 global nopart botnick
  if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[string first # $rest]!=0} {
  set rest "#$rest"
 }
 if {$rest==""} {
 puthelp "NOTICE $nick :\[!4ckc\] Usage: part <#channel>"
  return 0
 } else {
  foreach x [channels] {
   if {[string tolower $x]==[string tolower $rest]} {
    if {[string tolower $rest]==[string tolower $nopart]} {
     puthelp "NOTICE $nick :\[!4ckc\] Sorry I can not part $nopart \[PROTECTED\]"
     return 0
    }
    channel remove $rest
    puthelp "NOTICE $nick :\[!4ckc\] I have left $x"
    putcmdlog "\[!4ckc\] #$hand# part $x"
    return 0
   }
  }
 }
 puthelp "NOTICE $nick :\[!4ckc\] I wasn't in $rest"
}
## public cmd part -- stop

## public cmd join -- start 
proc pub_join {nick uhost hand chan rest} {
 global CC botnick
  if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set chan [lindex $rest 0]
 if {[string first # $chan]!=0} {
  set chan "#$chan"
 }
 if {$chan=="#"} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}join <#channel>"
 } else {
 foreach x [channels] {
  if {[string tolower $x]==[string tolower $chan]} {
   puthelp "NOTICE $nick :\[!4ckc\] Your already in $x"
   return 0
  }
 }
 if {[lindex $rest 1] == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] I have joined $chan"
 } else {
   puthelp "NOTICE $nick :\[!4ckc\] I have joined $chan (key: [lindex $rest 1])"
 }
 channel add $chan
  if {$rest!=""} {
   putserv "JOIN $chan :[lindex $rest 1]"
   putcmdlog "\[!4ckc\] #$hand# join $chan (key: [lindex $rest 1])"
  }
 }
}
## public cmd join -- stop

## dcc cmd join -- start
proc cmd_join {hand idx rest} {
 set chan [lindex $rest 0]
 if {[string first # $chan]!=0} {
  set chan "#$chan"
 }
 if {$chan=="#"} {
  putdcc $idx "\[!4ckc\] Usage: join <#channel> \[key\]"
 } else {
 foreach x [channels] { 
  if {[string tolower $x]==[string tolower $chan]} {
   putdcc $idx "\[!4ckc\] Your already in $x"
   return 0
  }
 }
 if {[lindex $rest 1] == ""} {
   putdcc $idx "\[!4ckc\] I have joined $chan"
 } else {
   putdcc $idx "\[!4ckc\] I have joined $chan (key: [lindex $rest 1])"
 }
 channel add $chan
  if {$rest!=""} {
   putserv "JOIN $chan :[lindex $rest 1]"
   putcmdlog "\[!4ckc\] #$hand# join $chan (key: [lindex $rest 1])"
  }
 }
}
## dcc cmd join -- stop

## dcc cmd part -- start
proc cmd_part {hand idx rest} {
 set rest [lindex $rest 0]
 global nopart
 if {[string first # $rest]!=0} {
  set rest "#$rest"
 }
 if {$rest==""} {
 putdcc $idx "\[!4ckc\] Usage: part <#channel>"
  return 0
 } else {
  foreach x [channels] {
   if {[string tolower $x]==[string tolower $rest]} {
    if {[string tolower $rest]==[string tolower $nopart]} {
     putdcc $idx "\[!4ckc\] Sorry I can not part $nopart \[PROTECTED\]"
     return 0 
    }
    channel remove $rest
    putdcc $idx "\[!4ckc\] I have left $x"
    putcmdlog "\[!4ckc\] #$hand# part $x"
    return 0
   }
  }
 }
 putdcc $idx "\[!4ckc\] I wasn't in $rest"
}
## dcc cmd part -- stop

## public cmd channels -- start
proc pub_channels {nick hand uhost chan rest} {
 regsub -all " " [channels] ", " chans
 puthelp "NOTICE $nick :\[!4ckc\] Channels: $chans"
}
## public cmd channels -- stop

## dcc cmd say -- start
proc cmd_say {hand idx rest} {
 if {$rest==""} {
  putdcc $idx "\[!4ckc\] Usage: say <msg>"
 }
 if {$rest!=""} {
  set chan2send [lindex [console $idx] 0]
  puthelp "PRIVMSG $chan2send :$rest"
  putcmdlog "\[!4ckc\] #$hand# say $rest"
 }
}
## dcc cmd say -- stop

## dcc cmd act -- start
proc cmd_act {hand idx rest} {
 if {$rest==""} {
  putdcc $idx "\[!4ckc\] Usage: act <msg>"
 }
 if {$rest!=""} {
  set chan2send [lindex [console $idx] 0]
  putserv "PRIVMSG $chan2send :\001ACTION $rest\001"
  putcmdlog "\[!4ckc\] #$hand# act $rest"
 }
}
## dcc cmd act -- stop

## dcc cmd addlog -- start
proc cmd_addlog {hand idx rest} {
 if {$rest==""} {
  putdcc $idx "\[!4ckc\] Usage: addlog <log>"
 } else {
  putcmdlog "\[!4ckc\] $hand: $rest"
 }
}
## dcc cmd addlog -- stop

## dcc cmd invite -- start
proc cmd_invite {hand idx rest} {
 set rest [lindex $rest 0]
 set activechan [lindex [console $idx] 0]
 if {$rest==""} {
  putdcc $idx "\[!4ckc\] Usage: invite <nick>"
  return 0
 } else {
  if {[onchan $rest $activechan]==1} {
  putdcc $idx "\[!4ckc\] $rest is on $activechan already!" 
  return 0
   } else {
   putserv "INVITE $rest :$activechan"
   putdcc $idx "\[!4ckc\] Invitation sent to $rest"
   putcmdlog "\[!4ckc\] #$hand# invite $rest"
  }
 }
}
## public cmd invite -- stop

## cmd aop join -- start
proc aop_join {nick hand uhost channel} {
 global botnick
 if {[botisop $channel]==1} {
  foreach x $channel {
   if {[string tolower $channel]==[string tolower $x]} {
    pushmode $channel +o $nick
   } 
  } 
 }
 if {[botisop $channel]!=1} {
  if {$botnick!=$nick} {
   puthelp "NOTICE $nick :\[!4ckc\] I would have auto oped you... but I am not oped"
  } 
 } 
}
## cmd aop join -- stop

## dcc cmd raop -- start
proc cmd_raop {hand idx rest} {
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who != ""} {
  if {[validuser $who] == 1} {
   if {$chan != ""} {
    if {[validchan $chan]} {
     if {[matchattr $who |a $chan] == 1} {
      chattr $who |-a $chan
      puthelp "NOTICE $nick :\[!4ckc\] $who is no longer auto oped on $chan"
      putlog "\[!4ckc\] <<$nick>> !$hand! raop $who $chan"
      return 0
     } else {
      puthelp "NOTICE $nick :\[!4ckc\] $who wasn't auto oped on $chan"
      return 0
     }
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
     return 0
    }
   } else {
    if {[matchattr $who a] == 1} {
     chattr $who -a
     puthelp "NOTICE $nick :\[!4ckc\] $who is no longer a global auto oped"
     putlog "\[!4ckc\] <<$nick>> !$hand! raop $who $chan"
     return 0
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $who wasn't auto oped"
     return 0
    }
   }
  }
  if {[validuser $who] == 0} {
   puthelp "NOTICE $nick :\[!4ckc\] $who is not a valid user"
  }
 }
 if {$who == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: raop <nick>"
 }
}
## dcc cmd raop -- stop

## public cmd raop -- start
proc pub_raop {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who != ""} {
  if {[validuser $who] == 1} {
   if {$chan != ""} {
    if {[validchan $chan]} {
     if {[matchattr $who |a $chan] == 1} {
      chattr $who |-a $chan
      puthelp "NOTICE $nick :\[!4ckc\] $who is no longer auto oped on $chan" 
      putlog "\[!4ckc\] <<$nick>> !$hand! raop $who $chan"
      return 0
     } else {
      puthelp "NOTICE $nick :\[!4ckc\] $who wasn't auto oped on $chan"
      return 0
     }
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
     return 0
    }
   } else {
    if {[matchattr $who a] == 1} {
     chattr $who -a
     puthelp "NOTICE $nick :\[!4ckc\] $who is no longer a global auto oped"
     putlog "\[!4ckc\] <<$nick>> !$hand! raop $who $chan"
     return 0
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $who wasn't auto oped"
     return 0
    }
   }
  }
  if {[validuser $who] == 0} {
   puthelp "NOTICE $nick :\[!4ckc\] $who is not a valid user"
  }
 }
 if {$who == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: raop <nick>"
 }
}
## public cmd raop -- start

## public cmd aop -- start
proc pub_aop {nick uhost hand channel rest} {
 global botnick CC
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who != ""} {
  if {[validuser $who] == 1} {
   if {$chan != ""} {
    if {[validchan $chan]} {
     if {[matchattr $who |a $chan] == 0} {
      chattr $who |a $chan
      puthelp "NOTICE $nick :\[!4ckc\] $who is now auto oped on $chan"
      putlog "\[!4ckc\] <<$nick>> !$hand! aop $who $chan"
      return 0
     } else {
      puthelp "NOTICE $nick :\[!4ckc\] $who is already auto oped on $chan"
      return 0
     }
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $chan is not a valid channel"
     return 0
    }
   } else {
    if {[matchattr $who a] == 0} {
     chattr $who +a
     puthelp "NOTICE $nick :\[!4ckc\] $who is now global auto oped."
     putlog "\[!4ckc\] <<$nick>> !$hand! aop $who"
     return 0
    } else {
     puthelp "NOTICE $nick :\[!4ckc\] $who is already auto oped"
     return 0
    }  
   }
  }
  if {[validuser $who] == 0} {
   puthelp "NOTICE $nick :\[!4ckc\] $who is not a valid user"
  }
 }
 if {$who == ""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}aop <nick>"
 }
}
## public cmd aop -- stop

## dcc cmd aop -- start
proc cmd_aop {hand idx rest} {
 set who [lindex $rest 0]
 set chan [lindex $rest 1]
 if {$who != ""} {
  if {[validuser $who] == 1} {
   if {$chan != ""} {
    if {[validchan $chan]} {
     if {[matchattr $who |a $chan] == 0} {
      chattr $who |a $chan
      putdcc $idx "\[!4ckc\] $who is now auto oped on $chan"
      putlog "\[!4ckc\] <<$nick>> !$hand! aop $who $chan"
      return 0
     } else {
      putdcc $idx "\[!4ckc\] $who is already auto oped on $chan"
      return 0
     }
    } else {
     putdcc $idx "\[!4ckc\] $chan is not a valid channel"
     return 0
    }
   } else {
    if {[matchattr $who a] == 0} {
     chattr $who +a
     putdcc $idx "\[!4ckc\] $who is now global auto oped."
     putlog "\[!4ckc\] <<$nick>> !$hand! aop $who"
     return 0
    } else {
     putdcc $idx "\[!4ckc\] $who is already auto oped"
     return 0
    }
   }
  }
  if {[validuser $who] == 0} {
   putdcc $idx "\[!4ckc\] $who is not a valid user"
  }
 }
 if {$who == ""} {
  putdcc $idx "\[!4ckc\] Usage: aop <nick>"
 }
}
## dcc cmd aop -- stop

## public cmd channel -- start
proc pub_channel {nick uhost hand channel rest} {
 global botnick
 set rest [lindex $rest 0]
 set chanlisting ""
 foreach x [chanlist $channel] {
  set dathand [nick2hand $x $channel]
  if {$dathand=="*"} {set dathand "?"}
  set chanlisting "$chanlisting $x\[$dathand\]"
 }
 puthelp "NOTICE $nick :\[!4ckc\] Channel:$chanlisting" 
 putlog "\[!4ckc\] <<$nick>> !$hand! channel"
}
## public cmd channel -- stop

## public cmd who -- start
proc pub_who {nick uhost hand channel rest} {
 global botnick
 set peoplelist ""
 set botlist ""
 set e " "
 foreach x [dcclist] {
  set people [lindex $x 1]
  set type [lindex $x 3]
  set bot [lindex $x 1]
  if {$type == "CHAT"} {
   string trim $people " "
   set peoplelist "$peoplelist $people"
   set peoplenum $e\[[llength $peoplelist]\]
  }
  if {$type == "BOT"} {
   string trim $bot " "
   set botlist "$botlist $bot"
   set botnum $e\[[llength $bot]\]
  }
 }
 if {[string trim ${peoplelist} " "]==""} {
  set peoplelist " No one is on $botnick"
  set peoplenum ""
 }
 if {[string trim ${botlist} ""]==""} {
  set botlist " No bots are linked to $botnick"
  set botnum ""
 }
 regsub -all " " $peoplelist ", " peoplelist
 regsub -all " " $botlist ", " botlist

 set peoplelist [string range $peoplelist 1 end]
 set botlist [string range $botlist 1 end]
 puthelp "NOTICE $nick :\[!4ckc\] People$peoplenum:$peoplelist"
 puthelp "NOTICE $nick :\[!4ckc\] Bots$botnum:$botlist" 
 putlog "\[!4ckc\] <<$nick>> !$hand! who" 
 return 0
}
## public cmd who -- stop

proc pub_wi {nick uhost hand channel rest} {
 global botnick max-notes
 pub_whois $nick $uhost $hand $channel $rest
}

proc pub_whois {nick uhost hand channel rest} { 
 global botnick max-notes
 set fl "\[!4ckc\]"
 if {[validuser $rest] == 0} {
   putserv "NOTICE $nick :\[!4ckc\] No such user!"
   return 0
 }
 set user [lindex $rest 0]
 set ch [passwdok "$rest" ""]
 if {!$ch} {set pass "yes"} else {set pass "no "}
 set notes [notes $user]
 set flags [chattr $user]
 while {[string length $flags] < 15} {
   append flags " "
 }
 while {[string length $user] < 9} {
   append user " "
 }   
 if {[string length $notes] == "1"} {set notes "  ${notes}"}
 if {[string length $notes] == "2"} {set notes " ${notes}"}
 #set flags [chattr $user]
 #set userlen [string length $user]
 #set bl1 "         "
 #if {$userlen < 9} {
 #  set dt1 [expr 8-$userlen]
 #  set add [string range $bl1 0 $dt1]
 #  append user $add
 #}
 #if {$userlen > 9} {set user [string range $userlen 0 8]} 
 #set flagslen [string length $flags]
 #set bl2 "               "
 #if {$flagslen < 15} {
 #  set dt2 [expr 14-$flagslen]
 #  set add [string range $bl2 0 $dt2]
 #  append flags $add
 #}
 set lastseen [ctime [lindex [getuser [string trim $user] LASTON] 0]]
 set day "[lindex $lastseen 0]."
 set month "[lindex $lastseen 1], [lindex $lastseen 2]"
 set time [lindex $lastseen 3]
 set year "[string range [lindex $lastseen 4] 2 3]"
 set last "$time on $month"

 #if {$flagslen > 15} {set flags [string range $flagslen 0 14]}
 puthelp "NOTICE $nick :$fl HANDLE    PASS NOTES FLAGS           LAST"
 puthelp "NOTICE $nick :$fl $user $pass    $notes $flags $last"
 set user [string trim $user]
 if {![matchattr $user b]} {
 foreach i [channels] {
    set tchan [string length $i]

    set bl3 "                  "
   if {$tchan < 18} {
     set dt3 [expr 17-$tchan]
     set add2 [string range $bl3 0 $dt3]
     append chans $i$add2
   }
    set cflags [chattr $user | $i] 
    set nflags [string trimleft $cflags "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"]

    set cfflags [string trim $nflags "|"]
    set cf [string length $cfflags]
 set flagslen2 [string length $cf]
 set bl26 "               "
 if {$flagslen2 < 14} {
   set dt26 [expr 13-$flagslen2]
   set add4 [string range $bl26 0 $dt26]
   append flags12 $add4
 }
 if {$flagslen2 > 14} {set flags12 [string range $flagslen2 0 13]}
 set lastseen2 [ctime [lindex [getuser $user LASTON $i] 0]]
 set day2 "[lindex $lastseen2 0]."
 set month2 "[lindex $lastseen2 1], [lindex $lastseen2 2]"
 set time2 [lindex $lastseen2 3]
 set year2 "`[string range [lindex $lastseen2 4] 2 3]"
 set last2 "$time on $month2"
   puthelp "NOTICE $nick :$fl   $chans $cfflags $flags12 $last2"   
 }
 }
   if {[getuser $user HOSTS] != ""} {
     set hosts [getuser $user hosts]
     puthelp "NOTICE $nick :$fl   HOSTS: $hosts" 
   }
     if {[getuser $user BOTFL] != ""} {
       puthelp "NOTICE $nick :$fl   BOT FLAGS: [getuser $user BOTFL]"
     }
     if {[getuser $user BOTADDR] != ""} {
       set botinfo [getuser $user BOTADDR]
       puthelp "NOTICE $nick :$fl   ADDRESS: [lindex $botinfo 0]"
       puthelp "NOTICE $nick :$fl      telnet: [lindex $botinfo 1], relay: [lindex $botinfo 2]"
     }
}
## public cmd whois -- stop

## public cmd whom -- start
proc pub_whom {nick uhost hand channel rest} {
 set peoplelist ""
 foreach x [whom 0] {
  set people [lindex $x 0]
  string trim $people " "
  set peoplelist "$peoplelist ${people}@[lindex [string trim $x ""] 1]"
 }
 regsub -all " " $peoplelist ", " peoplelist 
 set peoplelist [string range $peoplelist 1 end]
 if {[string trim ${peoplelist} " "]==""} {
  set peoplelist " No one is on the partyline"
 }
 puthelp "NOTICE $nick :\[!4ckc\] People:$peoplelist"
 putlog "\[!4ckc\] <<$nick>> !$hand! whom"
 return 0
}
## public cmd whom -- stop

## public cmd match -- start
proc pub_match {nick uhost hand chan rest} {
 global CC
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}match <flags>"
  return 0
 }
 set rest [string trim $rest +]
 if {[string length $rest] > 1} {
   puthelp "NOTICE $nick :\[!4ckc\] Invalid option."
   return 0
 }
 if {$rest!=""} {
  set rest "+[lindex $rest 0]"
  if {[userlist $rest]!=""} {
   regsub -all " " [userlist $rest] ", " users 
   puthelp "NOTICE $nick :\[!4ckc\] Match \[$rest\]: $users" 
   putlog "\[!4ckc\] <<$nick>> !$hand! match $rest"
   return 0
  }
  if {[userlist $rest]==""} {
   puthelp "NOTICE $nick :\[!4ckc\] No users with flags \[$rest\]"
   return 0
  }
 }
}
## public cmd match -- stop

## dcc cmd match -- start
proc dcc_match {hand idx args} {
 set flags [lindex $args 0]
 set flags [string trim $flags +]
 if {$flags==""} {
   putdcc $idx "\[!4ckc\] Usage: match <flags>"
   return 0
 }
 if {[string length $flags] > 1} {
   putdcc $idx "\[!4ckc\] Invalid Option."
   return 0
 }
 if {$flags!=""} {
  if {[userlist $flags]!=""} {
   regsub -all " " [userlist $flags] ", " users
   putdcc $idx "\[!4ckc\] Match \[$flags\]: $users"
   putlog "\[!4ckc\] #$hand# match $flags"
   return 0
  }
  if {[userlist $flags]==""} {
   putdcc $idx "\[!4ckc\] No users with flags \[$flags\]"
   return 0
  }
 }
}
## dcc cmd match -- stop

## public cmd bots -- start
proc pub_bots {nick uhost hand chan rest} {
 if {[bots]==""} {
  puthelp "NOTICE $nick :\[!4ckc\] No bots connected"
  putlog "\[!4ckc\] <<$nick>> !$hand! bots"
  return 0
 }
 if {[bots]!=""} {
  regsub -all " " [bots] ", " bots
  puthelp "NOTICE $nick :\[!4ckc\] Bots: $bots"
  putlog "\[!4ckc\] <<$nick>> !$hand! bots"
  return 0
 }
}
## public cmd bots -- stop

## public cmd bottree -- start 
proc pub_bottree {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] Bottree is only available via dcc chat, try Bots" 
}
## public cmd bottree - stop

## public cmd notes -- start
proc pub_notes {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] notes is only available via dcc chat"
}
## public cmd notes -- stop

proc val {string} {
  set arg [string trim $string /ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz]
  set arg2 [string trim $arg #!%()@-_+=\[\]|,.?<>{}]
  return $arg2
}

## public cmd +ban -- start
proc pub_+ban  {nick uhost hand channel rest} {
 global botnick CC ban-time
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}+ban <hostmask> \[reason\]"
   return 0
  }
  if {$rest!=""} {
   set host [lindex $rest 0]
   set reason [lrange $rest 1 end]
   if {[string tolower $host] == [string tolower $botnick]} {
    putserv "KICK $channel $nick :(k) do NOT mess with $botnick! -ck4C-"
    return 0
   }    
   if {$reason == ""} {
    set reason "enforcing!"
   }
   set options [lindex $reason 0]
   if {[string index $options 0] == "-"} {
     set options [string range $options 1 end]
   }
   switch -exact  $options {
     perm {
             set reason [lrange $reason 1 end]
             newban $host $nick "$reason" 0
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0
           }
     min {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [lindex $reason 1]
             set reason [lrange $reason 2 end]
             newban $host $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0
          }
     hours {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [lindex $reason 1]*60]
             set reason [lrange $reason 2 end]
             newban $host $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0    
     }
     days {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [lindex $reason 1]*60]*24]
             set reason [lrange $reason 2 end]
             newban $host $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0
     }
     weeks {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [expr [lindex $reason 1]*60]*24]*7]
             set reason [lrange $reason 2 end]
             newban $host $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0
     }
   }
             set reason [lrange $reason 1 end]
             newban $host $nick "$reason" $ban-time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! +ban $reason"
             return 0
  } 
 }
 if {[botisop $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## public cmd +ban -- stop

## public cmd -ban -- start
proc pub_-ban {nick uhost hand channel rest} {
 set rest [lindex $rest 0]
 global botnick botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
  if {[botisop $channel]==1} {
   if {$rest==""} {
    puthelp "NOTICE $nick :\[!4ckc\] Usage: -ban <ban #>"
   }
  if {$rest!=""} {
   set mbantester [catch {expr $rest-1}]
   if {$mbantester==1} {
    puthelp "NOTICE $nick :\[!4ckc\] Usage: -ban <ban #>"
    return 0
   }
   if {[lindex [banlist $channel] [expr ${rest}-1]]==""} {
    puthelp "NOTICE $nick :\[!4ckc\] No such channel ban. It may be a global ban" 
    return 0 
   }  
   if {[lindex [banlist $channel] [expr ${rest}-1]]!=""} {
    set restban [lindex [lindex [banlist $channel] 0] [expr ${rest}-1]]
    killchanban $channel $rest
    puthelp "NOTICE $nick :\[!4ckc\] Ban $restban was removed"
    putlog "\[!4ckc\] <<$nick>> !$hand! -ban $rest"
    return 0
   }
  }
 }
 if {[isop $botnick $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## public cmd -ban -- stop

## public cmd bans -- start
proc pub_bans {nick uhost hand chan rest} {
 global CC ban-time
 set rest [lindex $rest 0]
 set rest [string toupper $rest]
 if {$rest!="CHANNEL"} {
  if {$rest!="GLOBAL"} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: bans <global | channel>"
  }
 }
 set banlistchan ""
 if {$rest=="CHANNEL"} {
  foreach x [banlist $chan] {
   set banlister [lindex $x 0]
   set banlistchan "$banlistchan $banlister"
  }
  if {[banlist $chan]==""} { 
   set banlistchan " No channel bans in $chan"
  }
  puthelp "NOTICE $nick :\[!4ckc\] Channel Bans:$banlistchan"
  putlog "\[!4ckc\] <<$nick>> !$hand! bans channel"
  return 0
 }
 set banlist ""
 if {$rest=="GLOBAL"} {
  foreach x [banlist] {
   set banlisting [lindex $x 0]
   set banlist "$banlist $banlisting"
  }
  if {$banlist==""} {
   set banlist " No global bans"
  }
  puthelp "NOTICE $nick :\[!4ckc\] Global Bans:$banlist"
  putlog "\[!4ckc\] <<$nick>> !$hand! bans global"
  return 0
 }
}
## public cmd bans -- stop

## dcc cmd op -- start
proc cmd_op {hand idx rest} {
 set rest [lindex $rest 0]
 set channel [lindex [console $idx] 0]
 global botnick  
 if {[botisop $channel]==1} { 
  if {$rest==""} {
   putdcc $idx "\[!4ckc\] Usage: op <nick>"
  }
  if {[onchan $rest $channel]=="1"} {  
   if {[isop $rest $channel]=="1"} {
    putdcc $idx "\[!4ckc\] $rest is already oped"
   }
  }
  if {$rest!=""} {
   if {[onchan $rest $channel]=="0"} {
    putdcc $idx "\[!4ckc\] $rest isn't on the channel"
   }
  }
  if {[onchan $rest $channel]=="1"} {
   if {[isop $rest $channel]=="0"} {
    pushmode $channel +o $rest
    putlog "\[!4ckc\] #$hand# op $rest"
   }
  }
 }
 if {[botisop $channel]!=1} {
  putdcc $idx "\[!4ckc\] I am not oped, sorry."
 }
}
## dcc cmd op -- stop

## public cmd op -- start
proc pub_op {nick uhost hand channel rest} {
 set rest [lindex $rest 0]
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest==""} {
    if {![botisop $channel]} {
      putserv "NOTICE $nick :Sorry, Im not op'd."
      return 0
    }
    if {[isop $nick $channel]} {
      putserv "NOTICE $nick :You are already op'd."
      return 0
    }
    putcmdlog "\[!4ckc\] #$hand# op $nick"
    pushmode $channel +o $nick
    return 0
  }
  if {[onchan $rest $channel]==1} {
   if {[isop $rest $channel]==1} {
    puthelp "NOTICE $nick :\[!4ckc\] $rest is already oped."
   }
  }
  if {$rest!=""} {
   if {[onchan $rest $channel]==0} {
    puthelp "NOTICE $nick :\[!4ckc\] $rest isn't on the channel."
   }
  }
  if {[onchan $rest $channel]==1} {
   if {[isop $rest $channel]==0} {
    pushmode $channel +o $rest 
    putlog "\[!4ckc\] <<$nick>> !$hand! op $rest"
   }
  }
 }
 if {[botisop $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped, sorry."
 }
}
## public cmd op -- stop

## dcc cmd deop -- start
proc cmd_deop {hand idx rest} {
 global botnick
 set rest [lindex $rest 0]
 set channel [lindex [console $idx] 0]
 if {[botisop $channel]==1} { 
  if {$rest==""} {
   putdcc $idx "\[!4ckc\] Usage: deop <nick>"
  }
  if {$rest!=""} {
   if {[onchan $rest $channel]=="0"} {
    putdcc $idx "\[!4ckc\] $rest isn't on the channel"
   }
  }
  if {[onchan $rest $channel]=="1"} {
   if {[isop $rest $channel]=="0"} {
    putdcc $idx "\[!4ckc\] $rest is already deoped"
   }
  }
  if {[string tolower $botnick] == [string tolower $rest]} {
   putdcc $idx "\[!4ckc\] I don't deop myself..."
  }
  if {[isop $rest $channel]=="1"} {
   if {[onchan $rest $channel]=="1"} {
    if {$botnick!=$rest} {
     pushmode $channel -o $rest
     putlog "\[!4ckc\] #$hand# deop $rest"
    }
   }
  } 
 }
 if {[botisop $channel]!=1} {
  putdcc $idx "\[!4ckc\] I am not oped"
 }
}
## dcc cmd deop -- stop

## public cmd deop -- start
proc pub_deop {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set rest [lindex $rest 0]
 if {[botisop $channel]==1} {
  if {$rest==""} {
    if {![botisop $channel]} {
      putserv "NOTICE $nick :Sorry, Im not op'd."
      return 0
    }
    if {![isop $nick $channel]} {
      putserv "NOTICE $nick :You are already deop'd."
      return 0
    }
    putcmdlog "\[!4ckc\] #$hand# deop $nick"
    pushmode $channel -o $nick
    return 0
  }
  if {$rest!=""} {
   if {[onchan $rest $channel] == 0} {
    puthelp "NOTICE $nick :\[!4ckc\] $rest isn't on the channel."
    return 0
   }
  }
  if {[onchan $rest $channel]=="1"} {
   if {[isop $rest $channel]=="0"} {
    puthelp "NOTICE $nick :\[!4ckc\] $rest is already deoped."
    return 0
   }
  }
  if {[string tolower $botnick] == [string tolower $rest]} {
   putserv "KICK $channel $nick :(k) do NOT mess with $botnick! -ck4C-"
   return 0
  }
  if {[isop $rest $channel]=="1"} {
   if {[onchan $rest $channel]=="1"} {
    if {[string tolower $botnick] != [string tolower $rest]} {
     pushmode $channel -o $rest
     putlog "\[!4ckc\] <<$nick>> !$hand! deop $rest"
    }
   }
  }
 }
 if {[botisop $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped, sorry."
 }
}
## public cmd deop -- stop

## public cmd topic -- start
proc pub_topic {nick uhost hand channel rest} {
 global botnick topicnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest!=""} {
  if {[botisop $channel]==1} {
   if {$topicnick == 0} {
     putserv "TOPIC $channel :$rest"
     putlog "\[!4ckc\] <<$nick>> !$hand! topic $rest" 
   } else {
     putserv "TOPIC $channel :$rest (${hand})" 
     putlog "\[!4ckc\] <<$nick>> !$hand! topic $rest" 
   } 
  }
 if {[botisop $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped" }
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: topic <topic>"
 }
}
## public cmd topic -- stop

## public cmd act -- start
proc pub_act {nick uhost hand channel rest} {
 if {$rest!=""} {
  putserv "PRIVMSG $channel :\001ACTION $rest\001"
  putlog "\[!4ckc\] <<$nick>> !$hand! act $rest"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: act <msg>"
 }
}
## public cmd act -- stop

## public cmd say -- start
proc pub_say {nick uhost hand channel rest} {
 if {$rest!=""} {
  puthelp "PRIVMSG $channel :$rest"
  putlog "\[!4ckc\] <<$nick>> !$hand! say $rest"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: say <msg>"
 }
}
## public cmd say -- stop

## public cmd msg -- start
proc pub_msg {nick uhost hand channel rest} {
 set person [lindex $rest 0] 
 set rest [lrange $rest 1 end]
 if {$rest!=""} {
  puthelp "PRIVMSG $person :$rest"
  putlog "\[!4ckc\] <<$nick>> !$hand! msg $rest"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: msg <nick> <msg>"
 }
}
## public cmd msg -- stop

## public cmd ckC -- start
proc pub_ckC {nick uhost hand channel rest} {
 set person [lindex $rest 0] 
 set rest [lrange $rest 1 end]
 if {$rest!=""} {
  puthelp "PRIVMSG $person :$rest. 4,4!¿?¡!¿?¡0,4RED4,4!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?"
  puthelp "NOTICE $person :$rest. 4,4!¿?¡!¿?¡0,4RED4,4!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?"
  puthelp "PRIVMSG $person :$rest. 8,8!¿?¡!¿?¡0,8YELLOW8,8!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿"
  puthelp "NOTICE $person :$rest. 8,8!¿?¡!¿?¡0,8YELLOW8,8!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿"
  puthelp "PRIVMSG $person :$rest. 9,9!¿?¡!¿?¡0,9GREEN9,9!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿"
  puthelp "NOTICE $person :$rest. 9,9!¿?¡!¿?¡0,9GREEN9,9!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿?¡!¿"
  putlog "\[!4ckc\] <<$nick>> !$hand! ckC $person"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ckC <nick> <*add your insult to injury is better*>"
 }
}
## public cmd msg -- stop

## public cmd motd -- start
proc pub_motd {nick uhost hand channel rest} {
 global newpath botnick version vers admin network
 set mfile "${newpath}alt.motd"
 if {![file exists $mfile]} {
   set new [open $mfile w]
   putserv "NOTICE $nick :I am $botnick, running v[lindex $version 0] with ck4C.tcl v${vers}"
   puts $new "I am $botnick, running v[lindex $version 0] with ck4C.tcl v${vers}"
   putserv "NOTICE $nick :Admin: $admin"  
   puts $new "Admin: $admin"
   regsub -all " " [channels] ", " chans
   putserv "NOTICE $nick :Located: $chans on $network"
   puts $new "Located: $chans on $network"
   close $new 
 } else {
   set info [fileinfo $mfile]
   set info [lrange $info 0 2]
   foreach x $info {
     putserv "NOTICE $nick :$x"
   }
 }
}
## public cmd motd -- stop

## public cmd addlog -- start
proc pub_addlog {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: addlog <msg>"
 }
 if {$rest!=""} {
  putlog "\[!4ckc\] $hand: $rest"
 }
}
## public cmd addlog -- stop

## public cmd invite -- start
proc pub_invite {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set rest [lindex $rest 0]
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: invite <nick>"
 }
 if {$rest!=""} {
  if {[onchan $rest $chan]==0} {
   putserv "INVITE $rest :$chan"
   puthelp "NOTICE $nick :\[!4ckc\] Invitation to $chan has been sent to $rest" 
   putlog "\[!4ckc\] <<$nick>> !$hand! invite $rest"
   return 0
  }
  if {[onchan $rest $chan]==1} {
   puthelp "NOTICE $nick :\[!4ckc\] $rest is already on the channel"
  }
 }
}
## public cmd invite -- stop

## public cmd nick -- start
proc pub_nick {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set rest [lindex $rest 0]
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: nick <new nick on bot>"
 }
 if {$rest!=""} {
  chnick $hand $rest
  puthelp "NOTICE $nick :\[!4ckc\] Your partyline handle is now [nick2hand $nick $chan]" 
  putlog "\[!4ckc\] <<$nick>> !$hand! nick $rest"
  return 0
 }
}
## public cmd nick -- stop

## Away stuff ##
set idle.v "ck4C AntiIdle Technology"
set idle.1 10
set idle.w "$botnick"
set idle.m "!ping"
if {![info exists idle.l]} {
  global idle.w idle.m idle.1
  set idle.l 0
  timer ${idle.1} {idle.a}
  putlog "\[!4ckc\] Loading ${idle.v}..."
}

proc idle.a {} {
  global idle.w idle.m idle.1
  putserv "PRIVMSG ${idle.w} ${idle.m}"
  putserv "PRIVMSG [lindex ${idle.w} 0] :\001PING [unixtime]\001"
  timer ${idle.1} {idle.a}
}

set awaym {
 "check mail! <7.17PM>"
 "phonecall! <9.21PM>"
 "browsing! <5.17PM>"
 "in the toilet! <6.18AM>"
 "sleeping! <11.23PM>"
 "pretending! <1.13AM>"
 "looking for ckC! <3.15PM>"
 "A.F.K! <4.16PM>"
 "pool's time! <2.14PM>"
 "dating with cokkie! <8.20AM>"
 "not here! <10.22AM>"
 "gone! <12.24PM>"
 "R.I.P! <0.00AM>"
 "ignoring -pcntikd *!*@* <24HOURS>"
}
 
timer 5 idleaway
proc idleaway {} {
 global awaym
 set awaymsg [lindex $awaym [rand [llength $awaym]]]
 putserv "AWAY :$awaymsg"
 timer [expr [rand 30] + 2] idleaway2
}
proc idleaway2 {} {
 global awaym
 putserv "BACK"
 set awaymsg [lindex $awaym [rand [llength $awaym]]]
 putserv "AWAY :$awaymsg"
 timer [expr [rand 45] + 2] idleaway3
}
proc idleaway3 {} {
 global awaym
 putserv "BACK"
 set awaymsg [lindex $awaym [rand [llength $awaym]]]
 putserv "AWAY :$awaymsg"
 timer [expr [rand 15] + 2] idleaway
}
#

## public cmd chat -- start
proc pub_chat {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] Chat is only available via dcc chat"
}
## public cmd chat -- stop

## public cmd note -- start
proc pub_note {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set reciever [lindex $rest 0]
 set rest [lrange $rest 1 end]
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: note <hand> <note>"
 }
 if {$rest!=""} {
  set notetest [sendnote $hand $reciever $rest]
  if {$notetest==1} {
   puthelp "NOTICE $nick :\[!4ckc\] Note to $reciever was recieved"
  }
  if {$notetest==2} {
   puthelp "NOTICE $nick :\[!4ckc\] Note to $reciever was stored \[local\]"
  }
  if {$notetest==3} {
   puthelp "NOTICE $nick :\[!4ckc\] ${reciever}'s mailbox was full"
  }
  if {$notetest==4} {
   puthelp "NOTICE $nick :\[!4ckc\] Tcl binding intercepted the note"
  }
  if {$notetest==5} {
   puthelp "NOTICE $nick :\[!4ckc\] $reciever was away, note stored"
  }
  if {$notetest==0} {
   puthelp "NOTICE $nick :Send to $reciever failed" 
   return 0
  }
  putlog "\[!4ckc\] <<$nick>> !$hand! note $reciever *masked*"
 }
}
## public cmd chat -- stop

## public cmd files -- start
proc pub_files {nick uhost hand chan rest} {
 global botnick
 global sizeoffile
 set wowfiles [getfiles /]
 set wowdirs [getdirs /]
 if {$wowfiles!=""} {
 set z 0
 puthelp "NOTICE $nick :\[!4ckc\] $botnick is offering [llength $wowfiles] packs, type .get \[X\] to recieve a file" 
 foreach x $wowfiles { 
  set z [expr $z+1]
  set sizeoffile [string trim [exec du dcc/$x] dcc/$x]
   if {[expr $sizeoffile/1024]!=0} {
    set sizeofthefile \[[expr $sizeoffile/1024]MB\]
    while {[string length $sizeofthefile]<7} {
     set sizeofthefile " $sizeofthefile"
    } 
   }  
   if {[expr $sizeoffile/1024]==0} { 
    set sizeofthefile \[${sizeoffile}k\]
    while {[string length $sizeofthefile]<8} {
     set sizeofthefile " $sizeofthefile"
    }
   }
   set wowfiles "${sizeofthefile}  $x"
   if {$z<10} {
    set z " $z"
   }
   puthelp "NOTICE $nick :\[!4ckc\] $z) $wowfiles"
  }
 }
 if {$wowfiles==""} {set wowfiles "No files available"}  
 if {$wowdirs==""} {set wowdirs "No directories available"}
 if {$wowfiles=="No files available"} {
  puthelp "NOTICE $nick :\[!4ckc\] Files: $wowfiles"
 }
 puthelp "NOTICE $nick :\[!4ckc\] Directories: $wowdirs"
 puthelp "NOTICE $nick :\[!4ckc\] Many more commands available via dcc chat" 
 putlog "\[!4ckc\] <<$nick>> !$hand! files"
 return 0
}
## public cmd files -- stop

## public cmd newpass -- start
proc pub_newpass {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] Newpass: For some reason, I think not"
}
## public cmd newpass -- stop

## public cmd console -- start
proc pub_console {nick uhost hand chan rest} {
 puthelp "NOTICE $nick :\[!4ckc\] Console is only available via dcc chat"
}
## public cmd console -- stop

## public cmd servers -- start
proc pub_servers {nick uhost hand chan rest} {
 global server
 puthelp "NOTICE $nick :\[!4ckc\] Server: Current Server is $server"
 putlog "\[!4ckc\] <<$nick>> !$hand! servers"
 return 0
}
## public cmd servers -- stop

## publuc cmd quit -- strt
proc pub_quit {nick uhost hand channel rest} {
puthelp "NOTICE $nick :\[!4ckc\] quit is only available via dcc chat."
}
## public cmd quit -- stop

## public cmd k -- start
proc pub_k {nick uhost hand channel rest} { 
 global CC botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}k <nick> \[reason\]"
 }
 if {$rest!=""} {
  pub_kick $nick $uhost $hand $channel $rest 
 }
}
## public cmd k -- stop

## public cmd kick -- start
proc pub_kick {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: kick <nick> \[reason\]"
   return 0
  }
  set handle [lindex $rest 0]
  set reason [lrange $rest 1 end]
  if {![onchan $handle $channel]} {
   puthelp "NOTICE $nick :\[!4ckc\] $handle is not on the channel!"
   return 0
  }
  if {[onchansplit $handle $channel]} {
   puthelp "NOTICE $nick :\[!4ckc\] $handle is currently net-split."
   return 0
  }
  if {$reason == ""} {
   set reason "requested!" 
  }   
  if {[string tolower $handle] == [string tolower $botnick]} {
   putserv "KICK $channel $nick :(k) do NOT mess with $botnick! -ck4C-"
   return 0
  } else {
   if {[matchattr $handle n] == 1} {
    putserv "KICK $channel $nick :(k) do NOT mess with my owner! -ck4C-"
   return 0
   } else {
    putserv "KICK $channel $handle :(k) $reason -ck4C-"
    if {$reason == ""} {set reason "requested!"}
    putcmdlog "\[!4ckc\] #$hand# kick $handle $reason"
    return 0
   }
  }
 }
 if {[botisop $channel]==0} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## dcc cmd kick -- stop

## public cmd mdeop -- start
proc cmd_mdeop {hand idx arg} {
 global botnick
 set args [lindex $arg 0]
 if {$args == ""} {
  putdcc $idx "\[!4ckc\] Usage: mdeop <#channel>"
 }
 if {$args != ""} {  
  dcc_massdeop $hand $idx $arg
 }
}
## public cmd mdeop -- stop

## public cmd mop -- start
proc cmd_mop {hand idx arg} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set args [lindex $arg 0]
 if {$args == ""} {
  putdcc $idx "\[!4ckc\] Usage: mop <#channel>"
 }
 if {$args != ""} {
  dcc_massop $hand $idx $arg
 }
}
## public cmd mop -- stop

## public cmd massdeop -- start
proc pub_massdeop {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set deopnicks ""
 set mass 1
 if {$mass==1} {
  set deopnicks ""
  set massdeop 0
  set members [chanlist $chan]
  foreach x $members {
   if {([isop $x $chan] == 1) && ([onchansplit $x $chan] == 0) && ($x != $botnick) && ($x != $hand)} {
    if {$massdeop < 6} {
     append deopnicks " $x"
     set massdeop [expr $massdeop + 1]
    }
    if {$massdeop == 6} {
     set massdeop 0
     putserv "MODE $chan -oooooo $deopnicks"
     set deopnicks ""
     append deopnicks " $x"
     set massdeop 1
    }
   }
  }
  putserv "MODE $chan -oooooo $deopnicks"
  putlog "\[!4ckc\] #$hand# massdeop"
 }
}
## public cmd massdeop -- stop

## public cmd massop -- start
proc pub_massop {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set deopnicks ""
 set mass 1
 if {$mass == 1} {
  set opnicks ""
  set massops 0
  set members [chanlist $chan]
  foreach x $members {
   if {([isop $x $chan] == 0) && ([onchansplit $x $chan] == 0) && ($x != $botnick)} {
    if {$massops < 6} {
     append opnicks " $x"
     set massops [expr $massops + 1]
    }
    if {$massops == 6} {
     set massops 0
     pushmode $chan +oooooo $opnicks
     set opnicks ""
     append opnicks " $x"
     set massops 1
    }
   }
  }
  pushmode $chan +oooooo $opnicks
  putlog "\[!4ckc\] #$hand# massop"
 }
}
## public cmd massop -- stop

## dcc cmd massdeop -- start
proc dcc_massdeop {hand idx arg} {
 global botnick
 set deopnicks ""
 set mass 1
 set chan [lindex $arg 0]
 if {$chan == ""} {
  putdcc $idx "\[!4ckc\] Usage: massdeop <#channel>"
  return 1
 }
 if {$mass==1} {
  set deopnicks ""
  set massdeop 0
  set members [chanlist $chan]
  foreach x $members {
   if {([isop $x $chan] == 1) && ([onchansplit $x $chan] == 0) && ($x != $botnick) && ($x != $hand)} {
    if {$massdeop < 6} {
     append deopnicks " $x"
     set massdeop [expr $massdeop + 1]
    }
    if {$massdeop == 6} {
     set massdeop 0
     putserv "MODE $chan -oooooo $deopnicks"
     set deopnicks ""
     append deopnicks " $x"
     set massdeop 1
    }
   }
  }
  putserv "MODE $chan -oooooo $deopnicks"
  putlog "\[!4ckc\] #$hand# massdeop"
 }
}
## dcc cmd massdeop -- stop

## dcc cmd massop -- start
proc dcc_massop {hand idx arg} {
 global botnick
 set deopnicks ""
 set mass 1
 set chan [lindex $arg 0]
 if {$chan == ""} {
  putdcc $idx "\[!4ckc\] Usage: massop <#channel>"
  return 1
 }
 if {$mass == 1} {
  set opnicks ""
  set massops 0
  set members [chanlist $chan]
  foreach x $members {
   if {([isop $x $chan] == 0) && ([onchansplit $x $chan] == 0) && ($x != $botnick)} {
    if {$massops < 6} {
     append opnicks " $x"
     set massops [expr $massops + 1]
    }
    if {$massops == 6} {
     set massops 0
     pushmode $chan +oooooo $opnicks
     set opnicks ""
     append opnicks " $x"
     set massops 1
    }
   }
  }
  pushmode $chan +oooooo $opnicks
  putlog "\[!4ckc\] #$hand# massop"
 }
}
## dcc cmd massop -- stop

## public cmd kickban -- start
proc pub_kickban  {nick uhost hand channel rest} {
 global botnick CC ban-time
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}kickban <nick> \[reason\]"
   return 0
  }
  if {$rest!=""} {
   set handle [lindex $rest 0]
   set reason [lrange $rest 1 end]
   append userhost $handle "!*" [getchanhost $handle $channel]
   set hostmask [maskhost $userhost]
   if {![onchan $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is not on the channel."
    return 0
   }
   if {[onchansplit $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is currently net-split."
    return 0
   }
   if {[string tolower $handle] == [string tolower $botnick]} {
    putserv "KICK $channel $nick :(k) do NOT mess with $botnick! -ck4C-"
    return 0
   }    
   if {$reason == ""} { 
    set reason "requested!" 
   }
   set options [lindex $reason 0]
   if {[string index $options 0] == "-"} {
     set options [string range $options 1 end]
   }
   switch -exact  $options {
     perm {
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" 0
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
           }
     min {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [lindex $reason 1]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
          }
     hours {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [lindex $reason 1]*60]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
     }
     days {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [lindex $reason 1]*60]*24]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
     }
     weeks {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [expr [lindex $reason 1]*60]*24]*7]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
     }
   }
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" $ban-time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(k) $reason -ck4C-"
             return 0
  } 
 }
 if {[isop $botnick $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## public cmd kickban -- stop

## public cmd kb -- start
proc pub_kb  {nick uhost hand channel rest} {
 global botnick CC
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel]==1} {
  if {$rest == ""} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: ${CC}kb <nick> \[reason\]"
   return 0
  }
  if {$rest!=""} {
   set handle [lindex $rest 0]
   set reason [lrange $rest 1 end]
   append userhost $handle "!*" [getchanhost $handle $channel]
   set hostmask [maskhost $userhost]
   if {![onchan $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is not on the channel."
    return 0
   }
   if {[onchansplit $handle $channel]} {
    puthelp "NOTICE $nick :\[!4ckc\] $handle is currently net-split."
    return 0
   }
   if {[string tolower $handle] == [string tolower $botnick]} {
    putserv "KICK $channel $nick :(k) u should NOT try that! -ck4C-"
    return 0
   }    
   if {$reason == ""} { 
    set reason "requested!" 
   }
   set options [lindex $reason 0]
   if {[string index $options 0] == "-"} {
     set options [string range $options 1 end]
   }
   switch -exact  $options {
     perm {
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" 0
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
           }
     min {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [lindex $reason 1]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
          }
     hours {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [lindex $reason 1]*60]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
     }
     days {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [lindex $reason 1]*60]*24]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
     }
     weeks {
             if {[val [lindex $reason 1]] == ""} {
               puthelp "NOTICE $nick :\[!4ckc\] Error, invalid time period"
               return 0
             }
             set time [expr [expr [expr [lindex $reason 1]*60]*24]*7]
             set reason [lrange $reason 2 end]
             newchanban $channel $hostmask $nick "$reason" $time
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
     }
   }
             set reason [lrange $reason 1 end]
             newchanban $channel $hostmask $nick "$reason" 0
             if {$reason == ""} {set reason "requested!"}
             putlog "\[!4ckc\] <<$nick>> !$hand! kicban $channel $hostmask $options $reason"
             putserv "KICK $channel $handle :(kb) $reason -ck4C-"
             return 0
  } 
 }
 if {[isop $botnick $channel]!=1} {
  puthelp "NOTICE $nick :\[!4ckc\] I am not oped"
 }
}
## public cmd ban -- stop

## public cmd info -- start
proc pub_info {nick uhost hand chan rest} {
 global botnick
# puthelp "NOTICE $nick :\[!4ckc\] This command is only available via dcc chat"
# return 0
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {$rest==""} {
 set wowthatinfo [getuser $hand INFO]
 if {$wowthatinfo==""} {set wowthatinfo "No info is set"}
  puthelp "NOTICE $nick :\[!4ckc\] Info: $wowthatinfo"
  putlog "\[!4ckc\] <<$nick>> !$hand! info"
  return 0
 }
 if {$rest!=""} {
  if {[string toupper $rest]=="NONE"} {
   setuser $hand info ""
   puthelp "NOTICE $nick :\[!4ckc\] Your info has been cleared"
   putlog "\[!4ckc\] <<$nick>> !$hand! info none"
   return 0
  }
  if {[string toupper $rest]!="NONE"} {
   setuser $hand info $rest
   puthelp "NOTICE $nick :\[!4ckc\] Your info is now $rest"
   putlog "\[!4ckc\] <<$nick>> !$hand! info $rest"
   return 0
  }
 }
}
## public cmd info -- stop

## public cmd get -- start
proc pub_get {nick uhost hand chan rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 set rest [lindex $rest 0]
 if {$rest==""} {
  puthelp "NOTICE $nick :\[!4ckc\] Usage: get <file #>"
 }
 if {$rest!=""} {
  set f 0
  if {[catch {set numberoffile [expr $rest-1]}]==1} {
   puthelp "NOTICE $nick :\[!4ckc\] Usage: get <file #>"
   return 0
  }
  foreach x [getfiles /] {
   if {$x==[lrange [getfiles /] $numberoffile $numberoffile]} {
    set f 1
   } 
  }
  if {$f==1} {
   puthelp "NOTICE $nick :\[!4ckc\] Sending you [lrange [getfiles /] $numberoffile $numberoffile]" 
   dccsend dcc/[lrange [getfiles /] $numberoffile $numberoffile] $nick
   putlog "\[!4ckc\] <<$nick>> !$hand! get $rest"
   return 0
  } 
  if {$f!="1"} {
   puhelp "NOTICE $nick :\[!4ckc\] Incorrect file number"
  }
 }
}
## public cmd get -- stop

## dcc cmd userlist -- start
proc cmd_userlist {hand idx args} {
 set args [lindex $args 0]
 set f [lindex $args 0]
 if {[userlist $f] ==""} {
  putdcc $idx "\[!4ckc\] No users with flag(s) $f."
  putcmdlog "\[!4ckc\] #$hand# userlist $f"
  return 0
 }
 if {[userlist $f] !=""} {
  regsub -all " " [userlist $f]  ", " userlist
  putdcc $idx "\[!4ckc\] Userlist: $userlist"
  putcmdlog "\[!4ckc\] #$hand# userlist $f"
  return 0
 }
}
## dcc cmd userlist -- stop

## public cmd userlist -- start
proc pub_userlist {nick uhost hand chan rest} {
 set rest [lindex $rest 0]
 set f [lindex $rest 0]
 if {[userlist $f] ==""} {
  puthelp "NOTICE $nick :\[!4ckc\] No users with flag(s) \[$f\]"
  putlog "\[!4ckc\] <<$nick>> !$hand! userlist $f"
}
if {[userlist $f] !=""} {
 set tester $f
 if {$tester!=""} {set tester " \[$tester\]"}
  regsub -all " " [userlist $f]  ", " userlist 
  puthelp "NOTICE $nick :\[!4ckc\] Userlist$tester: $userlist"
  putlog "\[!4ckc\] <<$nick>> !$hand! userlist $f"
 }
}
## public cmd userlist -- stop

## public cmd ping -- start
proc pub_ping {nick uhost hand chan rest} {
 global botnick
 set cmd [string tolower [lindex $rest 0]]
 puthelp "PRIVMSG $chan :${nick}, PONG"
 putlog "\[!4ckc\] <<$nick>> !$hand! ping"
}
## public cmd ping -- stop

## public cmd pong -- start
proc pub_pong {nick uhost hand chan rest} {
 global botnick
 set cmd [string tolower [lindex $rest 0]]
 puthelp "PRIVMSG $chan :${nick}, PING"
 putlog "\[!4ckc\] <<$nick>> !$hand! pong"
}
## public cmd pong -- stop

## dcc cmd channels -- start
proc cmd_channels {hand idx args} {
 putdcc $idx "\[!4ckc\] Channels: [channels]"
 putcmdlog "\[!4ckc\] #$hand# channels"
}
## dcc cmd channels --- stop

## dcc cmd global -- start
proc cmd_global {hand idx args} {
 set gsay [lindex $args 0]
 global botnick
 if {$gsay!=""} {
  dccbroadcast "GLOBAL <${hand}@${botnick}> : $gsay"
  putcmdlog "\[!4ckc\]  #$hand# global $gsay"
 }
 if {$gsay==""} {
 putdcc $idx "\[!4ckc\] Usage: global <msg>"
 }
}
## dcc global -- stop

## dcc cmd flagnote -- start
 set oldflags "c d f j k m n o p x t h a v q"
 set botflags "a b h l r s p"

proc cmd_flagnote {hand idx arg} {
 global oldflags botflags
 set whichflag [lindex $arg 0]
 set message [lrange $arg 1 end]
 if {$whichflag == "" || $message == ""} {
  putdcc $idx "\[!4ckc\] Usage: flagnote <flag> <msg>"
  return 0
 }
 if {[string index $whichflag 0] == "+"} {
  set whichflag [string index $whichflag 1]
 }
 set normwhichflag [string tolower $whichflag]
 set boldwhichflag \[+$normwhichflag\]
 if {([lsearch -exact $botflags $normwhichflag] > 0)} {
  putdcc $idx "\[!4ckc\] The flag $boldwhichflag is for bots only"
  putdcc $idx "\[!4ckc\] Choose from the following: $oldflags $newflags"
  return 0
 }
 if {([lsearch -exact $oldflags $normwhichflag] < 0) && ([lsearch -exact $botflags $normwhichflag] < 0)} {
  putdcc $idx "\[!4ckc\] The flag $boldwhichflag is not a defined flag"
  putdcc $idx "\[!4ckc\] Choose from the following: $oldflags"
  return 0
 }
 putlog "\[!4ckc\] #$hand# flagnote [string tolower \[+$whichflag\]] ..."
 putdcc $idx "\[!4ckc\]  Sending FlagNote to all $boldwhichflag users"
 foreach user [userlist $normwhichflag] {
  if {(![matchattr $user b])} {
   sendnote $hand $user "$whichflag $message"
  }
 }
}
## dcc cmd flagnote -- stop

## public cmd time -- start
proc pub_time {nick uhost hand chan rest} {
 global timezone
 set fronttime [string range [time] 0 1]
 set backtime [string range [time] 2 4]
 if {$fronttime == "00"} {
  puthelp "NOTICE $nick :\[!4ckc\] The current time is 12$backtime AM $timezone"
  putlog "\[!4ckc\] <<$nick>> !$hand! time"
  return 0
 }
 if {$fronttime < 12} {
  puthelp "NOTICE $nick :\[!4ckc\] The current time is $fronttime$backtime AM $timezone"
  putlog "\[!4ckc\] <<$nick>> !$hand! time"
  return 0
 }
 if {$fronttime >= 12} {
  putserv "NOTICE $nick :\[!4ckc\] The current time is [expr $fronttime-12]$backtime PM $timezone"
  putlog "\[!4ckc\] <<$nick>> !$hand! time"
  return 0
 }
}
## public cmd time -- stop

## public cmd down -- start
proc pub_down {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel] != 1} {
  puthelp "NOTICE $nick :\[!4ckc\] Im not oped, sorry."
  return 0
 }
 if {[isop $nick $channel] == 1} {
  putlog "\[!4ckc\] <<$nick>> !$hand! down"
  pushmode $channel -o $nick
 } else {
  puthelp "NOTICE $nick :\[!4ckc\] You are already deoped."
  return 0
 }
}
## public cmd down -- stop

## public cmd up -- start
proc pub_up {nick uhost hand channel rest} {
 global botnick
 if {[matchattr $hand Q] == 0} {
  puthelp "NOTICE $nick :\[!4ckc\] This command requires you to authenticate yourself. Please /msg $botnick auth <password>"
  return 0
 }
 if {[botisop $channel] != 1} {
  puthelp "NOTICE $nick :\[!4ckc\] Im not oped, sorry."
  return 0
 }
 if {[isop $nick $channel] == 0} {
  putlog "\[!4ckc\] <<$nick>> !$hand! up"
  pushmode $channel +o $nick
 } else {
  puthelp "NOTICE $nick :\[!4ckc\] You are already oped."
  return 0
 }
}
## public cmd up -- stop

putlog "\[!4ckc\] *** ckC.tcl $vers loaded."


#--------------------------------------------------------
#
#                     !Dns Version 3.1
#                   Scripted by I_strike
#
#
#                   !dns <adresse/host>
#                   !User@host <nick>
#                   !dnsnick <nick>
#                   !amsg <message>
#
#           You can chat with me on #egg-world from Undernet
#               ( /server quebec.qu.ca.undernet.org )
#
#-------------------------------------------------------

# SET THE CHARACTER THAT WILL BE USED BEFORE PUBLIC QUERRIES
# EXAMPLE: "#" => #seen, #op .... DEFAULT: "!"

set dnshost(cmdchar) "!"


#-----------------please don't CHANGE ANY OF THE FOLLOWING LINES----------------------
bind pub - [string trim $dnshost(cmdchar)]dns dns:res
bind pub n|n [string trim $dnshost(cmdchar)]amsg pub:amsg
bind pub - [string trim $dnshost(cmdchar)]User@host pub:host
bind pub - [string trim $dnshost(cmdchar)]version pub:ver
bind pub - [string trim $dnshost(cmdchar)]dnsnick dns:nick
bind raw * 311 raw:host
bind raw * 401 raw:fail

set dns_chan ""
set dns_host ""
set dns_nick ""
set dns_bynick ""

proc pub:host {nick uhost hand chan arg} {
global dns_chan
set dns_chan "$chan"
putserv "WHOIS [lindex $arg 0]"
}

proc raw:host {from signal arg} {
global dns_chan dns_nick dns_host dns_bynick
set dns_nick "[lindex $arg 1]"
set dns_host "*!*[lindex $arg 2]@[lindex $arg 3]"
foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :cKc The User@host of \037\002$dns_nick\017 is \037\002$dns_host\017 ." }
if {$dns_bynick == "oui"} {
                set hostip [split [lindex $arg 3] ]
                dnslookup $hostip resolve_rep $dns_chan $hostip
                set dns_bynick "non"
}
}

proc raw:fail {from signal arg} {
global dns_chan
set arg "[lindex $arg 1]"
foreach dns_say $dns_chan { puthelp "PRIVMSG $dns_say :!4ckc \037\002$arg\017: No such nick." }
}

proc pub:ver {nick uhost hand chan text} {
putserv "PRIVMSG $chan : Dns Resolver 1.0 by cokkie"
}

proc dns:res {nick uhost hand chan text} {
 if {$text == ""} {
            puthelp "privmsg $chan :Syntax: [string trim $dnshost(cmdchar)]dns <host or ip>"
        } else {
                set hostip [split $text]
                dnslookup $hostip resolve_rep $chan $hostip
        }
}

proc dns:nick {nick uhost hand chan arg} {
global dns_chan dns_bynick dnshost
 if {$arg == ""} {
 puthelp "privmsg $chan :Syntax: [string trim $dnshost(cmdchar)]dnsnick <nick>"
        } else {
set dns_chan "$chan"
set dns_bynick "oui"
putserv "WHOIS [lindex $arg 0]"
        }
}

proc resolve_rep {ip host status chan hostip} {
        if {!$status} {
                puthelp "privmsg $chan :!4ckc Unable to resolve \037\002$hostip\017 ."
        } elseif {[regexp -nocase -- $ip $hostip]} {
                puthelp "privmsg $chan :!4ckc Resolved \037\002$ip\017 to \037\002$host\017 ."
        } else {
                puthelp "privmsg $chan :!4ckc Resolved \037\002$host\017 to \037\002$ip\017 ."
        }
}

putlog "Dns Resolver 1.0 by cokkie Loaded"

# Begin - Utility, LAG Checker. (utl_ping.tcl)
#	Designed & Written by Unknown
#	Modified and re-coded by TCP-IP (Vicky@Vic.ky), © 2000
#	TCL designed for eggdrop v1.4.x

# Some parts in this TCL was also inspired by simple Anti-Idle script by Shayne Lennox-
# (aidle.tcl v1.1 - www.ozemail.com.au/~slenny/eggdrop/).
# I add new features and re-code this script in purpose to have better performance and flexibility.
# Developing stuffs ;) Thanks again Shayne :D

# This TCL will send CTCP PING to everyone who ever request it. I add new features for-
# reply announcement to the requester when the bot got they ping replied.
# You can either set your bot to notice the requester about the ping reply, either-
# send a message to a particular channel where the requester sent the request from.
# Also, I add new feature for you to send request to your bot, to ping someone else.
# For example, you type !ping Lamer, then the bot will ping anyone who has nick "Lamer".

# Set this to "0" if you like to bot to notice the PING requester about the ping reply.
# If you set this "1", the bot will send message to a channel where the requester is on,
# and the message will contains their ping replies.
set pinginfo 1

# Set this as the request parameter. For example, when you set this to "!", means-
# someone must type !ping on channel to get pinged.
set PINGPRM "!"

# Again, (well, I don't know why I like to keep setting this on ;p), but hey,
# you can either set your own LOGO here, your logo will appear-
# when the bot notice you, or when it makes msgs/notices/kicks or scripts loading.
# So keep smiling and set this variable as you wish ;), you can either set this-
# to "" to leave it blank.
set utlpnglg "\[!4ckc\]:"

######### Please do not edit anything below unless you know what you are doing ;) #########

proc ping_req {nick uhost hand chan arg} {
	global botnick PINGPRM pinginfo pingchan utlpnglg
	if {[isbotnick $arg]} {
		putquick "NOTICE $nick :$utlpnglg Command: PING or ${PINGPRM}PING \[nickname|me\] (I will not ping myself)." ; return 0
	}
	set arg [string toupper $arg]
	if {[string match "#*" $arg]} {
		putquick "NOTICE $nick :$utlpnglg Command: PING or ${PINGPRM}PING \[nickname|me\] (I will not ping \002$arg\002)." ; return 0
	}
	if {$arg == "ME" || $arg == "" || $arg == [string toupper $nick]} {
		putquick "PRIVMSG $nick :\001PING [unixtime]\001"} else {putquick "PRIVMSG $arg :\001PING [unixtime]\001"
	}
	if {$pinginfo} {
		if {![info exist pingchan]} {set pingchan ""} ; append pingchan "$chan "
	} ; return 0
}

proc ping_reply {nick uhost hand dest key arg} {
	global botnick pinginfo pingchan utlpnglg
	if {[isbotnick $nick]} {return 0}
	if {$pinginfo} {set pchan ""
		foreach x $pingchan {
			if {[validchan $x]} {
				if {[onchan $nick $x]} {
					set pchan $x ; set pingchan [string trim $pingchan $x]
				}
			} else {
				putquick "NOTICE $nick :$utlpnglg Your LAG reply are: \002[expr [unixtime] - $arg]\002 sec(s)." ; return 0
			}
		}
		if {$pchan != ""} {
			if {[validchan $pchan]} {
				putquick "PRIVMSG $pchan :$utlpnglg $nick current LAG reply: \002[expr [unixtime] - $arg]\002 sec(s)."
			} else {
				putquick "NOTICE $nick :$utlpnglg Your LAG reply are: \002[expr [unixtime] - $arg]\002 sec(s)."
			}
		} else {
			putquick "NOTICE $nick :$utlpnglg Your LAG reply are: \002[expr [unixtime] - $arg]\002 sec(s)."
		}
	} else {
		putquick "NOTICE $nick :$utlpnglg Your LAG reply are: \002[expr [unixtime] - $arg]\002 sec(s)."
	} ; return 0
}

bind pub -|- ${PINGPRM}ping ping_req
bind pub -|- ping ping_req
bind ctcr - PING ping_reply
putlog "*** ${utlpnglg} Utility, LAG Checker. Loaded."

# End of - !4ckc Utility, LAG Checker. (utl_ping.tcl)

#*****************************************************************************************************************************************************
##
##  Seen TcL special made for ckC Bots ##
##
#*****************************************************************************************************************************************************




#Input is accepted from:
#       pub:  !seen <query> [#chan]
#       msg:  seen <query> [#chan]
#   and dcc:  .seen <query> [#chan]
#
#Queries can be in the following formats (public examples given):
#    'regular' !seen lamer; !seen lamest 		| SmartSearch-enabled query
#    'limited' !seennick lamer				| SmartSearch-bypassed query
#    'masked'  !seen *l?mer*; !seen *.lame.com; !seen *.edu #mychan
#
#Bonus feature:  !lastspoke <nick>
#    You can use wildcard matching for <nick>.  The results for the
#    first match are returned.

###Parameters:

#bs(limit) is the database record limit.
set bs(limit) 90000

#bs(nicksize) is the maximum nickname length (9 on Undernet)
set bs(nicksize) 20

#bs(no_pub) is a list of channels you *don't* want the bot to post public
#  replies to (public queries ignored).  Enter in lower case, eg: #lamer
set bs(no_pub) ""

#bs(quiet_chan) is a list of channels you want replies to requests sent
#  to the person who made the query via notice. (The bot replies to
#  public queries via notice.)  Enter in lower case.
set bs(quiet_chan) ""

#bs(no_log) is a list of channels you *don't* want the bot to log
#  data on.  Enter chans in lower case.
set bs(no_log) ""

#bs(log_only) is a list of channels you *only* want the bot to log
#  data on.  This is the opposite of bs(no_log).  Set it to "" if you
#  want to log new channels the bot joins.  Enter chans in lower case.
set bs(log_only) ""

#bs(cmdchar) is what command character should be used for making public
#  queries.  The default is "!".  Setting it to "" is a valid option.
set bs(cmdchar) "!"

#bs(flood) is used for flood protection, in the form x:y.  Any queries
#  beyond x in y seconds is considered a flood and ignored.
set bs(flood) 4:15
#bs(ignore) is used as a switch for ignoring flooders
set bs(ignore) 1
#bs(ignore_time) is used to define the amount of time a flooder is
#  ignored (minutes).  This is meaningless if bs(ignore) is 0.
set bs(ignore_time) 2

#bs(smartsearch) is a master enable/disable for SmartSearch.  SmartSearch ensures that
#  the most accurate and current results are returned for nick queries. (1=on)
set bs(smartsearch) 1

#bs(logqueries) is used to log DCC/MSG/PUB queries
set bs(logqueries) 1

#bs(path) is used to indicate what path to save the database and backup to.
#  Setting to "" will cause the script to be saved in the same path as the eggdrop executable
#  If you set it, use the full path, and make sure you terminate w/ a "/".
#  eg:  set bs(path) "/usr/home/mydir/blah/"
set bs(path) ""

###### Don't edit below here, even if you do know Tcl ######


if {[bind msg -|- help] != "*msg:help"} {bind msg -|- help *msg:help} ; 
#this is to fix a bind I didn't intend to use in a prev version (which screwed up msg'd help).  Sorry!
proc bs_filt {data} {
  regsub -all -- \\\\ $data \\\\\\\\ data ; regsub -all -- \\\[ $data \\\\\[ data ; regsub -all -- \\\] $data \\\\\] data
  regsub -all -- \\\} $data \\\\\} data ; regsub -all -- \\\{ $data \\\\\{ data ; regsub -all -- \\\" $data \\\\\" data ; return $data
}
proc bs_flood_init {} {
  global bs bs_flood_array ; if {![string match *:* $bs(flood)]} {putlog "$bs(version): var bs(flood) not set correctly." ; return}
  set bs(flood_num) [lindex [split $bs(flood) :] 0] ; set bs(flood_time) [lindex [split $bs(flood) :] 1] ; set i [expr $bs(flood_num) - 1]
  while {$i >= 0} {set bs_flood_array($i) 0 ; incr i -1 ; }} ; bs_flood_init
proc bs_flood {nick uhost} {
  global bs bs_flood_array ; if {$bs(flood_num) == 0} {return 0} ; set i [expr $bs(flood_num) - 1]
  while {$i >= 1} {set bs_flood_array($i) $bs_flood_array([expr $i - 1]) ; incr i -1} ; set bs_flood_array(0) [unixtime]
  if {[expr [unixtime] - $bs_flood_array([expr $bs(flood_num) - 1])] <= $bs(flood_time)} {
    putlog "$bs(version): Flood detected from $nick." ; if {$bs(ignore)} {newignore [join [maskhost *!*[string trimleft $uhost ~]]] $bs(version) flood $bs(ignore_time)} ; return 1  } {return 0}
}
if {[lsearch -exact [bind time -|- "*2 * * * *"] bs_timedsave] > -1} {unbind 
time -|- "*2 * * * *" bs_timedsave} ; #backup frequency can be lower
proc bs_read {} {
  global bs_list userfile bs
  if {![string match */* $userfile]} {set name [lindex [split $userfile .] 0]} {
    set temp [split $userfile /] ; set temp [lindex $temp [expr [llength $temp]-1]] ; set name [lindex [split $temp .] 0]
  }
  if {![file exists $bs(path)bs_data.$name]} {
    if {![file exists $bs(path)bs_data.$name.bak]} {
      putlog "     Old seen data not found!" ; putlog "     If this is the first time you've run the script, don't worry." ; putlog "     If there *should* be a data file from past runs of this script... worry." ; return    } {exec cp $bs(path)bs_data.$name.bak $bs(path)bs_data.$name ; putlog "      Old seen data not found! Using backup data."}  } ; set fd [open $bs(path)bs_data.$name r]
  set bsu_ver "" ; set break 0
  while {![eof $fd]} {
    set inp [gets $fd] ; if {[eof $fd]} {break} ; if {[string trim $inp " "] == ""} {continue}
    if {[string index $inp 0] == "#"} {set bsu_version [string trimleft $inp #] ; continue}
    if {![info exists bsu_version] || $bsu_version == "" || $bsu_version < $bs(updater)} {
      putlog "Updating database to new version of bseen..."
#bugfix (b) - loading the wrong updater version
      if {[source scripts/bseen_updater1.4.2.tcl] != "ok"} {set temp 1} {set temp 0}
      if {$temp || [bsu_go] || [bsu_finish]} {
        putlog "A serious problem was encountered while updating the bseen database."
        if {$temp} {putlog "     The updater script could not be found."}
        putlog "It is *not* safe to run the bot w/ a bseen database that is not matched to this version of bseen."
        putlog "If you can't find the problem, the only option is to remove the bs_data.$name and bs_data.$name.bak files.  Then restart the bot."
        putlog "Because this is a potential crash point in the bot, the bot will now halt." ; die "critical error in bseen encountered"
      } ; set break 1 ; break
    }
    set nick [lindex $inp 0] ; set bs_list([string tolower $nick]) $inp
  } ; close $fd
  if {$break} {bs_read} {putlog "     Done loading [array size bs_list] seen records."}
}

###
#Must check to make sure the version didn't change during a .rehash
proc bs_update {} {
  global bs
  putlog "A new version of bseen is dynamically being loaded."
  putlog "    Verifying the integrity of the database across versions..."
  bs_save ; bs_read
}
set bs(updater) 10402 ; set bs(version) bseen1.4.2c
if {[info exists bs_list]} {
#a rehash was done
  if {[info exists bs(oldver)]} {
    if {$bs(oldver) < $bs(updater)} {bs_update} ;# old ver found
  } {bs_update} ;# pre- 1.4.0
}
set bs(oldver) $bs(updater)
putlog "$bs(version):  -- cokkie's SEEN loaded --"
if {![info exists bs_list] || [array size bs_list] == 0} {putlog "     
Loading seen database..." ; bs_read}
###

bind time - "12 * * * *" bs_timedsave
proc bs_timedsave {min b c d e} {bs_save}
proc bs_save {} {
  global bs_list userfile bs ; if {[array size bs_list] == 0} {return}
  if {![string match */* $userfile]} {set name [lindex [split $userfile .] 0]} {
    set temp [split $userfile /] ; set temp [lindex $temp [expr [llength $temp]-1]] ; set name [lindex [split $temp .] 0]
  }
  if {[file exists $bs(path)bs_data.$name]} {catch {exec cp -f $bs(path)bs_data.$name $bs(path)bs_data.$name.bak}}
  set fd [open $bs(path)bs_data.$name w] ; set id [array startsearch bs_list] ; putlog "Backing up seen data..."
  puts $fd "#$bs(updater)"
  while {[array anymore bs_list $id]} {set item [array nextelement bs_list $id] ; puts $fd "$bs_list($item)"} ; array donesearch bs_list $id ; close $fd
}
#bugfix -- support new PART in egg1.5.x+
if {[string trimleft [lindex $version 1] 0] >= 1050000} {
  bind part -|- * bs_part
} {
  if {[lsearch -exact [bind part -|- *] bs_part] > -1} {unbind part -|- * bs_part}
  bind part -|- * bs_part_oldver
}
proc bs_part_oldver {a b c d} {bs_part $a $b $c $d ""}
#bugfix - new bs_part proc
proc bs_part {nick uhost hand chan reason} {bs_add $nick "[list $uhost] [unixtime] part $chan [split $reason]"}
bind join -|- * bs_join
proc bs_join {nick uhost hand chan} {bs_add $nick "[list $uhost] [unixtime] join $chan"}
bind sign -|- * bs_sign
proc bs_sign {nick uhost hand chan reason} {bs_add $nick "[list $uhost] [unixtime] quit $chan [split $reason]"}
bind kick -|- * bs_kick
proc bs_kick {nick uhost hand chan knick reason} {bs_add $knick "[getchanhost $knick $chan] [unixtime] kick $chan [list $nick] [list $reason]"}
bind nick -|- * bs_nick
proc bs_nick {nick uhost hand chan newnick} {set time [unixtime] ; bs_add $nick "[list $uhost] [expr $time -1] nick $chan [list $newnick]" ; bs_add $newnick "[list $uhost] $time rnck $chan [list $nick]"}
bind splt -|- * bs_splt
proc bs_splt {nick uhost hand chan} {bs_add $nick "[list $uhost] [unixtime] splt $chan"}
bind rejn -|- * bs_rejn
proc bs_rejn {nick uhost hand chan} {bs_add $nick "[list $uhost] [unixtime] rejn $chan"}
bind chon -|- * bs_chon
proc bs_chon {hand idx} {foreach item [dcclist] {if {[lindex $item 3] != "CHAT"} {continue} ; if {[lindex $item 0] == $idx} {bs_add $hand "[lindex $item 2] [unixtime] chon" ; break}}}
if {[lsearch -exact [bind chof -|- *] bs_chof] > -1} {unbind chof -|- * bs_chof} ; #this bind isn't needed any more
bind chjn -|- * bs_chjn
proc bs_chjn {bot hand channum flag sock from} {bs_add $hand "[string trimleft $from ~] [unixtime] chjn $bot"}
bind chpt -|- * bs_chpt
proc bs_chpt {bot hand args} {set old [split [bs_search ? [string tolower $hand]]] ; if {$old != "0"} {bs_add $hand "[join [string trim [lindex $old 1] ()]] [unixtime] chpt $bot"}}

if {[string trimleft [lindex $version 1] 0] > 1030000} {bind away -|- * bs_away}
proc bs_away {bot idx msg} {
  global botnet-nick
  if {$bot == ${botnet-nick}} {set hand [idx2hand $idx]} {return}
  set old [split [bs_search ? [string tolower $hand]]]
  if {$old != "0"} {bs_add $hand "[join [string trim [lindex $old 1] ()]] [unixtime] away $bot [bs_filt [join $msg]]"}
}
bind dcc n|- unseen bs_unseen
proc bs_unseen {hand idx args} {
  global bs_list
  set tot 0 ; set chan [string tolower [lindex $args 0]] ; set id [array startsearch bs_list]
  while {[array anymore bs_list $id]} {
    set item [array nextelement bs_list $id]
    if {$chan == [string tolower [lindex $bs_list($item) 4]]} {incr tot ;lappend remlist $item}
  }
  array donesearch bs_list $id ; if {$tot > 0} {foreach item $remlist {unset bs_list($item)}}
  putlog "$hand removed $chan from the bseen database.  $tot entries removed."
  putidx $idx "$chan successfully removed.  $tot entries deleted from the bseen database."
}
bind bot -|- bs_botsearch bs_botsearch
proc bs_botsearch {from cmd args} {
  global botnick ; set args [join $args]
  set command [lindex $args 0] ; set target [lindex $args 1] ; set nick [lindex $args 2] ; set search [bs_filt [join [lrange $args 3 e]]]
  if {[string match *\\\** $search]} {
    set output [bs_seenmask bot $nick $search]
    if {$output != "No matches were found." && ![string match "I'm not on *" $output]} {putbot $from "bs_botsearch_reply $command \{$target\} {$nick, $botnick says:  [bs_filt $output]}"}
  } {
    set output [bs_output bot $nick [bs_filt [lindex $search 0]] 0]
    if {$output != 0 && [lrange [split $output] 1 4] != "I don't remember seeing"} {putbot $from "bs_botsearch_reply $command \{$target\} {$nick, $botnick says:  [bs_filt $output]}"}
  }
}
if {[info exists bs(bot_delay)]} {unset bs(bot_delay)}
bind bot -|- bs_botsearch_reply bs_botsearch_reply
proc bs_botsearch_reply {from cmd args} {
  global bs ; set args [join $args]
  if {[lindex [lindex $args 2] 5] == "not" || [lindex [lindex $args 2] 4] == "not"} {return}
  if {![info exists bs(bot_delay)]} {
    set bs(bot_delay) on ; utimer 10 {if {[info exists bs(bot_delay)]} {unset bs(bot_delay)}}
    if {![lindex $args 0]} {putdcc [lindex $args 1] "[join [lindex $args 2]]"} {puthelp "[lindex $args 1] :[join [lindex $args 2]]"}
  }
}
bind dcc -|- seen bs_dccreq1
bind dcc -|- seennick bs_dccreq2
proc bs_dccreq1 {hand idx args} {bs_dccreq $hand $idx $args 0}
proc bs_dccreq2 {hand idx args} {bs_dccreq $hand $idx $args 1}
proc bs_dccreq {hand idx args no} {
  set args [bs_filt [join $args]] ; global bs
  if {[string match *\\\** [lindex $args 0]]} {
    set output [bs_seenmask dcc $hand $args]
    if {$output == "No matches were found."} {putallbots "bs_botsearch 0 $idx $hand $args"}
    if {[string match "I'm not on *" $output]} {putallbots "bs_botsearch 0 $idx $hand $args"}
    putdcc $idx $output ; return $bs(logqueries)
  }
  set search [bs_filt [lindex $args 0]]
  set output [bs_output dcc $hand $search $no]
  if {$output == 0} {return 0}
  if {[lrange [split $output] 1 4] == "!4ckc Gue enggak pernah liat tuh"} {putallbots "bs_botsearch 0 $idx $hand $args"}
  putdcc $idx "$output" ; return $bs(logqueries)
}
bind msg -|- seen bs_msgreq1
bind msg -|- seennick bs_msgreq2
proc bs_msgreq1 {nick uhost hand args} {bs_msgreq $nick $uhost $hand $args 0}
proc bs_msgreq2 {nick uhost hand args} {bs_msgreq $nick $uhost $hand $args 1}
proc bs_msgreq {nick uhost hand args no} {
  if {[bs_flood $nick $uhost]} {return 0} ; global bs
  set args [bs_filt [join $args]]
  if {[string match *\\\** [lindex $args 0]]} {
    set output [bs_seenmask msg $nick $args]
    if {$output == "No matches were found."} {putallbots "bs_botsearch 1 \{notice $nick\} $nick $args"}
    if {[string match "I'm not on *" $output]} {putallbots "bs_botsearch 1 \{notice $nick\} $nick $args"}
    puthelp "notice $nick :$output" ; return $bs(logqueries)
  }
  set search [bs_filt [lindex $args 0]]
  set output [bs_output $search $nick $search $no]
  if {$output == 0} {return 0}
  if {[lrange [split $output] 1 4] == "!4ckc Gue enggak pernah list tuh"} {putallbots "bs_botsearch 1 \{notice $nick\} $nick $args"}
  puthelp "notice $nick :$output" ; return $bs(logqueries)
}
bind pub -|- [string trim $bs(cmdchar)]seen bs_pubreq1
bind pub -|- [string trim $bs(cmdchar)]seennick bs_pubreq2
proc bs_pubreq1 {nick uhost hand chan args} {bs_pubreq $nick $uhost $hand $chan $args 0}
proc bs_pubreq2 {nick uhost hand chan args} {bs_pubreq $nick $uhost $hand $chan $args 1}
proc bs_pubreq {nick uhost hand chan args no} {
  if {[bs_flood $nick $uhost]} {return 0}
  global botnick bs ; set i 0
  if {[lsearch -exact $bs(no_pub) [string tolower $chan]] >= 0} {return 0}
  if {$bs(log_only) != "" && [lsearch -exact $bs(log_only) [string tolower $chan]] == -1} {return 0}
  set args [bs_filt [join $args]]
  if {[lsearch -exact $bs(quiet_chan) [string tolower $chan]] >= 0} {set target "notice $nick"} {set target "privmsg $chan"}
  if {[string match *\\\** [lindex $args 0]]} {
    set output [bs_seenmask $chan $hand $args]
    if {$output == "No matches were found."} {putallbots "bs_botsearch 1 \{$target\} $nick $args"}
    if {[string match "I'm not on *" $output]} {putallbots "bs_botsearch 1 \{$target\} $nick $args"}
    puthelp "$target :$output" ; return $bs(logqueries)
  }
  set data [bs_filt [string trimright [lindex $args 0] ?!.,]]
  if {[string tolower $nick] == [string tolower $data] } {puthelp "$target :!4ckc $nick, elo khan ada di sini sekarang." ; return $bs(logqueries)}
  if {[string tolower $data] == [string tolower $botnick] } {puthelp "$target :!4ckc $nick, Gue ada disini, kenapa .. mau di jitak ??" ; return $bs(logqueries)}
  if {[onchan $data $chan]} {puthelp "$target :!4ckc $nick, $data ada disini sekarang !" ; return $bs(logqueries)}
  set output [bs_output $chan $nick $data $no] ; if {$output == 0} {return 0}
  if {[lrange [split $output] 1 4] == "Gue enggak pernah liat tuh"} {putallbots "bs_botsearch 1 \{$target\} $nick $args"}
  puthelp "$target :$output" ; return $bs(logqueries)
}
proc bs_output {chan nick data no} {
  global botnick bs version bs_list
  set data [string tolower [string trimright [lindex $data 0] ?!.,]]
  if {$data == ""} {return 0}
  if {[string tolower $nick] == $data} {return [concat !4ckc $nick, elo khan ada disini sekarang.]}
  if {$data == [string tolower $botnick]} {return [concat $nick, Gue ada disini, kenapa .. mau di jitak ??]}
  if {[string length $data] > $bs(nicksize)} {return 0}
  if {$bs(smartsearch) != 1} {set no 1}
  if {$no == 0} {
    set matches "" ; set hand "" ; set addy ""
    if {[lsearch -exact [array names bs_list] $data] != "-1"} {
      set addy [lindex $bs_list([string tolower $data]) 1] ; set hand [finduser $addy]
      foreach item [bs_seenmask dcc ? [maskhost $addy]] {if {[lsearch -exact $matches $item] == -1} {set matches "$matches $item"}}
    }
    if {[validuser $data]} {set hand $data}
    if {$hand != "*" && $hand != ""} {
      if {[string trimleft [lindex $version 1] 0]>1030000} {set hosts [getuser $hand hosts]} {set hosts [gethosts $hand]}
      foreach addr $hosts {
        foreach item [string tolower [bs_seenmask dcc ? $addr]] {
          if {[lsearch -exact [string tolower $matches] [string tolower $item]] == -1} {set matches [concat $matches $item]}
        }
      }
    }
    if {$matches != ""} {
      set matches [string trimleft $matches " "]
      set len [llength $matches]
      if {$len == 1} {return [bs_search $chan [lindex $matches 0]]}
      if {$len > 99} {return [concat !4ckc Ada $len yang cocok di database, tolong sebutkan permintaan anda lebih spesifik.]}
      set matches [bs_sort $matches]
      set key [lindex $matches 0]
      if {[string tolower $key] == [string tolower $data]} {return [bs_search $chan $key]}
      if {$len <= 5} {
        set output [concat !4ckc Ada $len orang yang cocok nih (sorted): [join $matches].]
        set output [concat $output  [bs_search $chan $key]] ; return $output
      } {
        set output [concat !4ckc Ada $len orang yang cocok nih. Ini 5 orang yang terakhir (sorted): [join [lrange $matches 0 4]].]
        set output [concat $output  [bs_search $chan $key]] ; return $output
      }
    }
  }
  set temp [bs_search $chan $data]
  if {$temp != 0} { return $temp } {
    #$data not found in $bs_list, so search userfile
    if {![validuser [bs_filt $data]] || [string trimleft [lindex $version 1] 0]<1030000} {
      return "!4ckc $nick, Gue enggak pernah tuh liat $data."
    } {
      set seen [getuser $data laston]
      if {[getuser $data laston] == ""} {return "$nick, Gue enggak pernah liat tuh $data."}
      if {($chan != [lindex $seen 1] || $chan == "bot" || $chan == "msg" || $chan == "dcc") && [validchan [lindex $seen 1]] && [lindex [channel info [lindex $seen 1]] 23] == "+secret"} {
        set chan "-secret-"
      } {
        set chan [lindex $seen 1]
      }
      return [concat !4ckc $nick, $data terakhir gue liat dia ada di $chan [bs_when [lindex $seen 0]] yang lalu.]
    }
  }
}
proc bs_search {chan n} {
  global bs_list ; if {![info exists bs_list]} {return 0}
  if {[lsearch -exact [array names bs_list] [string tolower $n]] != "-1"} {
#bugfix:  let's see if the split added below fixes the eggdrop1.4.2 truncation bug
    set data [split $bs_list([string tolower $n])]
#bugfix: added a join on the $n  (c)
    set n [join [lindex $data 0]] ; set addy [lindex $data 1] ; set time [lindex $data 2] ; set marker 0
    if {([string tolower $chan] != [string tolower [lindex $data 4]] || $chan == "dcc" || $chan == "msg" || $chan == "bot") && [validchan [lindex $data 4]] && [lindex [channel info [lindex $data 4]] 23] == "+secret"} {
      set chan "-secret-"
    } {
      set chan [lindex $data 4]
    }
    switch -- [lindex $data 3] {
	part {
        set reason [lrange $data 5 e]
        if {$reason == ""} {set reason "."} {set reason " Pesan : \"$reason\"."}
        set output [concat $n ($addy) terakhir gue liat dia keluar $chan [bs_when $time] yang lalu $reason]
      }
	quit { set output [concat !4ckc $n ($addy) terakhir gue liat dia keluar IRC dari $chan [bs_when $time] yang lalu. Pesan : ([join [lrange $data 5 e]]).] }
	kick { set output [concat !4ckc $n ($addy) terakhir gue liiat dia di tendang dari $chan sama [lindex $data 5] [bs_when $time] yang lalu dengan pesan ([join [lrange $data 6 e]]).] }
	rnck {
	  set output [concat !4ckc $n ($addy) terakhir gue liat dia ganti nick dari [lindex $data 5] di [lindex $data 4] [bs_when $time] yang lalu.]
	  if {[validchan [lindex $data 4]]} {
	    if {[onchan $n [lindex $data 4]]} {
	      set output [concat !4ckc $output $n masih ada disini sekarang.]
	    } {
	      set output [concat !4ckc $output  Sekarang gue enggak liat $n tuh.]
	    }
	  }
	}
	nick {
	  set output [concat !4ckc $n ($addy) terakhir gue liat dia ganti nick ke [lindex $data 5] di [lindex $data 4] [bs_when $time] yang lalu.]
	}
	splt { set output [concat !4ckc $n ($addy) terakhir gue liat dia keluar $chan karena split server [bs_when $time] yang lalu.] }
	rejn {
	  set output [concat !4ckc $n ($addy) terakhir gue liat dia join $chan sesudah terkena split server [bs_when $time] yang lalu.]
	  if {[validchan $chan]} {if {[onchan $n $chan]} {set output [concat $output  $n masih ada di $chan.]} {set output [concat $output  Gue enggak liat $n di $chan sekarang tuh.]}}
	}
	join {
	  set output [concat !4ckc $n ($addy) terakhir gue liat dia join $chan [bs_when $time] yang lalu.]
	  if {[validchan $chan]} {if {[onchan $n $chan]} {set output [concat $output  $n masih ada di $chan.]} {set output [concat $output  Gue enggak liat $n di $chan sekarang tuh.]}}
	}
	away {
	  set reason [lrange $data 5 e]
        if {$reason == ""} {
	    set output [concat !4ckc $n ($addy) was last seen returning to the partyline on $chan [bs_when $time] ago.]
	  } {
	    set output [concat !4ckc $n ($addy) terakhir gue liat di away ($reason) di $chan [bs_when $time] yang lalu.]
	  }
	}
	chon {
	  set output [concat $n ($addy) was last seen joining the partyline [bs_when $time] ago.] ; set lnick [string tolower $n]
   foreach item [whom *] {if {$lnick == [string tolower [lindex $item 0]]} {set output [concat $output  $n is on the partyline right now.] ; set marker 1 ; break}}
	  if {$marker == 0} {set output [concat $output  I don't see $n on the partyline now, though.]}
	}
	chof {
	  set output [concat $n ($addy) was last seen leaving the partyline [bs_when $time] ago.] ; set lnick [string tolower $n]
	  foreach item [whom *] {if {$lnick == [string tolower [lindex $item 0]]} {set output [concat $output  $n is on the partyline in [lindex $item 1] still.] ; break}}
	}
	chjn {
	  set output [concat $n ($addy) was last seen joining the partyline on $chan [bs_when $time] ago.] ; set lnick [string tolower $n]
	  foreach item [whom *] {if {$lnick == [string tolower [lindex $item 0]]} {set output [concat $output  $n is on the partyline right now.] ; set marker 1 ; break}}
	  if {$marker == 0} {set output [concat $output  I don't see $n on the partyline now, though.]}
	}
	chpt {
	  set output [concat $n ($addy) was last seen leaving the partyline from $chan [bs_when $time] ago.] ; set lnick [string tolower $n]
	  foreach item [whom *] {if {$lnick == [string tolower [lindex $item 0]]} {set output [concat $output  $n is on the partyline in [lindex $item 1] still.] ; break}}
	}
	default {set output "error"}
    } ; return $output
  } {return 0}
}
proc bs_when {lasttime} {
  #This is equiv to mIRC's $duration() function
  set years 0 ; set days 0 ; set hours 0 ; set mins 0 ; set time [expr [unixtime] - $lasttime]
  if {$time < 60} {return "hanya $time detik"}
  if {$time >= 31536000} {set years [expr int([expr $time/31536000])] ; set time [expr $time - [expr 31536000*$years]]}
  if {$time >= 86400} {set days [expr int([expr $time/86400])] ; set time [expr $time - [expr 86400*$days]]}
  if {$time >= 3600} {set hours [expr int([expr $time/3600])] ; set time [expr $time - [expr 3600*$hours]]}
  if {$time >= 60} {set mins [expr int([expr $time/60])]}
  if {$years == 0} {set output ""} elseif {$years == 1} {set output "1 year,"} {set output "$years years,"}
  if {$days == 1} {lappend output "1 day,"} elseif {$days > 1} {lappend output "$days hari,"}
  if {$hours == 1} {lappend output "1 hour,"} elseif {$hours > 1} {lappend output "$hours jam,"}
  if {$mins == 1} {lappend output "1 minute"} elseif {$mins > 1} {lappend output "$mins menit"}
  return [string trimright [join $output] ", "]
}
proc bs_add {nick data} {
  global bs_list bs
  if {[lsearch -exact $bs(no_log) [string tolower [lindex $data 3]]] >= 0 || ($bs(log_only) != "" && [lsearch -exact $bs(log_only) [string tolower [lindex $data 3]]] == -1)} {return}
  set bs_list([string tolower $nick]) "[bs_filt $nick] $data"
}
bind time -  "*1 * * * *" bs_trim
proc bs_lsortcmd {a b} {global bs_list ; set a [lindex $bs_list([string tolower $a]) 2] ; set b [lindex $bs_list([string tolower $b]) 2] ; if {$a > $b} {return 1} elseif {$a < $b} {return -1} {return 0}}
proc bs_trim {min h d m y} {
  global bs bs_list ; if {![info exists bs_list] || ![array exists bs_list]} {return} ; set list [array names bs_list] ; set range [expr [llength $list] - $bs(limit) - 1] ; if {$range < 0} {return}
  set list [lsort -increasing -command bs_lsortcmd $list] ; foreach item [lrange $list 0 $range] {unset bs_list($item)}
}
proc bs_seenmask {ch nick args} {
  global bs_list bs ; set matches "" ; set temp "" ; set i 0 ; set args [join $args] ; set chan [lindex $args 1]
  if {$chan != "" && [string trimleft $chan #] != $chan} {
    if {![validchan $chan]} {return "Gue enggak pernah join $chan."} {set chan [string tolower $chan]}  } { set $chan "" }
  if {![info exists bs_list]} {return "No matches were found."} ; set data [bs_filt [string tolower [lindex $args 0]]]

#bugfix: unnecessarily complex masks essentially freeze the bot
  set maskfix 1
  while $maskfix {
    set mark 1
    if [regsub -all -- \\?\\? $data ? data] {set mark 0}
    if [regsub -all -- \\*\\* $data * data] {set mark 0}
    if [regsub -all -- \\*\\? $data * data] {set mark 0}
    if [regsub -all -- \\?\\* $data * data] {set mark 0}
    if $mark {break}
  }

  set id [array startsearch bs_list]
  while {[array anymore bs_list $id]} {
    set item [array nextelement bs_list $id] ; if {$item == ""} {continue} ; 
set i 0 ; set temp "" ; set match [lindex $bs_list($item) 0] ; set addy [lindex $bs_list($item) 1]
    if {[string match $data $item![string tolower $addy]]} {
      set match [bs_filt $match] ; if {$chan != ""} {
        if {[string match $chan [string tolower [lindex $bs_list($item) 4]]]} {set matches [concat $matches $match]}
      } {set matches [concat $matches $match]}
    }
  }
  array donesearch bs_list $id
  set matches [string trim $matches " "]
  if {$nick == "?"} {return [bs_filt $matches]}
  set len [llength $matches]
  if {$len == 0} {return "No matches were found."}
  if {$len == 1} {return [bs_output $ch $nick $matches 1]}
  if {$len > 99} {return "!4ckc Ada $len data yang cocok di database, tolong sebutkan permintaan anda lebih spesifik."}
  set matches [bs_sort $matches]
  if {$len <= 5} {
    set output [concat !4ckc Ada $len orang yang cocok (sorted): [join $matches].]
  } {
    set output "!4ckc Ada $len orang yang cocok. Ini 5 orang yang terakhir (sorted): [join [lrange $matches 0 4]]."
  }
  return [concat $output [bs_output $ch $nick [lindex [split $matches] 0] 1]]
}
proc bs_sort {data} {global bs_list ; set data [bs_filt [join [lsort -decreasing -command bs_lsortcmd $data]]] ; return $data}
bind dcc -|- seenstats bs_dccstats
proc bs_dccstats {hand idx args} {putdcc $idx "[bs_stats]"; return 1}
bind pub -|- [string trim $bs(cmdchar)]seenstats bs_pubstats
proc bs_pubstats {nick uhost hand chan args} {
  global bs ; if {[bs_flood $nick $uhost] || [lsearch -exact $bs(no_pub) [string tolower $chan]] >= 0 || ($bs(log_only) != "" && [lsearch -exact $bs(log_only) [string tolower $chan]] == -1)} {return 0}
  if {[lsearch -exact $bs(quiet_chan) [string tolower $chan]] >= 0} {set target "notice $nick"} {set target "privmsg $chan"} ; puthelp "$target :[bs_stats]" ; return 1
}
bind msg -|- seenstats bs_msgstats
proc bs_msgstats {nick uhost hand args} {global bs ; if {[bs_flood $nick $uhost]} {return 0} ; puthelp "notice $nick :[bs_stats]" ; return $bs(logqueries)}
proc bs_stats {} {
  global bs_list bs ; set id [array startsearch bs_list] ; set bs_record [unixtime] ; set totalm 0 ; set temp ""
  while {[array anymore bs_list $id]} {
    set item [array nextelement bs_list $id]
    set tok [lindex $bs_list($item) 2] ; if {$tok == ""} {putlog "Damaged seen record: $item" ; continue}
    if {[lindex $bs_list($item) 2] < $bs_record} {set bs_record [lindex $bs_list($item) 2] ; set name $item}
    set addy [string tolower [maskhost [lindex $bs_list($item) 1]]] ; if {[lsearch -exact $temp $addy] == -1} {incr totalm ; lappend temp $addy}
  }
  array donesearch bs_list $id
  return "Saya telah merekam [array size bs_list]/$bs(limit) nicks, dan telah membandingkan $totalm host yang berbeda. Database paling lama adalah [lindex $bs_list($name) 0]'s, kira kira sekitar [bs_when $bs_record] yang lalu."
}
bind dcc -|- chanstats bs_dccchanstats
proc bs_dccchanstats {hand idx args} {
  if {$args == "{}"} {set args [console $idx]}
  if {[lindex $args 0] == "*"} {putdcc $idx "$hand, chanstats requires a channel arg, or a valid console channel." ; return 1}
  putdcc $idx "[bs_chanstats [lindex $args 0]]"
  return 1
}
bind pub -|- [string trim $bs(cmdchar)]chanstats bs_pubchanstats
proc bs_pubchanstats {nick uhost hand chan args} {
  global bs ; set chan [string tolower $chan]
  if {[bs_flood $nick $uhost] || [lsearch -exact $bs(no_pub) $chan] >= 0 || ($bs(log_only) != "" && [lsearch -exact $bs(log_only) [string tolower $chan]] == -1)} {return 0}
  if {[lsearch -exact $bs(quiet_chan) $chan] >= 0} {set target "notice $nick"} {set target "privmsg $chan"}
  if {[lindex $args 0] != ""} {set chan [lindex $args 0]} ; puthelp "$target :[bs_chanstats $chan]" ; return $bs(logqueries)
}
bind msg -|- chanstats bs_msgchanstats
proc bs_msgchanstats {nick uhost hand args} {global bs ; if {[bs_flood $nick $uhost]} {return 0} ; puthelp "notice $nick :[bs_chanstats [lindex $args 0]]" ; return $bs(logqueries)}
proc bs_chanstats {chan} {
  global bs_list ; set chan [string tolower $chan] ; if {![validchan $chan]} {return "Gue enggak di $chan."}
  set id [array startsearch bs_list] ; set bs_record [unixtime] ; set totalc 0 ; set totalm 0 ; set temp ""
  while {[array anymore bs_list $id]} {
    set item [array nextelement bs_list $id] ; set time [lindex $bs_list($item) 2] ; if {$time == ""} {continue}
    if {$chan == [string tolower [lindex $bs_list($item) 4]]} {
      if {$time < $bs_record} {set bs_record $time} ; incr totalc
      set addy [string tolower [maskhost [lindex $bs_list($item) 1]]]
      if {[lsearch -exact $temp $addy] == -1} {incr totalm ; lappend temp $addy}
    }
  }
  array donesearch bs_list $id ; set total [array size bs_list]
  return "$chan database sebanyak [expr 100*$totalc/$total]% ($totalc/$total) dari keseluruhan database yang ada. Di $chan, terdapat database total sebanyak $totalm host yang telah tersimpan dalam waktu [bs_when $bs_record]."
}
foreach chan [string tolower [channels]] {if {![info exists bs_botidle($chan)]} {set bs_botidle($chan) [unixtime]}}
bind join -|- * bs_join_botidle
proc bs_join_botidle {nick uhost hand chan} {
  global bs_botidle botnick
  if {$nick == $botnick} {
   set bs_botidle([string tolower $chan]) [unixtime]
  }
}
bind pub -|- [string trim $bs(cmdchar)]lastspoke lastspoke

#bugfix: fixed lastspoke to handle [blah] nicks better (c)
proc lastspoke {nick uhost hand chan args} {
  global bs botnick bs_botidle
  set chan [string tolower $chan] ; if {[bs_flood $nick $uhost] || [lsearch -exact $bs(no_pub) $chan] >= 0 || ($bs(log_only) != "" && [lsearch -exact $bs(log_only) $chan] == -1)} {return 0}
  if {[lsearch -exact $bs(quiet_chan) $chan] >= 0} {set target "notice $nick"} {set target "privmsg $chan"}
  set data [lindex [bs_filt [join $args]] 0]
  set ldata [string tolower $data]
  if {[string match *\** $data]} {
    set chanlist [string tolower [chanlist $chan]]
    if {[lsearch -glob $chanlist $ldata] > -1} {set data [lindex [chanlist $chan] [lsearch -glob $chanlist $ldata]]}
  }
  if {[onchan $data $chan]} {
    if {$ldata == [string tolower $botnick]} {puthelp "$target :$nick, must you waste my time?" ; return 1}
    set time [getchanidle $data $chan] ; set bottime [expr ([unixtime] - $bs_botidle($chan))/60]
    if {$time < $bottime} {
      if {$time > 0} {set diftime [bs_when [expr [unixtime] - $time*60 -15]]} {set diftime "kurang lebih semenit"}
      puthelp "$target :$data terakhir berbicara di $chan $diftime yang lalu."
    } {
      set diftime [bs_when $bs_botidle($chan)]
      puthelp "$target :$data tidak berbicara apapun sejak gue join $chan $diftime yang lalu."
    }
  }
  return 1
}
bind msgm -|- "help seen" bs_help_msg_seen
bind msgm -|- "help chanstats" bs_help_msg_chanstats
bind msgm -|- "help seenstats" bs_help_msg_seenstats
proc bs_help_msg_seen {nick uhost hand args} {
  global bs ; if {[bs_flood $nick $uhost]} {return 0}
  puthelp "notice $nick :###  seen <query> \[chan\]          $bs(version)"
  puthelp "notice $nick :   Queries can be in the following formats:"
  puthelp "notice $nick :     'regular':  seen lamer; seen lamest "
  puthelp "notice $nick :     'masked':   seen *l?mer*; seen *.lame.com; seen *.edu #mychan" ; return 0
}
proc bs_help_msg_chanstats {nick uhost hand args} {
  global bs ; if {[bs_flood $nick $uhost]} {return 0}
  puthelp "notice $nick :###  chanstats <chan>          $bs(version)"
  puthelp "notice $nick :   Returns the usage statistics of #chan in the seen database." ; return 0
}
proc bs_help_msg_seenstats {nick uhost hand args} {
  global bs ; if {[bs_flood $nick $uhost]} {return 0}
  puthelp "notice $nick :###  seenstats          $bs(version)"
  puthelp "notice $nick :   Returns the status of the bseen database." ; return 0
}
bind dcc -|- seenversion bs_version
proc bs_version {hand idx args} {global bs ; putidx $idx "###  Bass's Seen script, $bs(version)."}
bind dcc -|- help bs_help_dcc
proc bs_help_dcc {hand idx args} {
  global bs
  switch -- $args {
    seen {
      putidx $idx "###  seen <query> \[chan\]          $bs(version)" ; putidx $idx "   Queries can be in the following formats:"
      putidx $idx "     'regular':  seen lamer; seen lamest " ; putidx $idx "     'masked':   seen *l?mer*; seen *.lame.com; seen *.edu #mychan"
    }
    seennick {putidx $idx "###  seen <nick>          $bs(version)"}
    chanstats {putidx $idx "###  chanstats <chan>" ; putidx $idx "   Returns the usage statistics of #chan in the seen database."}
    seenstats {putidx $idx "###  seenstats          $bs(version)" ; putidx $idx "   Returns the status of the bseen database."}
    unseen {if {[matchattr $hand n]} {putidx $idx "###  unseen <chan> $bs(version)" ; putidx $idx "   Deletes all <chan> entries from the bseen database."}}
    default {*dcc:help $hand $idx [join $args] ; return 0}
  } ; return 1
}

### END OF SCRIPT

putlog "!4ckc .....Seen Tcl for cokkie Bot Loaded.....!! !4ckc"

command: """
IFS='|' read -r theArtist theName <<<"$(osascript <<<'if application "iTunes" is running then
	tell application "iTunes"
		if player state is playing then
			try
				set theTrack to current track
				set theArtist to artist of theTrack
				set theName to name of theTrack
				return theName & "|" & theArtist
			on error
				return "iTunes Radio | is playing"
			end try
		end if
	end tell
end if
if application "Spotify" is running then
	tell application "Spotify"
		if player state is playing then
			try
				set theTrack to current track
				set theArtist to artist of theTrack
				set theName to name of theTrack
				return theName & "|" & theArtist
			on error
				return "Oops something | went wrong"
			end try
		end if
	end tell
end if')"
echo "$theName | $theArtist"
"""

refreshFrequency: 2000

style: """
    bottom: 8%
    left: 50%
    color: #fff
    bottom: 1%
    width: 1000px
    margin-left: -(@width/2)
    text-align: center
    font-size: 2.5em
    font-weight: 100
    text-shadow: 0 1px 5px #000000;

    *
        font-family: Helvetica Neue

    #two
        color: orange
"""

render: (output) -> """
    <div id="zero" class="some-class">&nbsp</div>
    <div id="one" class="some-class"></div>
    <div id="two" class="some-class"></div>
"""

update: (output, domEl) ->
    playing = output.split(' | ')
    longTitle = playing[1].split(' - ')
    $(domEl).find("#one").html playing[1]
    $(domEl).find("#two").html playing[0]

# quip-todo-reader

As a people manager I do my share of one on one meetings with my direct reports, skip level reports, peers, and random folks across my company.

I like to take notes in these meetings in files that I only share with the person I meet with.  I tend to transcribe things in the conversation as we go, because of this I'm not apt to pickup a pen and jot down a todo item, yes I keep my todo list in paper... mostly.

Either during the meeting or afterwords I'll move action items to a seciton near the top of the document typically labeled "Action Items" or "Outstanding Actions".

Currently my Active One on One folder contains about 40 some odd documents, and I typically open them right before my meeting with said individual.  Problem:  the action items are still undone...

So I wrote this simple (and horrible) scrpt to read all the documents in my One on One folder and output the contents of the Actions seciton.

This is a simple ruby script written with several Gems and no real engineering dilligence applied (sorry).

## Assumptions

1. You already know what Quip is... if not checkout [Quip.com](https://quip.com/)
2. You have a problem similar to what I've described above

## Technology used
1. Ruby 2.5.1
2. [Nokogiri](https://github.com/sparklemotion/nokogiri)
3. dotenv
4. [colorize](https://github.com/fazibear/colorize)
5. [quip-ruby](https://github.com/wokejacqueline/quip-ruby)

## Setup
1. Clone repo
2. copy .env.sample to .env and update accordingly
3. bundle install
3. ruby list.rb

### values for the .env file

QUIP_TOKEN - you can get this by visiting quip.com/dev/token while logged into your quip account.

FOLDER_ID - this is the ID portion of the URL for the quip folder you want to read documents from.  You can navigate to your folder and then copy the portion of the URL after the final slash to get this value.

SELF - this value I use to parse out of document names, it is a comma separated list but I use it so when the document is output to the screen it doesn't contain my name repeated in every file, I include my name as a curteousy to those I share the document with.

ACTIONS - a comma separated list, if you inconsistently title your Action Items, or Outstanading Actions section

NEXT - a comma separated list, if you inconsistently title your Next Time section

## Sample output - not colorized
```
$ ruby list.rb
There are 2 items in your 'One on Ones' Folder.
Coby / Aaron 1:1 Notes - November 13, 2018 @ 19:51 -0800 - Aaron - 1, 1 - https://confreaks.quip.com/GjOMAbs75E5U
	Commitments
		find open source gig
	Next Time
		SEA-TAC Airport YouTube Facebook aka “choo choo”
Coby / Karen 1:1 Notes - November 13, 2018 @ 19:48 -0800 - Karen - 1, 1 - https://confreaks.quip.com/RxfTAufodN6r
	Commitments
		Coby - Investigate and report back on the cause of solar flares
	Next Time
		How the world turns
```
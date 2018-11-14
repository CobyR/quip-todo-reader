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
3. ruby list.rb



# Description:
#   Get a meme from http://memecaptain.com/ trololo
#
# Dependencies:
#   None
#
# Commands:
#   <thing> Y U NO <text> - Generates the Y U NO GUY with the bottom caption of <text>
#   I don't always <something> but when i do <text> - Generates The Most Interesting man in the World
#   <text> (SUCCESS|NAILED IT) - Generates success kid with the top caption of <text>
#   <text> ALL the <things>    - Generates ALL THE THINGS
#   <text> TOO DAMN <high> - Generates THE RENT IS TOO DAMN HIGH guy
#   Not sure if <text> or <text> - Generates Futurama Fry
#   Yo dawg <text> so <text> - Generates Yo Dawg
#   ALL YOUR <text> ARE BELONG TO US - Generates Zero Wing with the caption of <text>
#   <text>, BITCH PLEASE <text> - Generates Yao Ming
#   <text>, COURAGE <text> - Generates Courage Wolf
#   ONE DOES NOT SIMPLY <text> - Generates Boromir
#   IF YOU <text> GONNA HAVE A BAD TIME - Ski Instructor
#
# Author:
#   bobanj

module.exports = (robot) ->
  robot.hear /(.*)\s?Y U NO (.+)/i, (msg) ->
    memeGenerator msg, 'y_u_no.jpg', msg.match[1], 'Y U NO ' + msg.match[2], (url) ->
      msg.send url

  robot.hear /(.*) (ALL the .*)/i, (msg) ->
    memeGenerator msg, 'all_the_things.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(I DON'?T ALWAYS .*) (BUT WHEN I DO,? .*)/i, (msg) ->
    memeGenerator msg, 'most_interesting.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(.*)(SUCCESS|NAILED IT.*)/i, (msg) ->
    memeGenerator msg, 'success_kid.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(.*) (\w+\sTOO DAMN .*)/i, (msg) ->
    memeGenerator msg, 'too_damn_high.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(NOT SURE IF .*) (OR .*)/i, (msg) ->
    memeGenerator msg, 'fry.png', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(YO DAWG .*) (SO .*)/i, (msg) ->
    memeGenerator msg, 'xzibit.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(.*)\s*BITCH PLEASE\s*(.*)/i, (msg) ->
    memeGenerator msg, 'yao_ming.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(.*)\s*COURAGE\s*(.*)/i, (msg) ->
    memeGenerator msg, 'courage_wolf.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /ONE DOES NOT SIMPLY (.*)/i, (msg) ->
    memeGenerator msg, 'boromir.jpg', 'ONE DOES NOT SIMPLY', msg.match[1], (url) ->
      msg.send url

  robot.hear /(IF YOU .*\s)(.* GONNA HAVE A BAD TIME)/i, (msg) ->
    memeGenerator msg, 'bad_time.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.respond /ALIENS (.*)/i, (msg) ->
    memeGenerator msg, 'aliens.jpg', '', msg.match[1], (url) ->
      msg.send url
###
  robot.hear /(.*)TROLLFACE(.*)/i, (msg) ->
    memeGenerator msg, 'troll_face.jpg', msg.match[1], msg.match[2], (url) ->
      msg.send url

  robot.hear /(IF .*), ((ARE|CAN|DO|DOES|HOW|IS|MAY|MIGHT|SHOULD|THEN|WHAT|WHEN|WHERE|WHICH|WHO|WHY|WILL|WON\'T|WOULD)[ \'N].*)/i, (msg) ->
    memeGenerator msg, 'philosoraptor.jpg', msg.match[1], msg.match[2] + (if msg.match[2].search(/\?$/)==(-1) then '?' else ''), (url) ->
      msg.send url
###


memeGenerator = (msg, imageName, text1, text2, callback) ->
  imageUrl = "http://memecaptain.com/" + imageName
  msg.http("http://memecaptain.com/g")
  .query(
    u: imageUrl,
    t1: text1,
    t2: text2
  ).get() (err, res, body) ->
    return msg.send err if err
    result = JSON.parse(body)
    if result? and result['imageUrl']?
      callback result['imageUrl']
    else
      msg.reply "Sorry, I couldn't generate that meme."




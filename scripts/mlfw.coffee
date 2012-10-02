# Description:
#   mlfw shows pictures from mylittlefacewhen.com
#
# Commands:
#   mlfw      - Displays a random mlfw image
#   mlfw tags - Display images for a given tag

module.exports = (robot) ->

  robot.hear /(mlfw|my little face when)\s?(.*)/i, (msg) ->
    search = if msg.match[2] then 'search=["'+msg.match[2]+'"]&' else ''
    url = encodeURI 'http://mylittlefacewhen.com/api/v2/face/?'+search+'order_by=random&format=json'
    msg.http(url)
      .get() (err, res, body) ->
        if not err and res.statusCode is 200
          try
            data = JSON.parse(body)
            if data.objects? and data.objects.length > 0
              msg.send 'http://mylittlefacewhen.com' + data.objects[0].image
            else
              msg.send 'MLFW: No images found'
          catch e
            console.log e

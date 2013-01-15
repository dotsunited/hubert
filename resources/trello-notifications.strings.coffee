module.exports =
    # create card
    createdCard: (notification) -> "#{notification.memberCreator.fullName} created '#{notification.data.card.name}' in '#{notification.data.list.name}' on '#{notification.data.board.name}'."
    
    # card changed
    changeCard:
        # change description
        desc: (notification) -> "#{notification.memberCreator.fullName} updated the decription of the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
        # change due date
        due: (notification) -> 
            date = new Date(notification.data.card.due)
            datestring = "#{if date.getDate() < 10    then '0'+date.getDate()     else date.getDate()}.#{date.getMonth()+1}.#{date.getFullYear()} #{if date.getHours() < 10   then '0'+date.getHours()    else date.getHours()}:#{if date.getMinutes() < 10 then '0'+date.getMinutes()  else date.getMinutes()}"

            "#{notification.memberCreator.fullName} changed the due date on the card '#{notification.data.card.name}' on '#{notification.data.board.name}' to #{datestring}."
        # (un)archive card
        closed: (notification) -> 
            if notification.data.card.closed is true
                "#{notification.memberCreator.fullName} archived the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
            else
                "#{notification.memberCreator.fullName} unarchived the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
        # move card
        idList: (notification) -> "#{notification.memberCreator.fullName} moved the card '#{notification.data.card.name}' from '#{notification.data.listBefore.name}' to '#{notification.data.listAfter.name}' on '#{notification.data.board.name}'."

    addedAttachmentToCard: (notification) -> "#{notification.memberCreator.fullName} attached '#{notification.data.name}' to #{notification.data.card.name} on '#{notification.data.board.name}'."
    
    # comment added
    commentCard: (notification) -> [
        "#{notification.memberCreator.fullName} commented on the card '#{notification.data.card.name}' on '#{notification.data.board.name}'",
        "Message: #{notification.data.text}"
    ]

    # member to card
    addedMemberToCard: (notification) -> "#{notification.memberCreator.fullName} assigned #{notification.member.fullName} to the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
    removedMemberFromCard: (notification) -> "#{notification.memberCreator.fullName} removed #{notification.member.fullName} from the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
    
    # in case the bot gets added to a card
    addedToCard: (notification) -> "#{notification.memberCreator.fullName} added me to the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."
    removedFromCard: (notification) -> "#{notification.memberCreator.fullName} removed me from the card '#{notification.data.card.name}' on '#{notification.data.board.name}'."

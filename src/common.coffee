AccountsAurin =

  addCollectionAuthorization: (collection) ->
    if Meteor.isServer
      name = Collections.getName(collection)
      # Only publish documents belonging to the logged in user.
      Meteor.publish name, ->
        userId = this.userId
        return unless userId
        user = Meteor.users.findOne(userId)
        username = user.username
        if username == 'admin'
          # Admin can see all docs.
          collection.find()
        else
          collection.find({author: username})

    # Add the logged in user as the author when a doc is created in the collection.
    collection.before.insert (userId, doc) ->
      doc.author = Meteor.user()?.username

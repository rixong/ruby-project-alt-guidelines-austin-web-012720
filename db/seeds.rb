# User.create(first_name: "Bob", last_name: "Smith", email_address: "bob@me.com", password: "milk")
# User.create(first_name: "Ann", last_name: "Jones", email_address: "ann@you.com", password: "bread")
# User.create(first_name: "Pete", last_name: "Hale", email_address: "pete@us.com", password: "cheese")


User.create(first_name: "Abe", last_name: "Smith", email_address: "a", password: "a")
User.create(first_name: "Bob", last_name: "Jones", email_address: "b", password: "b")
User.create(first_name: "Cathy", last_name: "Hale", email_address: "c", password: "c")

Event.create(title: "BorderLaughs Comedy Vol. 6", date: "01/11", category: "Comedy", api_id: 11298330)
Event.create(title: "Avery Moore (Live Album Recording)", date: "01/11", category: "Comedy", api_id: 11298330)
Event.create(title: "lizabeth Spears with Andrew Clarkston", date: "01/11", category: "Comedy", api_id: 11350292)
Event.create(title: "Free Week: Misery: The Film featuring Black Heart Saints", date: "01/12", category: "Music", api_id: 11431394)
Event.create(title: "Downtown Comedy Night", date: "01/12", category: "Comedy", api_id: 11470245)
Event.create(title: "Warthog, Wiccans, Criaturas, Ninth Circle, Boofin Tylenol", date: "01/12", category: "Music", api_id: 11411285)


Schedule.create(date: "01/11", event_id: 1, user_id: 1)
Schedule.create(date: "01/12", event_id: 2, user_id: 1)
Schedule.create(date: "01/13", event_id: 3, user_id: 1)
Schedule.create(date: "01/14", event_id: 4, user_id: 2)
Schedule.create(date: "01/15", event_id: 5, user_id: 2)
Schedule.create(date: "01/16", event_id: 6, user_id: 2)
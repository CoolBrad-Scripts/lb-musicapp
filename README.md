![Intro Card](https://docs.coolbrad.com/images/README/CB-MusicApp.png)

## Description
A YouTube Music app built for LB-Phone. Allow players in your community to listen to ANY YouTube video using their in-city phone! This application allows users to save songs to a playlist for easy access at a later time!

## Features:
- Play ANY YouTube from URL
- Save Songs


## Dependencies
- LB-Phone
- YouTube API Key

# Installation
Run the following SQL Query on your server

```sql
CREATE TABLE IF NOT EXISTS `lb_music` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenID` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
```

# Help and Support
If you require any assistance with this script or run into any issues, I would be happy to assist you. Please open a ticket in my [Discord](https://discord.gg/FQtN5FXcG5)